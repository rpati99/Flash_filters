//
//  GrainVC+Extensions.swift
//  Flash_submission_Rachit_P
//
//  Created by Rachit Prajapati on 10/17/24.
//

import UIKit

extension ViewController {
    
    func applyGrainWithIntensity(level: Intensity) {
        var intensity: CGFloat
        
        switch level {
        case .low:
            intensity = 0.1  // Low intensity
        case .medium:
            intensity = 0.5  // Medium intensity
        case .high:
            intensity = 1.0  // High intensity
        }
        
        if let image = selectedImage {
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                let grainyImage = applyGrain(to: image, intensity: intensity)
                DispatchQueue.main.async { [self] in
                    imageView.image = grainyImage
                }
            }
            }

    }
    
   
    
    func applyGrain(to image: UIImage, intensity: CGFloat) -> UIImage? {
        let context = CIContext()

        // Convert the UIImage to a CIImage
        guard let cgImage = image.cgImage else { return nil }
        let ciImage = CIImage(cgImage: cgImage)
        
        // Step 1: Generate random noise using CIRandomGenerator
        let randomNoise = CIFilter(name: "CIRandomGenerator")!
        let noiseImage = randomNoise.outputImage!
        
        // Step 2: Apply whitening to the noise to simulate grain
        let whitenVector = CIVector(x: 0, y: 1, z: 0, w: 0)  // White for R, G, B
        let fineGrain = CIVector(x: 0, y: intensity * 0.005, z: 0, w: 0)  // Adjust Alpha channel based on intensity
        let zeroVector = CIVector(x: 0, y: 0, z: 0, w: 0)     // Zero bias
        
        let whiteningFilter = CIFilter(name: "CIColorMatrix")!
        whiteningFilter.setValue(noiseImage, forKey: kCIInputImageKey)
        whiteningFilter.setValue(whitenVector, forKey: "inputRVector")
        whiteningFilter.setValue(whitenVector, forKey: "inputGVector")
        whiteningFilter.setValue(whitenVector, forKey: "inputBVector")
        whiteningFilter.setValue(fineGrain, forKey: "inputAVector")
        whiteningFilter.setValue(zeroVector, forKey: "inputBiasVector")
        
        let whiteSpecks = whiteningFilter.outputImage
        
        // Step 3: Composite the grain over the original image
        let speckCompositor = CIFilter(name: "CISourceOverCompositing")!
        speckCompositor.setValue(whiteSpecks, forKey: kCIInputImageKey)
        speckCompositor.setValue(ciImage, forKey: kCIInputBackgroundImageKey)
        
        if let speckledImage = speckCompositor.outputImage,
           let cgImage = context.createCGImage(speckledImage, from: ciImage.extent) {
            return UIImage(cgImage: cgImage, scale: image.scale, orientation: image.imageOrientation)
        }
        
        return nil
    }
}

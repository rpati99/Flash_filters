//
//  ScratchVC+Extensions.swift
//  Flash_submission_Rachit_P
//
//  Created by Rachit Prajapati on 10/17/24.
//

import Foundation
import UIKit

public extension ViewController {
    
    func applyScratchWithIntensity(level: Intensity) {
        var intensity: Float
        
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
                let scratchyImage = applyScratches(to: image, intensity: intensity)
                DispatchQueue.main.async { [self] in
                    imageView.image = scratchyImage
                }
            }
        }
        
    }

    
    func applyScratches(to image: UIImage, intensity: Float) -> UIImage? {
        let context = CIContext()
        
        // Convert the UIImage to a CIImage
        guard let cgImage = image.cgImage else { return nil }
        let ciImage = CIImage(cgImage: cgImage)
        
        // Step 1: Generate random noise using CIRandomGenerator
        let randomNoise = CIFilter(name: "CIRandomGenerator")!
        guard let noiseImage = randomNoise.outputImage else { return image }  // Ensure noise generation works
        
        // Step 2: Stretch the noise vertically to simulate scratches
        let verticalScale = CGAffineTransform(scaleX: 1.0, y: 30.0 * CGFloat(intensity))  // Play with scaling values for visibility
        let stretchedNoise = noiseImage.transformed(by: verticalScale)
        
        // Step 3: Darken the noise to simulate scratches
        let darkeningFilter = CIFilter(name: "CIColorMatrix")!
        let darkenVector = CIVector(x: 0.5, y: 0, z: 0, w: 0)  // Darken red component more for visibility
        let zeroVector = CIVector(x: 0, y: 0, z: 0, w: 0)
        let darkenBias = CIVector(x: 0, y: 1, z: 1, w: 1)     // Transparent background with dark scratches
        
        darkeningFilter.setValue(stretchedNoise, forKey: kCIInputImageKey)
        darkeningFilter.setValue(darkenVector, forKey: "inputRVector")
        darkeningFilter.setValue(zeroVector, forKey: "inputGVector")
        darkeningFilter.setValue(zeroVector, forKey: "inputBVector")
        darkeningFilter.setValue(zeroVector, forKey: "inputAVector")
        darkeningFilter.setValue(darkenBias, forKey: "inputBiasVector")
        
        guard let darkScratches = darkeningFilter.outputImage else { return image }
        
        // Step 4: Grayscale the scratches
        let grayscaleFilter = CIFilter(name: "CIMinimumComponent")!
        grayscaleFilter.setValue(darkScratches, forKey: kCIInputImageKey)
        guard let grayscaleScratches = grayscaleFilter.outputImage else { return image }
        
        // Step 5: Composite the scratches onto the original image
        let scratchCompositor = CIFilter(name: "CIMultiplyCompositing")!
        scratchCompositor.setValue(grayscaleScratches, forKey: kCIInputImageKey)
        scratchCompositor.setValue(ciImage, forKey: kCIInputBackgroundImageKey)
        
        // Step 6: Return the final composited image
        if let finalImage = scratchCompositor.outputImage,
           let cgImage = context.createCGImage(finalImage, from: ciImage.extent) {
            return UIImage(cgImage: cgImage, scale: image.scale, orientation: image.imageOrientation)
        }
        
        return image
    }
}

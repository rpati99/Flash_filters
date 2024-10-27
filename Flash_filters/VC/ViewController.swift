//
//  ViewController.swift
//  Flash_submission_Rachit_P
//
//  Created by Rachit Prajapati on 10/17/24.
//

import UIKit
import CoreImage

public final class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // UI Elements
    internal let imageView : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    

    private let grainIndicatorLabel: UILabel = {
        let label = UILabel(text: "Grain Effect slider", color: .red)
        return label
    }()
    
    
    private let scratchIndicatorLabel: UILabel = {
        let label = UILabel(text: "Scratch Effect slider", color: .blue)
        return label
    }()
    
    
    private lazy var grainControl: UISegmentedControl = {
        let grainControl = UISegmentedControl(items: ["Low", "Medium", "High"])
        grainControl.addTarget(self, action: #selector(grainIntensityChanged), for: .valueChanged)
        return grainControl
    }()
    
    private lazy var scratchControl: UISegmentedControl = {
        let scratchControl = UISegmentedControl(items: ["Low", "Medium", "High"])
        scratchControl.addTarget(self, action: #selector(scratchIntensityChanged), for: .valueChanged)
        return scratchControl
    }()
    
    
    internal var selectedImage: UIImage? {
        didSet {
            imageView.image = selectedImage
        }
    }
    
    private lazy var selectImageBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Image", for: .normal)
        button.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
        return button
    }()
    
    // Application lifecycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // setup image view
        view.addSubview(imageView)
        imageView.anchor(top: view.topAnchor, paddingTop: 100, width: UIScreen.main.bounds.width * 0.8, height: 300)
        imageView.centerX(inView: view)
        
        
        // setup effect control
        view.addSubview(grainControl)
        grainControl.anchor(top: imageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)

        view.addSubview(grainIndicatorLabel)
        grainIndicatorLabel.anchor(left: view.leftAnchor, bottom: grainControl.topAnchor, paddingLeft: 20, paddingBottom: 8)
        
        view.addSubview(scratchControl)
        scratchControl.anchor(top: grainControl.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 20, paddingRight: 20)
        
        view.addSubview(scratchIndicatorLabel)
        scratchIndicatorLabel.anchor(left: view.leftAnchor, bottom: scratchControl.topAnchor, paddingLeft: 20, paddingBottom: 8)
        
        
        // setup photo selection button
        view.addSubview(selectImageBtn)
        selectImageBtn.anchor(top: scratchControl.bottomAnchor, paddingTop: 40)
        selectImageBtn.centerX(inView: view)
    }
    
    
    // Selector handlers
    @objc private func grainIntensityChanged() {
        let selectedIndex = grainControl.selectedSegmentIndex

        // Call the function based on selected intensity
        switch selectedIndex {
        case 0:
            applyGrainWithIntensity(level: .low)
        case 1:
            applyGrainWithIntensity(level: .medium)
        case 2:
            applyGrainWithIntensity(level: .high)
        default:
            break
        }
    }
    
    @objc private func scratchIntensityChanged() {
        let selectedIndex = scratchControl.selectedSegmentIndex

        // Call the function based on selected intensity
        switch selectedIndex {
        case 0:
            applyScratchWithIntensity(level: .low)
        case 1:
            applyScratchWithIntensity(level: .medium)
        case 2:
            applyScratchWithIntensity(level: .high)
        default:
            break
        }
    }
    
    @objc private func selectImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
    }
}



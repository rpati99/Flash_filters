//
//  ImageControllerVC+Extensions.swift
//  Flash_submission_Rachit_P
//
//  Created by Rachit Prajapati on 10/17/24.
//

import Foundation
import UIKit

public extension ViewController {
    
    // ImagePickerController delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.originalImage] as? UIImage {
            selectedImage = image
            imageView.image = image
        }
    }
}

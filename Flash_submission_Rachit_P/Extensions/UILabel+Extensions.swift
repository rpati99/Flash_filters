//
//  UILabel+Extensions.swift
//  Flash_submission_Rachit_P
//
//  Created by Rachit Prajapati on 10/17/24.
//

import Foundation
import UIKit

// For reusable buttons
extension UILabel {
        // Convenience initializer for setting text and color
        convenience init(text: String, color: UIColor) {
            self.init()
            self.text = text
            self.textColor = color
            self.textAlignment = .center // Optional, can adjust as needed
            self.translatesAutoresizingMaskIntoConstraints = false // For Auto Layout
        }

        // Method to update label's text and color
        func configure(withText text: String, color: UIColor) {
            self.text = text
            self.textColor = color
        }
}

//
//  Extensions.swift
//  Flash_submission_Rachit_P
//
//  Created by Rachit Prajapati on 10/17/24.
//

import UIKit

//Extension for simplifying constraint call.
extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func center(inView view: UIView, yConstant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
    }
    
    func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
        }
    }
    
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil, paddingLeft: CGFloat? = nil, constant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant!).isActive = true
        
        if let leftAnchor = leftAnchor, let padding = paddingLeft {
            self.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
        }
    }
    
    func setDimensions(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func addConstraintsToFillView(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        anchor(top: view.topAnchor, left: view.leftAnchor,
               bottom: view.bottomAnchor, right: view.rightAnchor)
    }
}


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

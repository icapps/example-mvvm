//
//  LoginTextField.swift
//  Login
//
//  Created by Jelle Vandebeeck on 04/07/16.
//  Copyright © 2016 iCapps. All rights reserved.
//

import UIKit

@IBDesignable class LoginTextField: UITextField {
    
    // MARK: - Properties
    
    @IBInspectable var borderColor: UIColor = UIColor.redColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: - Drawing
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, borderColor.CGColor)
        let borderRect = CGRect(x: 0, y: rect.size.height - borderWidth, width: rect.size.width, height: borderWidth)
        CGContextFillRect(context, borderRect)
    }
    
}
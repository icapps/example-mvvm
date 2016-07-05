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
    
    @IBInspectable var disabledBorderColor: UIColor = UIColor.grayColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: - Highlight
    
    override var userInteractionEnabled: Bool {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: - Drawing
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        if userInteractionEnabled {
            CGContextSetFillColorWithColor(context, borderColor.CGColor)
        } else {
            CGContextSetFillColorWithColor(context, disabledBorderColor.CGColor)
        }
        let borderRect = CGRect(x: 0, y: rect.size.height - borderWidth, width: rect.size.width, height: borderWidth)
        CGContextFillRect(context, borderRect)
    }
    
}
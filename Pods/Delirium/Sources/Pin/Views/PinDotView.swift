//
//  PinView.swift
//  Delirium
//
//  Created by Jelle Vandebeeck on 13/06/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class PinDotView: UIView {
    
    // MARK: - Configuration
    
    var configuration = PinConfiguration() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: - Layout Configuration
    
    private let dotSize: CGFloat = 12.0
    private let dotPadding: CGFloat = 12.0
    
    // MARK: - Size
    
    var currentSize: Int = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: - Size
    
    override func intrinsicContentSize() -> CGSize {
        let width: CGFloat = dotSize * CGFloat(configuration.numberOfDigits) + (dotPadding * (CGFloat(configuration.numberOfDigits) - 1))
        return CGSize(width: width, height: dotSize)
    }
    
    // MARK: - Drawing
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        var previousBubbleRect: CGRect? = nil
        for index in 0..<configuration.numberOfDigits {
            var x: CGFloat = 0
            if let previousBubbleRect = previousBubbleRect {
                x = CGRectGetMaxX(previousBubbleRect) + dotPadding
            }
            let rect = CGRect(x: x, y: 0, width: dotSize, height: dotSize)
            previousBubbleRect = rect
            
            if index >= currentSize {
                CGContextSetFillColorWithColor(context, configuration.dotStrokeColor.CGColor)
                CGContextFillEllipseInRect(context, rect)
                CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
                CGContextFillEllipseInRect(context, CGRectInset(rect, 0.5, 0.5))
            } else {
                CGContextSetFillColorWithColor(context, configuration.dotColor.CGColor)
                CGContextFillEllipseInRect(context, rect)
            }
        }
    }
    
}
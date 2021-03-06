//
//  UIViewX.swift
//  DesignableX
//
//  Created by Mark Moeykens on 12/31/16.
//  Copyright © 2016 Mark Moeykens. All rights reserved.
//

import UIKit

@IBDesignable
extension UIView {
    
    // MARK: - Border
    
    @IBInspectable open var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        } set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable open var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        } set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable open var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            layer.cornerRadius = newValue
        }
    }
    
    // MARK: - Shadow
    
    @IBInspectable open var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        } set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable open var shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else {
                return nil
            }
            return UIColor(cgColor: color)
        } set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable open var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        } set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable open var shadowOffset: CGPoint {
        get {
            return CGPoint(x: layer.shadowOffset.width, y: layer.shadowOffset.height)
        } set {
            layer.shadowOffset.width = newValue.x
            layer.shadowOffset.height = newValue.y
        }
    }
}
extension UIStackView {
    public func animateStack(completionBlock: (() -> Void)? = nil, withOptionalAnimations animations: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.2,
                       animations: { [weak self] in
                        animations?()
                        self?.setNeedsLayout()
                        self?.layoutIfNeeded()
            },
                       completion: { (_) in
                        completionBlock?()
        })
    }
}

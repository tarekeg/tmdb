//
//  UIView+Extensions.swift
//  tmbd
//
//  Created by Tarek El Ghoul on 28/10/2023.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}

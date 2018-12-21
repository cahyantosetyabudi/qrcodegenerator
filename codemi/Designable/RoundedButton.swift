//
//  RoundedButton.swift
//  codemi
//
//  Created by Cahyanto Setya Budi on 12/21/18.
//  Copyright © 2018 Cahyanto Setya Budi. All rights reserved.
//

import UIKit

@IBDesignable class RoundedButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = .lightText {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
}

//
//  RoundedField.swift
//  codemi
//
//  Created by Cahyanto Setya Budi on 12/21/18.
//  Copyright © 2018 Cahyanto Setya Budi. All rights reserved.
//

import UIKit

@IBDesignable class RoundedField: UITextField {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
        
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowColor: UIColor = .lightGray {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOppacity: Float = 0.0 {
        didSet {
            self.layer.shadowOpacity = shadowOppacity
        }
    }
    
    override func draw(_ rect: CGRect) {
        self.borderStyle = .none
        self.layer.masksToBounds = false
        //        self.clipsToBounds = true
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
        self.leftViewMode = UITextFieldViewMode.always
    }
}

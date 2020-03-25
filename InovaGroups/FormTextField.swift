//
//  UITextField.swift
//  InovaGroups
//
//  Created by Matheus Amendola on 21/03/20.
//  Copyright © 2020 Matheus Amendola. All rights reserved.
//

import Foundation

@IBDesignable
class FormTextField: UITextField {

    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
}

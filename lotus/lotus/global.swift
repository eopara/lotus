//
//  global.swift
//  lotus
//
//  Created by Cory Dickson on 8/9/15.
//
//

import Foundation
import UIKit


func styleTextField(textField: UITextField, borderWidth: CGFloat, borderColor: CGColor) {
    let border = CALayer()
    let width = CGFloat(borderWidth)
    border.borderColor = borderColor
    border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width:  textField.frame.size.width, height: textField.frame.size.height)
    
    border.borderWidth = width
    textField.layer.addSublayer(border)
    textField.layer.masksToBounds = true
    
}


//
//  global.swift
//  lotus
//
//  Created by Cory Dickson on 8/9/15.
//
//

import Foundation
import UIKit

//


func styleTextField(textField: UITextField, borderWidth: CGFloat, borderColor: CGColor) {
    ///Styles text field with an underline given a UITextField, CGFloat width, and a CGColor for the border color
    
    let border = CALayer()
    let width = CGFloat(borderWidth)
    border.borderColor = borderColor
    border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width:  textField.frame.size.width, height: textField.frame.size.height)
    
    border.borderWidth = width
    textField.layer.addSublayer(border)
    textField.layer.masksToBounds = true
    
}

extension UIColor {
    
    //usage:
    //var color = UIColor(red: 0xFF, green: 0xFF, blue: 0xFF
    //var color2= UIColor(netHex: 0xFFFFFF)
    
    
    
    convenience init(red: Int, green: Int, blue: Int) {
        ///Using int values ranging from [0,255] set UIColor
        ///red: Int, green: Int, blue: Int
        
        assert(red >= 0 && red <= 255, "Invalid red componet")
        assert(green >= 0 && red <= 255, "Invalid green componet")
        assert(blue >= 0 && red <= 255, "Invalid blue componet")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex: Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue: netHex & 0xff )
    }
}


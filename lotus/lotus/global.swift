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


func styleTextField(textField: UITextField, borderWidth: CGFloat, borderColor: CGColor, placeHolderText: String) {
    ///Styles text field with an underline given a UITextField, CGFloat width, and a CGColor for the border color and placeholer text
    
    let border = CALayer()
    let width = CGFloat(borderWidth)
    border.borderColor = borderColor
    border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width:  textField.frame.size.width, height: textField.frame.size.height)
    
    border.borderWidth = width
    textField.layer.addSublayer(border)
    textField.layer.masksToBounds = true
    textField.attributedPlaceholder = NSAttributedString(string: placeHolderText,
        attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
    
}


//can return date data in dd mmm yyyy formating
func getDayFromDate(date: NSDate) -> String {
    //returns day from dd mmm yyyy NSDate formatting
    var dateFormatter = NSDateFormatter()
    
    dateFormatter.dateFormat = "dd MMM yyyy"
    
    var dateStr = dateFormatter.stringFromDate(date)
    let idx = advance(dateStr.startIndex, 2)
    
    return dateStr.substringToIndex(idx)
}

func getMonthFromDate(date: NSDate) -> String {
    //returns month from dd mmm yyyy NSDate formatting
    var dateFormatter = NSDateFormatter()
    
    dateFormatter.dateFormat = "dd MMM yyyy"
    
    var dateStr = dateFormatter.stringFromDate(date)
    
    let idx = advance(dateStr.startIndex, 2)
    
    let idxM = advance(dateStr.endIndex, -4)
    
    var day = dateStr.substringToIndex(idx)
    var year = dateStr.substringFromIndex(idxM)
    var month = dateStr.stringByReplacingOccurrencesOfString(day, withString: "")
    month = month.stringByReplacingOccurrencesOfString(year, withString: "")
    
    month = month.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    
    return month
    
}

func getYearFromDate(date: NSDate) -> String {
    //returns year from dd mmm yyyy NSDate formatting
    var dateFormatter = NSDateFormatter()
    
    dateFormatter.dateFormat = "dd MMM yyyy"
    
    var dateStr = dateFormatter.stringFromDate(date)
    let idx = advance(dateStr.endIndex, -4)
    
    return dateStr.substringFromIndex(idx)
    
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

//expanding UITextField to know what is the "next" text field in the flow

private var kAssociationKeyNextField: UInt8 = 0

extension UITextField {
    var nextField: UITextField? {
        get {
            return objc_getAssociatedObject(self, &kAssociationKeyNextField) as? UITextField
        }
        set(newField) {
            objc_setAssociatedObject(self, &kAssociationKeyNextField, newField, UInt(OBJC_ASSOCIATION_RETAIN))
        }
    }
}

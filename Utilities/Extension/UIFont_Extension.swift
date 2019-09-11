//
//  String_Extension.swift
//  Arrively
//
//  Created by AtologistMacMin2 on 16/07/18.
//  Copyright © 2018 AtologistMacMin2. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    //MARK:- CircularStd
    //Reguler
    class func regulerFont(ofSize pointSize : CGFloat) -> UIFont {
        return UIFont(name: "CircularStd-Book", size: pointSize.proportionalFontSize())!
        //return UIFont.systemFont(ofSize: pointSize)
    }
    
    //Medium
    class func MediumFont(ofSize pointSize : CGFloat) -> UIFont {
        return UIFont(name: "CircularStd-Medium", size: pointSize.proportionalFontSize())!
        //return UIFont.systemFont(ofSize: pointSize, weight: UIFont.Weight.medium)
    }
    
    //Bold
    class func BoldFont(ofSize pointSize : CGFloat) -> UIFont {
        return UIFont(name: "CircularStd-Bold", size: pointSize.proportionalFontSize())!
        //return UIFont.boldSystemFont(ofSize: pointSize)
    }
    
    //MARK:- FrankRuhlLibre
    //Reguler
    class func regulerFrankRuhlFont(ofSize pointSize : CGFloat) -> UIFont {
        return UIFont(name: "FrankRuhlLibre-Regular", size: pointSize.proportionalFontSize())!
        //return UIFont.systemFont(ofSize: pointSize)
    }
    
    //Medium
    class func MediumFrankRuhlFont(ofSize pointSize : CGFloat) -> UIFont {
        return UIFont(name: "FrankRuhlLibre-Medium", size: pointSize.proportionalFontSize())!
        //return UIFont.systemFont(ofSize: pointSize, weight: UIFont.Weight.medium)
    }
    
    //Bold
    class func BoldFrankRuhlFont(ofSize pointSize : CGFloat) -> UIFont {
        return UIFont(name: "FrankRuhlLibre-Bold", size: pointSize.proportionalFontSize())!
        //return UIFont.boldSystemFont(ofSize: pointSize)
    }
    
    
    
    //MARK:- WorkSans
    //Reguler
    class func regulerWorkFont(ofSize pointSize : CGFloat) -> UIFont {
        return UIFont(name: "WorkSans-Regular", size: pointSize.proportionalFontSize())!
        //return UIFont.systemFont(ofSize: pointSize)
    }
    
    //Medium
    class func MediumWorkFont(ofSize pointSize : CGFloat) -> UIFont {
        return UIFont(name: "WorkSans-Medium", size: pointSize.proportionalFontSize())!
        //return UIFont.systemFont(ofSize: pointSize, weight: UIFont.Weight.medium)
    }
    
    //Bold
    class func BoldWorkFont(ofSize pointSize : CGFloat) -> UIFont {
        return UIFont(name: "WorkSans-Bold", size: pointSize.proportionalFontSize())!
        //return UIFont.boldSystemFont(ofSize: pointSize)
    }
}

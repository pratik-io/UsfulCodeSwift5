//
//  Extension_CGFloat.swift
//  CarSumers
//
//  Created by agile-39 on 24/02/18.
//  Copyright © 2018 agile. All rights reserved.
//


import Foundation
import CoreGraphics

extension CGFloat{
	
	init?(_ str: String) {
		guard let float = Float(str) else { return nil }
		self = CGFloat(float)
	}

	
	func twoDigitValue() -> String {
		
		let formatter = NumberFormatter()
		formatter.maximumFractionDigits = 2
		formatter.minimumFractionDigits = 0
		formatter.roundingMode = NumberFormatter.RoundingMode.halfUp //NumberFormatter.roundingMode.roundHalfUp
	
		
//		let str : NSString = formatter.stringFromNumber(NSNumber(self))!
		let str = formatter.string(from: NSNumber(value: Double(self)))
		return str! as String;
	}

	
	
	func proportionalFontSize() -> CGFloat {
		
		var sizeToCheckAgainst = self
		
        switch Device.deviceType!
        {
        case .iPad:
             sizeToCheckAgainst += 12
            break;
        case .iphoneX:
            sizeToCheckAgainst += 0
        case .iPhone6por6sp:
            sizeToCheckAgainst += 0
            break;
        case .iPhone6or6s:
            sizeToCheckAgainst -= 0.5
            break;
        case .iPhone5or5s:
            sizeToCheckAgainst -= 1.3
            break;
        case .iPhone4or4s:
            sizeToCheckAgainst -= 3
        case .other:
            sizeToCheckAgainst += 0
        }
        
		return sizeToCheckAgainst
	}
}

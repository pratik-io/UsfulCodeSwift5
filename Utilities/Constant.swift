//
//  Constant.swift
//  Demo
//
//  Created by Dark Army on 11/09/19.
//  Copyright © 2019 Dark Army. All rights reserved.
//

import UIKit

// MARK: DEVICE & SCREEN SIZE CONSTANTS
// MARK:
let SCREEN_WIDTH  = (UIScreen.main.bounds.size.width)
let SCREEN_HEIGHT  = (UIScreen.main.bounds.size.height)


//MARK: - Device Type
struct Device {
    
    static let AppName              = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
    static let platform             = "ios"
    static let udid                 = UIDevice.current.identifierForVendor!.uuidString
    static let applicationVersion   = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    static let buildVersion         = (Bundle.main.infoDictionary?[kCFBundleVersionKey as String] as? String)!
    static let bundleIdentifier     = Bundle.main.bundleIdentifier!
    
    
    static let isSimulator              = ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] != nil
    static let isIPHONE_DEVICE: Bool    = UIDevice.current.userInterfaceIdiom == .phone
    static let isIPAD_DEVICE: Bool      = UIDevice.current.userInterfaceIdiom == .pad
    static let isDEVICE_PORTRAIT: Bool  = UIDevice.current.orientation.isPortrait
    static let isDEVICE_LANDSCAPE: Bool = UIDevice.current.orientation.isLandscape
    static let isIPHONE_4_OR_4S: Bool   = (480 == SCREEN_HEIGHT)
    static let isIPHONE_5_OR_5S: Bool   = (568 == SCREEN_HEIGHT)
    static let isIPHONE_6_OR_6S: Bool   = (667 == SCREEN_HEIGHT)
    static let isIPHONE_6P_OR_6SP: Bool = (736 == SCREEN_HEIGHT)
    static let isIPHONE_X: Bool         = (812 == SCREEN_HEIGHT)
    
    internal enum DeviceType {
        case iPhone4or4s
        case iPhone5or5s
        case iPhone6or6s
        case iPhone6por6sp
        case iphoneX
        case iPad
        case other
    }
    
    static var deviceType : DeviceType? {
        if isIPHONE_4_OR_4S {
            return DeviceType.iPhone4or4s
        } else if isIPHONE_5_OR_5S{
            return DeviceType.iPhone5or5s
        } else if isIPHONE_6_OR_6S {
            return DeviceType.iPhone6or6s
        } else if isIPHONE_6P_OR_6SP {
            return DeviceType.iPhone6por6sp
        } else if isIPHONE_X {
            return DeviceType.iphoneX
        } else if isIPAD_DEVICE {
            return DeviceType.iPad
        } else {
            return DeviceType.other
        }
    }
}

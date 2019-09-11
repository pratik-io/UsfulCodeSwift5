//
//  String_Extension.swift
//  Arrively
//
//  Created by AtologistMacMin2 on 16/07/18.
//  Copyright © 2018 AtologistMacMin2. All rights reserved.
//

import UIKit

extension UIViewController {
    
    class func loadController() -> Self {
        return instantiateViewControllerFromMainStoryBoard()
    }
    private class func instantiateViewControllerFromMainStoryBoard<T>() -> T
    {
        let controller = UIStoryboard.mainStoryboard().instantiateViewController(withIdentifier:
            String(describing: self)) as! T
        return controller
    }
    
    // get top most view controller helper method.
    static var topMostViewController : UIViewController {
        get {
            return UIViewController.topViewController(rootViewController: UIApplication.shared.keyWindow!.rootViewController!)
        }
    }
    
    fileprivate static func topViewController(rootViewController: UIViewController) -> UIViewController {
        guard rootViewController.presentedViewController != nil else {
            if rootViewController is UITabBarController {
                let tabbarVC = rootViewController as! UITabBarController
                let selectedViewController = tabbarVC.selectedViewController
                return UIViewController.topViewController(rootViewController: selectedViewController!)
            }
                
            else if rootViewController is UINavigationController {
                let navVC = rootViewController as! UINavigationController
                return UIViewController.topViewController(rootViewController: navVC.viewControllers.last!)
            }
            
            return rootViewController
        }
        
        return topViewController(rootViewController: rootViewController.presentedViewController!)
    }
    
}

extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard{
        return UIStoryboard(name: "Main", bundle: nil)
    }
}

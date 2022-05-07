//
//  UIDevice+Extensions.swift
//  GAScrollViewNestDemo
//
//  Created by MaciOS on 2022/5/6.
//

import Foundation
import UIKit

extension UIDevice {
    
    static func statusBarHeight() -> CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    static func navigationBarHeight() -> CGFloat {
        return UIApplication.shared.statusBarFrame.height + 44
    }
    
    static func safeAreaBottom() -> CGFloat {
        var bottomheight: CGFloat = 0.0
        if #available(iOS 11.0, *) {
            bottomheight = UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0
        }
        return bottomheight
    }
    
    static func iPhone5() -> Bool {
        return UIScreen.main.bounds.size.height == 568
    }
    
    static func iPhone6() -> Bool {
        return UIScreen.main.bounds.size.height == 667
    }
    
    static func iPhone6Plus() -> Bool {
        return UIScreen.main.bounds.size.height == 736
    }
    
    static func isIPhoneX() -> Bool {
        return UIApplication.shared.statusBarFrame.height == 20 ? false : true
    }
    
    static func IS_iPhoneXR() ->Bool{
        return (UIScreen.main.bounds.size.width == 414 && UIScreen.main.bounds.size.height == 896)
    }
    
    static func isIPhoneXBottomMargin() -> CGFloat {
        return isIPhoneX() ? 34 : 0
    }
    
    static func tabbarHeight()->CGFloat {
        return isIPhoneX() ? 49 + 34 : 49
    }
    
    static func screenWidth()->CGFloat {
        return UIScreen.main.bounds.size.width
    }

    static func screenHeight()->CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
}

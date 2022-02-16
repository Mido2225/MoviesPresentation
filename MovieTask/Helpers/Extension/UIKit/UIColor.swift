//
//  UIColor.swift
//  Taskon
//
//  Created by MGAboarab on 02/02/2022.
//

import UIKit

extension UIColor {
    
    //MARK: - Properities
    class var background: UIColor {
        return UIColor(named: "BackGroundColor")!
    }
    
    class var mainColor: UIColor {
        switch UserDefaults.selectedUserType {
        case .guest:
            return .mainBlueColor
        case .owner:
            return .mainBlueColor
        case .office:
            return .mainOrangeColor
        case .marketer:
            return .mainBlueColor
        }
    }
    
    class var mainOrangeColor: UIColor {
        return UIColor(named: "AppOrange")!
    }
    
    class var mainBlueColor: UIColor {
        return UIColor(named: "AppBlue")!
    }
    
    class var mainGreenColor: UIColor {
        return UIColor(named: "AppGreen")!
    }
    
    class var mainColorLight: UIColor {
        return UIColor(named: "MainColorLight")!
    }
    class var secondaryColor: UIColor {
        return UIColor(named: "SecondaryColor")!
    }
    class var secondaryColorLight: UIColor {
        return UIColor(named: "SecondaryColorLight")!
    }
    class var whiteColor: UIColor {
        return UIColor(named: "WhiteColor")!
    }
    
    class var fontDarkColor: UIColor {
        return UIColor(named: "FontDarkColor")!
    }
    class var fontLightColor: UIColor {
        return UIColor(named: "FontLightColor")!
    }
    class var secondryDarkFontColor: UIColor {
        return UIColor(named: "SecondryDarkFontColor")!
    }
    class var secondryLightFontColor: UIColor {
        return UIColor(named: "SecondryLightFontColor")!
    }
    
    class var borderColor: UIColor {
        return UIColor(named: "BorderColor")!
    }
    
    class var successColor: UIColor {
        return UIColor(named: "SuccessColor")!
    }
    class var errorColor: UIColor {
        return UIColor(named: "ErrorColor")!
    }
    class var warningColor: UIColor {
        return UIColor(named: "WarningColor")!
    }
    
    class var shadowColor: UIColor {
        return UIColor(named: "ShadowColor")!
    }
}



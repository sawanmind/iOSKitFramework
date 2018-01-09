//
//  ThemeManager.swift
//  Project Starter
//
//  Created by iOS Developer on 1/3/18.
//  Copyright © 2018 sawanmind. All rights reserved.
//

import UIKit
import Foundation

public extension UIColor {
 public   class func themeColor() -> UIColor {
        return  UIView().tintColor
    }
    
  public  class func darkTheme() -> UIColor {
        return  UIColor(red: 28/255, green: 42/255, blue: 54/255, alpha: 1)
    }
    
  public  class func textFieldColor() -> UIColor {
        return  UIColor(red: 149/255, green: 154/255, blue: 162/255, alpha: 0.05)
    }
    
  public  class func placeholderColor() -> UIColor {
        return  UIColor(red: 205/255, green: 208/255, blue: 217/255, alpha: 1)
    }
    
  public  class func disabledColor() -> UIColor {
        return  UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1)
    }

}




extension UIColor {
   public func colorFromHexString (_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}



public enum Theme: Int {
    
    case light, dark
    
   public var mainColor: UIColor {
        switch self {
        case .light:
            return UIColor().colorFromHexString("000000")
        case .dark:
            return UIColor().colorFromHexString("ffffff")
        }
    }
    
   
   public var barStyle: UIBarStyle {
        switch self {
        case .light:
            return .default
        case .dark:
            return .black
        }
    }
    
   public var navigationBackgroundImage: UIImage? {
        return self == .light ? UIImage(named: "navBackground") : nil
    }
    
  public  var tabBarBackgroundImage: UIImage? {
        return self == .light ? UIImage(named: "tabBarBackground") : nil
    }
    
   public var backgroundColor: UIColor {
        switch self {
        case .light:
            return UIColor().colorFromHexString("ffffff")
        case .dark:
            return UIColor().colorFromHexString("000000")
        }
    }
    
  public  var secondaryColor: UIColor {
        switch self {
        case .light:
            return UIColor().colorFromHexString("ffffff")
        case .dark:
            return UIColor().colorFromHexString("000000")
        }
    }
    
   public var titleTextColor: UIColor {
        switch self {
        case .light:
            return UIColor().colorFromHexString("ffffff")
        case .dark:
            return UIColor().colorFromHexString("000000")
        }
    }
   public var subtitleTextColor: UIColor {
        switch self {
        case .light:
            return UIColor().colorFromHexString("ffffff")
        case .dark:
            return UIColor().colorFromHexString("000000")
        }
    }
    
  public  var barButtonColor: UIColor {
        switch self {
        case .light:
            return UIColor().colorFromHexString("000000")
        case .dark:
            return UIColor().colorFromHexString("ffffff")
        }
    }
    
    
}

// Enum declaration
let SelectedThemeKey = "SelectedTheme"

// This will let you use a theme in the app.
public class ThemeManager {
    
    // ThemeManager
    static public func currentTheme() -> Theme {
        if let storedTheme = (UserDefaults.standard.value(forKey: SelectedThemeKey) as AnyObject).integerValue {
            return Theme(rawValue: storedTheme)!
        } else {
            return .dark
        }
    }
    
   public static func applyTheme(theme: Theme) {
        // First persist the selected theme using NSUserDefaults.
        UserDefaults.standard.setValue(theme.rawValue, forKey: SelectedThemeKey)
        UserDefaults.standard.synchronize()
        
        // You get your current (selected) theme and apply the main color to the tintColor property of your application’s window.
        let sharedApplication = UIApplication.shared
        sharedApplication.delegate?.window??.tintColor = theme.mainColor
        
        UINavigationBar.appearance().barStyle = theme.barStyle
        UINavigationBar.appearance().setBackgroundImage(theme.navigationBackgroundImage, for: .default)
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "backArrow")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "backArrowMaskFixed")
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.font : UIFont.monospacedDigitSystemFont(ofSize: 16, weight: UIFont.Weight.black)]
        
        UITabBar.appearance().barStyle = theme.barStyle
        UITabBar.appearance().backgroundImage = theme.tabBarBackgroundImage
        
        let tabIndicator = UIImage(named: "tabBarSelectionIndicator")?.withRenderingMode(.alwaysTemplate)
        let tabResizableIndicator = tabIndicator?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 2.0, bottom: 0, right: 2.0))
        UITabBar.appearance().selectionIndicatorImage = tabResizableIndicator
        
        let controlBackground = UIImage(named: "controlBackground")?.withRenderingMode(.alwaysTemplate)
            .resizableImage(withCapInsets: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))
        let controlSelectedBackground = UIImage(named: "controlSelectedBackground")?
            .withRenderingMode(.alwaysTemplate)
            .resizableImage(withCapInsets: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))
        
        UISegmentedControl.appearance().setBackgroundImage(controlBackground, for: .normal, barMetrics: .default)
        UISegmentedControl.appearance().setBackgroundImage(controlSelectedBackground, for: .selected, barMetrics: .default)
        
        UIStepper.appearance().setBackgroundImage(controlBackground, for: .normal)
        UIStepper.appearance().setBackgroundImage(controlBackground, for: .disabled)
        UIStepper.appearance().setBackgroundImage(controlBackground, for: .highlighted)
        UIStepper.appearance().setDecrementImage(UIImage(named: "fewerPaws"), for: .normal)
        UIStepper.appearance().setIncrementImage(UIImage(named: "morePaws"), for: .normal)
        
        UISlider.appearance().setThumbImage(UIImage(named: "sliderThumb"), for: .normal)
        UISlider.appearance().setMaximumTrackImage(UIImage(named: "maximumTrack")?
            .resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0.0, bottom: 0, right: 6.0)), for: .normal)
        UISlider.appearance().setMinimumTrackImage(UIImage(named: "minimumTrack")?
            .withRenderingMode(.alwaysTemplate)
            .resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 6.0, bottom: 0, right: 0)), for: .normal)
        
        UISwitch.appearance().onTintColor = theme.mainColor.withAlphaComponent(0.3)
        UISwitch.appearance().thumbTintColor = theme.mainColor
    }
}

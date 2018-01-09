//
//  extensions.swift
//  Live Vaastu
//
//  Created by Sawkan Team on 08/06/17.
//  Copyright © 2017 Sawkan Team. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI


extension UIViewController {
  public  func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
   @objc public func dismissKeyboard() {
        view.endEditing(true)
    }
}



extension UIApplication {
  public  var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}



extension UIView {
   public func applyGradient(topColor:UIColor, bottomColor:UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = self.frame.size
        gradientLayer.colors =
            [topColor.cgColor,bottomColor.withAlphaComponent(1).cgColor]
        
        self.layer.addSublayer(gradientLayer)
    }
}





public func topController() -> UIViewController {
    var topController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
    while (topController.presentedViewController != nil) {
        topController = topController.presentedViewController!
    }
    return topController
}





extension UIView {
    
    
   public func applyShadow() {
        let layer  = self.layer
        layer.shadowColor   = UIColor.darkGray.cgColor
        layer.shadowOffset  = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 0.4
        layer.shadowRadius  = 1
    }
    
 public   func applyShadowAroundTheView() {
        let layer  = self.layer
        let color = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        layer.shadowColor   = color.cgColor
        layer.shadowOffset  = CGSize(width: 0, height: 6)
        layer.shadowOpacity = 0
        layer.shadowRadius  = 10
    }
    
}



extension UILabel {
 public   func setStrikethrough(text:String) {
        let attributedText = NSAttributedString(string: text , attributes: [NSAttributedStringKey.strikethroughStyle: NSUnderlineStyle.styleSingle.rawValue, NSAttributedStringKey.strikethroughColor: UIColor.lightGray])
        self.attributedText = attributedText
    }
}




class UIMarginLabel: UILabel {
    
  public  var topInset:       CGFloat = 0
  public  var rightInset:     CGFloat = 0
  public  var bottomInset:    CGFloat = 0
 public   var leftInset:      CGFloat = 0
    
    override public  func drawText(in rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: self.topInset, left: self.leftInset, bottom: self.bottomInset, right: self.rightInset)
        self.setNeedsLayout()
        return super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
}






extension Date {
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
}






extension NSMutableAttributedString {
    @discardableResult func bold(_ text:String, size:CGFloat) -> NSMutableAttributedString {
        let attributes:[NSAttributedStringKey:AnyObject] = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: size, weight: UIFont.Weight.bold)]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attributes)
        self.append(boldString)
        return self
    }
    
    @discardableResult func black(_ text:String, size:CGFloat) -> NSMutableAttributedString {
        let attributes:[NSAttributedStringKey:AnyObject] = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: size, weight: UIFont.Weight.black)]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attributes)
        self.append(boldString)
        return self
    }
    
    @discardableResult func ultraLight(_ text:String, size:CGFloat) -> NSMutableAttributedString {
        let attributes:[NSAttributedStringKey:AnyObject] = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: size, weight: UIFont.Weight.ultraLight)]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attributes)
        self.append(boldString)
        return self
    }
    
    @discardableResult func medium(_ text:String, size:CGFloat) -> NSMutableAttributedString {
        let attributes:[NSAttributedStringKey:AnyObject] = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: size, weight: UIFont.Weight.medium)]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attributes)
        self.append(boldString)
        return self
    }
    
    @discardableResult func thin(_ text:String,size:CGFloat)->NSMutableAttributedString {
        let attributes:[NSAttributedStringKey:AnyObject] = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: size, weight: UIFont.Weight.thin)]
        let thin = NSMutableAttributedString(string:"\(text)", attributes:attributes)
        self.append(thin)
        return self
    }
}




extension UITextField {
    func setBottomBorder() {
        
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        
    }
}


import UIKit

public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
        case "AppleTV5,3":                              return "Apple TV"
        case "AppleTV6,2":                              return "Apple TV 4K"
        case "AudioAccessory1,1":                       return "HomePod"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
}




extension UIImage {
    
    func makeCircularImage(size: CGSize, borderWidth width: CGFloat) -> UIImage {
        // make a CGRect with the image's size
        let circleRect = CGRect(origin: .zero, size: size)
        
        // begin the image context since we're not in a drawRect:
        UIGraphicsBeginImageContextWithOptions(circleRect.size, false, 0)
        
        // create a UIBezierPath circle
        let circle = UIBezierPath(roundedRect: circleRect, cornerRadius: circleRect.size.width * 0.5)
        
        // clip to the circle
        circle.addClip()
        
        UIColor.white.set()
        circle.fill()
        
        // draw the image in the circleRect *AFTER* the context is clipped
        self.draw(in: circleRect)
        
        // create a border (for white background pictures)
        if width > 0 {
            circle.lineWidth = width;
            UIColor.white.set()
            circle.stroke()
        }
        
        // get an image from the image context
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext();
        
        // end the image context since we're not in a drawRect:
        UIGraphicsEndImageContext();
        
        return roundedImage ?? self
    }
    
    class func draw(size: CGSize, fillColor: UIColor, shapeClosure: () -> UIBezierPath) -> UIImage {
        UIGraphicsBeginImageContext(size)
        
        let path = shapeClosure()
        path.addClip()
        
        fillColor.setFill()
        path.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}

extension NSAttributedString {
    
    static func attributedString(string: String?, fontSize size: CGFloat, color: UIColor?) -> NSAttributedString? {
        guard let string = string else { return nil }
        
        let attributes = [NSAttributedStringKey.foregroundColor: color ?? UIColor.black,
                          NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: size)]
        
        let attributedString = NSMutableAttributedString(string: string, attributes: attributes)
        
        return attributedString
    }
    
}





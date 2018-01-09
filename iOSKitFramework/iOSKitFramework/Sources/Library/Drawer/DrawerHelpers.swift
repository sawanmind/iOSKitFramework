





import UIKit


public struct DrawerModel {
    
   public var icon = UIImage()
   public var text = String()
   public var controller = UIViewController()
    
   public init(icon:UIImage, text:String, controller:UIViewController) {
        self.icon = icon
        self.text = text
        self.controller = controller
    }
}


public enum ButtonType {
    case editProfile
    case moreButton
}



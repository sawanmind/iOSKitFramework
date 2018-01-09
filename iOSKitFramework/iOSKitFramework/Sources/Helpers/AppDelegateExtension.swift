//
//  AppDelegateExtension.swift
//  Project Starter
//
//  Created by Developer on 1/6/18.
//  Copyright © 2018 sawanmind. All rights reserved.
//

import UIKit

extension  UIResponder {
   
    public func setupNavigationApperance() {
        let navApperance = UINavigationBar.appearance()
        navApperance.barTintColor = UIColor().colorFromHexString("50A7C2")
        navApperance.tintColor = UIColor.white
        navApperance.isTranslucent = false
        navApperance.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        UIApplication.shared.statusBarStyle = .lightContent
    }
}


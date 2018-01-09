    //
    //  NavigationTitleView.swift
    //  demo
    //
    //  Created by iOS Developer on 1/8/18.
    //  Copyright © 2018 Genysis. All rights reserved.
    //
    
    import UIKit
    
    
    public func NavigationTitleView(title:NSAttributedString? = NSAttributedString(string: ""), subTitle:NSAttributedString? = NSAttributedString(string: "")) -> UIView {
        
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        
        let titlename = UILabel()
            titlename.attributedText = title
            titlename.textAlignment = .center
            titlename.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(titlename)
            titlename.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
            titlename.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            titlename.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2).isActive = true
       
        if subTitle == nil {
            titlename.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        } else {
            titlename.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        }
        
        let titlesubtitle = UILabel()
            titlesubtitle.attributedText = subTitle
            titlesubtitle.textAlignment = .center
            titlesubtitle.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(titlesubtitle)
            titlesubtitle.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
            titlesubtitle.topAnchor.constraint(equalTo: titlename.bottomAnchor).isActive = true
            titlesubtitle.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            titlesubtitle.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2).isActive = true
        
        
        return view
        
        
    }

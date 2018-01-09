//
//  SMAlertView.swift
//  Live Vaastu
//
//  Created by Sawkan Team on 12/3/17.
//  Copyright © 2017 Sawkan Team. All rights reserved.
//



import UIKit

public class SMAlertView: UIView, Modal {
  public  var backgroundView = UIView()
  public  var dialogView = UIView()
    
    
    
    convenience public init(title:String,buttonTitle:String) {
        self.init(frame: UIScreen.main.bounds)
        initialize(title: title, buttonTitle: buttonTitle)
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   public func initialize(title:String, buttonTitle:String){
        dialogView.clipsToBounds = true
        
        backgroundView.frame = frame
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.6
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        addSubview(backgroundView)
        
        let dialogViewWidth = frame.width-64
        
        let titleLabel = UILabel(frame: CGRect(x: 8, y: 8, width: dialogViewWidth-16, height: 30))
        titleLabel.text = title
        titleLabel.textAlignment = .left
        dialogView.addSubview(titleLabel)
        
        let _buttonTitle = UIButton(frame: CGRect(x: dialogViewWidth - 22, y: 8, width: 100, height: 30))
        _buttonTitle.setTitle(buttonTitle, for: .normal)
        _buttonTitle.setTitleColor(UIColor.red, for: .normal)
        _buttonTitle.titleLabel?.textAlignment = .right
        dialogView.addSubview(_buttonTitle)
        
        let separatorLineView = UIView()
        separatorLineView.frame.origin = CGPoint(x: 0, y: titleLabel.frame.height + 8)
        separatorLineView.frame.size = CGSize(width: dialogViewWidth, height: 1)
        separatorLineView.backgroundColor = UIColor.groupTableViewBackground
        dialogView.addSubview(separatorLineView)
        
        
        
        let _view = UIView()
        _view.frame.origin = CGPoint(x: 8, y: separatorLineView.frame.height + separatorLineView.frame.origin.y + 8)
        _view.frame.size = CGSize(width: dialogViewWidth - 16 , height: dialogViewWidth - 16)
        _view.layer.cornerRadius = 4
        _view.backgroundColor = UIColor.red
        _view.isUserInteractionEnabled = true
        _view.clipsToBounds = true
        dialogView.addSubview(_view)
        

       
        let dialogViewHeight = titleLabel.frame.height + 8 + separatorLineView.frame.height + 8 + _view.frame.height + 8
        
        dialogView.frame.origin = CGPoint(x: 32, y: frame.height)
        dialogView.frame.size = CGSize(width: frame.width-64, height: dialogViewHeight)
        dialogView.backgroundColor = UIColor.white
        dialogView.layer.cornerRadius = 6
        addSubview(dialogView)
    }
    
    @objc public func didTappedOnBackgroundView(){
        dismiss(animated: true)
    }
    
    
}





public protocol Modal {
    func show(animated:Bool)
    func dismiss(animated:Bool)
    var backgroundView:UIView {get}
    var dialogView:UIView {get set}
}

extension Modal where Self:UIView{
  public  func show(animated:Bool){
        self.backgroundView.alpha = 0
        UIApplication.shared.delegate?.window??.rootViewController?.view.addSubview(self)
        if animated {
            UIView.animate(withDuration: 0.33, animations: {
                self.backgroundView.alpha = 0.66
            })
            UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: {
                self.dialogView.center  = self.center
            }, completion: { (completed) in
                
            })
        }else{
            self.backgroundView.alpha = 0.66
            self.dialogView.center  = self.center
        }
    }
    
  public  func dismiss(animated:Bool){
        if animated {
            UIView.animate(withDuration: 0.33, animations: {
                self.backgroundView.alpha = 0
            }, completion: { (completed) in
                
            })
            UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: {
                self.dialogView.center = CGPoint(x: self.center.x, y: self.frame.height + self.dialogView.frame.height/2)
            }, completion: { (completed) in
                self.removeFromSuperview()
            })
        }else{
            self.removeFromSuperview()
        }
        
    }
}

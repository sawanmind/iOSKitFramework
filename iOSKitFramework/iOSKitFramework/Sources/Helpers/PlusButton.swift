//
//  PlusMinus.swift
//  Live Vaastu
//
//  Created by Sawkan Team on 11/24/17.
//  Copyright © 2017 Sawkan Team. All rights reserved.
//


import UIKit

public class PlusButton: UIButton {
    
  public  var  fillColor:UIColor = UIColor.clear
    
    override public func draw(_ rect: CGRect) {
        
        let path = UIBezierPath(ovalIn: rect)
        fillColor.setFill()
        path.fill()
        
        
        drawSign()
        
    }
    
    
   public func drawSign() {
        drawHorizontalDash()
        drawVerticalDash()
    }
    
    
  public  func drawHorizontalDash(){
        let plusHeight : CGFloat = 3.0
        
        let plusWidth : CGFloat = min(bounds.width, bounds.height) * 0.6
        let plusPath = UIBezierPath()
        
        
        plusPath.lineWidth  = plusHeight
        plusPath.move(to: CGPoint(x:bounds.width/2 - plusWidth/2, y: bounds.height/2))
        plusPath.addLine(to: CGPoint(x:bounds.width/2 + plusWidth/2, y: bounds.height/2))
        UIColor.black.setStroke()
        plusPath.stroke()
        
    }
    
    
    
   public func drawVerticalDash(){
        
        let plusHeight : CGFloat = 3.0
        
        let plusWidth : CGFloat = min(bounds.width, bounds.height) * 0.6
        let plusPath = UIBezierPath()
        
        
        plusPath.lineWidth  = plusHeight
        plusPath.move(to: CGPoint(x:bounds.width/2  + 0.5, y: bounds.height/2 - plusWidth/2 + 0.5))
        plusPath.addLine(to: CGPoint(x:bounds.width/2 + 0.5, y: bounds.height/2 + plusWidth/2 + 0.5))
        UIColor.black.setStroke()
        plusPath.stroke()
    }
    
    
}



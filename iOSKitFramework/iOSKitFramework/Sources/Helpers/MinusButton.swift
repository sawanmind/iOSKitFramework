//
//  MinusButton.swift
//  Project Starter
//
//  Created by iOS Developer on 1/3/18.
//  Copyright © 2018 sawanmind. All rights reserved.
//

import UIKit






public class MinusButton: UIButton {
    
   public var  fillColor:UIColor = UIColor.clear
    
    override public func draw(_ rect: CGRect) {
        
        let path = UIBezierPath(ovalIn: rect)
        fillColor.setFill()
        path.fill()
        
        
        drawSign()
        
    }
    
    
  public  func drawSign() {
        drawHorizontalDash()
        
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
    
    
    
    
    
}




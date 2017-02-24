//
//  MyDrawView.swift
//  GCProgressSample
//
//  Created by LuoLiu on 17/2/23.
//  Copyright © 2017年 keygx. All rights reserved.
//

import UIKit

class MyDrawView: UIView {
    
    let colorBlack = UIColor.black
    let colorWhite = UIColor.white
    
    let leftPoint1 = CGPoint(x: 0, y: 80)
    let leftPoint2 = CGPoint(x: 50, y: 80)
    let leftPoint3 = CGPoint(x: UIScreen.main.bounds.width - 80, y: UIScreen.main.bounds.height - 80)
    let leftPoint4 = CGPoint(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height - 80)
    
    let rightPoint1 = CGPoint(x: UIScreen.main.bounds.width, y: 80)
    let rightPoint2 = CGPoint(x: UIScreen.main.bounds.width - 50, y: 80)
    let rightPoint3 = CGPoint(x: 80, y: UIScreen.main.bounds.height - 80)
    let rightPoint4 = CGPoint(x: 0, y: UIScreen.main.bounds.height - 80)
    
    override func draw(_ rect: CGRect) {
//        drawAnimationLeftCanvas()
//        drawAnimationRightCanvas()
        drawStaticLeftCanvas()
        drawStaticRightCanvas()
        drawCenterImage()
    }
    
    func drawAnimationLeftCanvas() {
        
        let oval1Rect = CGRect(x: leftPoint2.x - 30, y: leftPoint2.y - 30, width: 60, height: 60)
        let oval2Rect = CGRect(x: leftPoint3.x - 10, y: leftPoint3.y - 10, width: 20, height: 20)
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: leftPoint1)
        bezierPath.addLine(to: leftPoint2)
        
        // Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: oval1Rect)
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: leftPoint2)
        bezier2Path.addLine(to: leftPoint3)
        
        let oval2Path = UIBezierPath(ovalIn: oval2Rect)
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.move(to: leftPoint3)
        bezier3Path.addLine(to: leftPoint4)
        
        bezierPath.append(ovalPath)
        bezierPath.append(bezier2Path)
        bezierPath.append(oval2Path)
        bezierPath.append(bezier3Path)
        
        let layer = CAShapeLayer()
        layer.frame = self.bounds
        layer.path = bezierPath.cgPath
        layer.strokeColor = UIColor.black.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 1.0
        self.layer.addSublayer(layer)

        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 2.0
        animation.fromValue = 0.0
        animation.toValue = 1.0
        layer.add(animation, forKey:"strokeEnd")
        
        let layer2 = CAShapeLayer()
        layer2.frame = self.bounds
        layer2.path = ovalPath.cgPath
        layer2.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(layer2)
        
        let animation2 = CABasicAnimation(keyPath: "fillColor")
        animation2.beginTime = CACurrentMediaTime() + 0.1
        animation2.duration = 0.5
        animation2.fromValue = UIColor.clear.cgColor
        animation2.toValue = UIColor.black.cgColor
        animation2.isRemovedOnCompletion = false
        animation2.fillMode = kCAFillModeForwards
        layer2.add(animation2, forKey:"fillColor")
        
        let layer3 = CAShapeLayer()
        layer3.frame = self.bounds
        layer3.path = oval2Path.cgPath
        layer3.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(layer3)

        let animation3 = CABasicAnimation(keyPath: "fillColor")
        animation3.beginTime = CACurrentMediaTime() + 1.5
        animation3.duration = 0.5
        animation3.fromValue = UIColor.clear.cgColor
        animation3.toValue = UIColor.white.cgColor
        animation3.isRemovedOnCompletion = false
        animation3.fillMode = kCAFillModeForwards
        layer3.add(animation3, forKey:"fillColor")
    }
    
    func drawAnimationRightCanvas() {
        
        let oval1Rect = CGRect(x: rightPoint2.x - 30, y: rightPoint2.y - 30, width: 60, height: 60)
        let oval2Rect = CGRect(x: rightPoint3.x - 10, y: rightPoint3.y - 10, width: 20, height: 20)
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: rightPoint1)
        bezierPath.addLine(to: rightPoint2)
        
        // Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: oval1Rect)
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: rightPoint2)
        bezier2Path.addLine(to: rightPoint3)
        
        let oval2Path = UIBezierPath(ovalIn: oval2Rect)
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.move(to: rightPoint3)
        bezier3Path.addLine(to: rightPoint4)
        
        bezierPath.append(ovalPath)
        bezierPath.append(bezier2Path)
        bezierPath.append(oval2Path)
        bezierPath.append(bezier3Path)
        
        let layer = CAShapeLayer()
        layer.frame = self.bounds
        layer.path = bezierPath.cgPath
        layer.strokeColor = UIColor.black.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 1.0
        self.layer.addSublayer(layer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 2.0
        animation.fromValue = 0.0
        animation.toValue = 1.0
        layer.add(animation, forKey:"strokeEnd")
        
        let layer2 = CAShapeLayer()
        layer2.frame = self.bounds
        layer2.path = ovalPath.cgPath
        layer2.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(layer2)
        
        let animation2 = CABasicAnimation(keyPath: "fillColor")
        animation2.beginTime = CACurrentMediaTime() + 0.1
        animation2.duration = 0.5
        animation2.fromValue = UIColor.clear.cgColor
        animation2.toValue = UIColor.white.cgColor
        animation2.isRemovedOnCompletion = false
        animation2.fillMode = kCAFillModeForwards
        layer2.add(animation2, forKey:"fillColor")
        
        let layer3 = CAShapeLayer()
        layer3.frame = self.bounds
        layer3.path = oval2Path.cgPath
        layer3.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(layer3)
        
        let animation3 = CABasicAnimation(keyPath: "fillColor")
        animation3.beginTime = CACurrentMediaTime() + 1.5
        animation3.duration = 0.5
        animation3.fromValue = UIColor.clear.cgColor
        animation3.toValue = UIColor.white.cgColor
        animation3.isRemovedOnCompletion = false
        animation3.fillMode = kCAFillModeForwards
        layer3.add(animation3, forKey:"fillColor")
    }

    
    func drawCenterImage() {
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: self.center.x - 150, y: self.center.y - 150, width: 300, height: 300))
        
        let layer = CAShapeLayer()
        layer.frame = self.bounds
        layer.path = ovalPath.cgPath
        layer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(layer)
        
        let animation = CABasicAnimation(keyPath: "fillColor")
        animation.beginTime = CACurrentMediaTime() + 2.0
        animation.duration = 0.2
        animation.fromValue = UIColor.clear.cgColor
        animation.toValue = UIColor.white.cgColor
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        layer.add(animation, forKey:"fillColor")
    }
    
    func drawStaticLeftCanvas() {
        
        let oval1Rect = CGRect(x: leftPoint2.x - 30, y: leftPoint2.y - 30, width: 60, height: 60)
        let oval2Rect = CGRect(x: leftPoint3.x - 10, y: leftPoint3.y - 10, width: 20, height: 20)
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: leftPoint1)
        bezierPath.addLine(to: leftPoint2)
        colorBlack.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: oval1Rect)
        colorBlack.setFill()
        ovalPath.fill()
        colorBlack.setStroke()
        ovalPath.lineWidth = 1
        ovalPath.stroke()
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: leftPoint2)
        bezier2Path.addLine(to: leftPoint3)
        colorBlack.setStroke()
        bezier2Path.lineWidth = 1
        bezier2Path.stroke()
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.move(to: leftPoint3)
        bezier3Path.addLine(to: leftPoint4)
        colorBlack.setStroke()
        bezier3Path.lineWidth = 1
        bezier3Path.stroke()
        
        //// Oval 2 Drawing
        let oval2Path = UIBezierPath(ovalIn: oval2Rect)
        colorWhite.setFill()
        oval2Path.fill()
        colorBlack.setStroke()
        oval2Path.lineWidth = 1
        oval2Path.stroke()
    }
    
    func drawStaticRightCanvas() {
        
        let oval1Rect = CGRect(x: rightPoint2.x - 30, y: rightPoint2.y - 30, width: 60, height: 60)
        let oval2Rect = CGRect(x: rightPoint3.x - 10, y: rightPoint3.y - 10, width: 20, height: 20)
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: rightPoint1)
        bezierPath.addLine(to: rightPoint2)
        colorBlack.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: oval1Rect)
        colorBlack.setFill()
        ovalPath.fill()
        colorBlack.setStroke()
        ovalPath.lineWidth = 1
        ovalPath.stroke()
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: rightPoint2)
        bezier2Path.addLine(to: rightPoint3)
        colorBlack.setStroke()
        bezier2Path.lineWidth = 1
        bezier2Path.stroke()
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.move(to: rightPoint3)
        bezier3Path.addLine(to: rightPoint4)
        colorBlack.setStroke()
        bezier3Path.lineWidth = 1
        bezier3Path.stroke()
        
        //// Oval 2 Drawing
        let oval2Path = UIBezierPath(ovalIn: oval2Rect)
        colorWhite.setFill()
        oval2Path.fill()
        colorBlack.setStroke()
        oval2Path.lineWidth = 1
        oval2Path.stroke()
    }

}

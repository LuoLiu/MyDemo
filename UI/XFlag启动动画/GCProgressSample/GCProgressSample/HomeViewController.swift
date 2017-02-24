//
//  HomeViewController.swift
//  GCProgressSample
//
//  Created by LuoLiu on 17/2/23.
//  Copyright © 2017年 keygx. All rights reserved.
//

import UIKit
import GradientCircularProgress

class HomeViewController: UIViewController {
    
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
    
    var timer: Timer?
    var v: Double = 0.0
    
    let progress = GradientCircularProgress()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        drawAnimationLeftCanvas()
//        self.perform(#selector(drawAnimationRightCanvas), with: nil, afterDelay: 1.0)
//        self.perform(#selector(drawCenterImage), with: nil, afterDelay: 2.5)
        self.perform(#selector(showProgress), with: nil, afterDelay: 2.5)
    }
    
    func showProgress() {
        self.progress.showAtRatio(display: true, style: MyStyle())
        self.startProgressAtRatio()
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
        layer.frame = self.view.bounds
        layer.path = bezierPath.cgPath
        layer.strokeColor = UIColor.black.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 1.0
        self.view.layer.addSublayer(layer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 1.0
        animation.fromValue = 0.0
        animation.toValue = 1.0
        layer.add(animation, forKey:"strokeEnd")
        
        let layer2 = CAShapeLayer()
        layer2.frame = self.view.bounds
        layer2.path = ovalPath.cgPath
        layer2.fillColor = UIColor.clear.cgColor
        self.view.layer.addSublayer(layer2)
        
        let animation2 = CABasicAnimation(keyPath: "fillColor")
//        animation2.beginTime = CACurrentMediaTime() + 0.1
        animation2.duration = 0.1
        animation2.fromValue = UIColor.clear.cgColor
        animation2.toValue = UIColor.black.cgColor
        animation2.isRemovedOnCompletion = false
        animation2.fillMode = kCAFillModeForwards
        layer2.add(animation2, forKey:"fillColor")
        
        let layer3 = CAShapeLayer()
        layer3.frame = self.view.bounds
        layer3.path = oval2Path.cgPath
        layer3.fillColor = UIColor.clear.cgColor
        self.view.layer.addSublayer(layer3)
        
        let animation3 = CABasicAnimation(keyPath: "fillColor")
        animation3.beginTime = CACurrentMediaTime() + 0.7
        animation3.duration = 0.1
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
        layer.frame = self.view.bounds
        layer.path = bezierPath.cgPath
        layer.strokeColor = UIColor.black.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 1.0
        self.view.layer.addSublayer(layer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 1.0
        animation.fromValue = 0.0
        animation.toValue = 1.0
        layer.add(animation, forKey:"strokeEnd")
        
        let layer2 = CAShapeLayer()
        layer2.frame = self.view.bounds
        layer2.path = ovalPath.cgPath
        layer2.fillColor = UIColor.clear.cgColor
        self.view.layer.addSublayer(layer2)
        
        let animation2 = CABasicAnimation(keyPath: "fillColor")
//        animation2.beginTime = CACurrentMediaTime()
        animation2.duration = 0.1
        animation2.fromValue = UIColor.clear.cgColor
        animation2.toValue = UIColor.white.cgColor
        animation2.isRemovedOnCompletion = false
        animation2.fillMode = kCAFillModeForwards
        layer2.add(animation2, forKey:"fillColor")
        
        let layer3 = CAShapeLayer()
        layer3.frame = self.view.bounds
        layer3.path = oval2Path.cgPath
        layer3.fillColor = UIColor.clear.cgColor
        self.view.layer.addSublayer(layer3)
        
        let animation3 = CABasicAnimation(keyPath: "fillColor")
        animation3.beginTime = CACurrentMediaTime() + 0.7
        animation3.duration = 0.1
        animation3.fromValue = UIColor.clear.cgColor
        animation3.toValue = UIColor.white.cgColor
        animation3.isRemovedOnCompletion = false
        animation3.fillMode = kCAFillModeForwards
        layer3.add(animation3, forKey:"fillColor")
    }
    
    
    func drawCenterImage() {
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: view.center.x - 150, y: view.center.y - 150, width: 300, height: 300))
        
        let layer = CAShapeLayer()
        layer.frame = self.view.bounds
        layer.path = ovalPath.cgPath
        layer.fillColor = UIColor.clear.cgColor
        self.view.layer.addSublayer(layer)
        
        let animation = CABasicAnimation(keyPath: "fillColor")
//        animation.beginTime = CACurrentMediaTime() + 2.0
        animation.duration = 0.1
        animation.fromValue = UIColor.clear.cgColor
        animation.toValue = UIColor.white.cgColor
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        layer.add(animation, forKey:"fillColor")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startProgressAtRatio() {
        v = 0.0
        
        timer = Timer.scheduledTimer(
            timeInterval: 3 / (1 / 0.002),
            target: self,
            selector: #selector(updateProgressAtRatio),
            userInfo: nil,
            repeats: true
        )
        RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
    }

    func updateProgressAtRatio() {
        v += 0.002
        
        progress.updateRatio(CGFloat(v))
        
        if v > 1.00 {
            v = 0.0
        }
    }
}

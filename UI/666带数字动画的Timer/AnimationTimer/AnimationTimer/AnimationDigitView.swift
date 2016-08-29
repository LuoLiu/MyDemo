//
//  AnimationDigitView.swift
//  TimerDemo
//
//  Created by LuoLiu on 16/8/25.
//  Copyright © 2016年 LuoLiu. All rights reserved.
//

import UIKit
import Foundation

enum FlipAnimationState {
    case Normal
    case TopDown
    case BottomDown
}

class AnimationDigitView: UIView {
    
    //must set in storyboard
    @IBInspectable var maxDigit: Int = 0
    //optional
    @IBInspectable var digitFontSize: CGFloat = 70.0
    @IBInspectable var digitFontColor: UIColor = UIColor.blackColor()
    @IBInspectable var digitBGColor: UIColor = UIColor.whiteColor()
    @IBInspectable var lineHeight: CGFloat = 3.0
    @IBInspectable var lineColor : UIColor = UIColor.whiteColor()
    @IBInspectable var animationDuration: NSTimeInterval = 0.1
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            self.layer.borderColor = self.borderColor!.CGColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = self.borderWidth
        }
    }
    
    private var animationState = FlipAnimationState.Normal
    private var topHalfFrontView = UIView()
    private var bottomHalfFrontView = UIView()
    private var topHalfBackView = UIView()
    private var bottomHalfBackView = UIView()
    private var clockTiles = []
    private var viewIndex = NSNotFound
    private var nextViewIndex = NSNotFound
    
    private var isInit = true
    
    var digit: Int {
        get {
            return self.digit
        }
        set {
            guard newValue != NSNotFound else { return }
            
            if isInit == true {
                let view = clockTiles[newValue] as! UIView
                self.addSubview(view)
                isInit = false
                
                return
            }
            
            let tileCount = clockTiles.count
            viewIndex = newValue - 1
            if viewIndex == -1 {
                viewIndex = tileCount - 1
            }
            if viewIndex == tileCount - 1 {
                nextViewIndex = 0
            } else {
                nextViewIndex = viewIndex + 1
            }
        
            self.changeAnimationState()
        }
    }
    
    override func awakeFromNib() {
        
        let newTiles = NSMutableArray()
        (0...maxDigit).forEach {
            let view = self.viewWithText("\($0)")
            newTiles.addObject(view)
        }
        clockTiles = NSArray(array: newTiles)
    }
    
    private func viewWithText(text: String) -> UIView {
    
        let frame = CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)
        let view = UIView(frame: frame)
        view.backgroundColor = digitBGColor
        
        // digit label
        let lbDigit = UILabel(frame: frame)
        lbDigit.font = UIFont.systemFontOfSize(digitFontSize)
        lbDigit.textAlignment = .Center
        lbDigit.backgroundColor = UIColor.clearColor()
        lbDigit.textColor = digitFontColor
        lbDigit.text = text
        view.addSubview(lbDigit)
        
        // dividing line over the label
        let line = UIView(frame: CGRectMake(0.0, 0.0, self.frame.size.width, lineHeight))
        line.backgroundColor = lineColor
        line.center = lbDigit.center
        
        view.addSubview(line)
        
        return view
    }
}

extension AnimationDigitView {
    
    private func changeAnimationState() {
        switch animationState {
        case .Normal:
            guard viewIndex != NSNotFound && nextViewIndex != NSNotFound else { return }
            
            let view = clockTiles[viewIndex] as! UIView
            let nextView = clockTiles[nextViewIndex] as! UIView
            self.animateViewDown(view, nextView: nextView, duration: animationDuration)
            animationState = .TopDown;
            
        case .TopDown:
            bottomHalfBackView.superview?.bringSubviewToFront(bottomHalfBackView)
            animationState = .BottomDown
            
        case .BottomDown:
            guard nextViewIndex != NSNotFound else { return }
            
            let view = clockTiles[nextViewIndex] as! UIView
            self.addSubview(view)
            
            topHalfFrontView.removeFromSuperview()
            bottomHalfFrontView.removeFromSuperview()
            topHalfBackView.removeFromSuperview()
            bottomHalfBackView.removeFromSuperview()
            topHalfFrontView = UIView()
            bottomHalfFrontView = UIView()
            topHalfBackView = UIView()
            bottomHalfBackView = UIView()
            
            // And reset other state:
            nextViewIndex = NSNotFound
            viewIndex = NSNotFound
            animationState = .Normal
        }
    }
    
    private func snapshotsForView(view: UIView) -> Array<UIView> {
        // Render the tapped view into an image
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.layer.opaque, 0.0)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let renderedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // The size of each part is half the height of the whole image
        let size = CGSizeMake(renderedImage.size.width, renderedImage.size.height / 2)
        UIGraphicsBeginImageContextWithOptions(size, view.layer.opaque, 0.0)
        
        // Draw into context, bottom half is cropped off
        renderedImage.drawAtPoint(CGPointZero)
        // Grab the current contents of the context as a UIImage and add it to array
        let top = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIGraphicsBeginImageContextWithOptions(size, view.layer.opaque, 0.0)
        // Now draw the image starting half way down, to get the bottom half
        renderedImage.drawAtPoint(CGPointMake(CGPointZero.x, -renderedImage.size.height / 2))
        // And add it to the array too
        let bottom = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        let topHalfView = UIImageView(image: top)
        let bottomHalfView = UIImageView(image: bottom)
        let views = [topHalfView, bottomHalfView]
        views.forEach {
            $0.layer.allowsEdgeAntialiasing = true
        }
        
        return views;
    }
    
    private func animateViewDown(view: UIView, nextView: UIView, duration: CFTimeInterval) {
        // Get snapshots for the first view
        let frontViews = self.snapshotsForView(view)
        topHalfFrontView = frontViews.first!
        bottomHalfFrontView = frontViews.last!
        // Move this view to be where the original view is
        topHalfFrontView.frame = CGRectOffset(topHalfFrontView.frame, view.frame.origin.x, view.frame.origin.y)
        self.addSubview(topHalfFrontView)
        
        // Move the bottom half into place
        bottomHalfFrontView.frame = topHalfFrontView.frame;
        bottomHalfFrontView.frame = CGRectOffset(bottomHalfFrontView.frame, 0.0, topHalfFrontView.frame.size.height)
        self.addSubview(bottomHalfFrontView)
        
        // And get rid of the original view
        view.removeFromSuperview()
        
        // Get snapshots for the second view
        let backViews = self.snapshotsForView(nextView)
        topHalfBackView = backViews.first!
        bottomHalfBackView = backViews.last!
        // And place them in the view hierarchy
        topHalfBackView.frame = topHalfFrontView.frame
        self.insertSubview(topHalfBackView, belowSubview: topHalfFrontView)
        bottomHalfBackView.frame = bottomHalfFrontView.frame
        self .insertSubview(bottomHalfBackView, belowSubview: bottomHalfFrontView)
        
        // Skewed identity for camera perspective
        var skewedIdentityTransform = CATransform3DIdentity
        let zDistance: CGFloat = 1000
        skewedIdentityTransform.m34 = 1.0 / -zDistance
        
        // Set the anchor point to the bottom edge
        let newTopViewAnchorPoint = CGPointMake(0.5, 1.0)
        let newTopViewCenter = self.movedCenter(topHalfFrontView.center, oldAnchorPoint: topHalfFrontView.layer.anchorPoint, newAnchorPoint: newTopViewAnchorPoint, withFrame: topHalfFrontView.frame)
        topHalfFrontView.layer.anchorPoint = newTopViewAnchorPoint;
        topHalfFrontView.center = newTopViewCenter
        
        // Add an animation to swing from top to bottom
        let topAnim = CABasicAnimation(keyPath: "transform")
        topAnim.beginTime = CACurrentMediaTime()
        topAnim.duration = duration
        topAnim.fromValue = NSValue(CATransform3D: skewedIdentityTransform)
        topAnim.toValue = NSValue(CATransform3D: CATransform3DRotate(skewedIdentityTransform, CGFloat(-M_PI_2), 1.0, 0.0, 0.0))
        topAnim.delegate = self
        topAnim.removedOnCompletion = false
        topAnim.fillMode = kCAFillModeForwards
        topAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        topHalfFrontView.layer.addAnimation(topAnim, forKey: "topDownFlip")
        
        // Change its anchor point
        let newAnchorPointBottomHalf = CGPointMake(0.5, 0.0)
        let newBottomHalfCenter = self.movedCenter(bottomHalfBackView.center, oldAnchorPoint: bottomHalfBackView.layer.anchorPoint, newAnchorPoint: newAnchorPointBottomHalf, withFrame: bottomHalfBackView.frame)
        bottomHalfBackView.layer.anchorPoint = newAnchorPointBottomHalf
        bottomHalfBackView.center = newBottomHalfCenter
        
        // Add an animation to swing from top to bottom
        let bottomAnim = CABasicAnimation(keyPath: "transform")
        bottomAnim.beginTime = topAnim.beginTime + topAnim.duration
        bottomAnim.duration = topAnim.duration / 4
        bottomAnim.fromValue = NSValue(CATransform3D: CATransform3DRotate(skewedIdentityTransform, CGFloat(M_PI_2), 1.0, 0.0, 0.0))
        bottomAnim.toValue = NSValue(CATransform3D: skewedIdentityTransform)
        bottomAnim.delegate = self
        bottomAnim.removedOnCompletion = false
        bottomAnim.fillMode = kCAFillModeBoth
        bottomAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        bottomHalfBackView.layer.addAnimation(bottomAnim, forKey: "bottomDownFlip")
    }
    
    // Lets you move anchor points around without dealing with CA's implicit frame math
    private func movedCenter(oldCenter: CGPoint, oldAnchorPoint: CGPoint, newAnchorPoint: CGPoint, withFrame: CGRect) -> CGPoint {
        
        let anchorPointDiff = CGPointMake(newAnchorPoint.x - oldAnchorPoint.x, newAnchorPoint.y - oldAnchorPoint.y)
        let newCenter = CGPointMake(oldCenter.x + (anchorPointDiff.x * frame.size.width),
                                    oldCenter.y + (anchorPointDiff.y * frame.size.height))
        return newCenter
    }
}

// MARK: CAAnimation delegate
extension AnimationDigitView {
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        self.changeAnimationState()
    }
}

//
//  XLTransitionAnimator.swift
//  NavAnimation
//
//  Created by LuoLiu on 16/7/27.
//  Copyright © 2016年 LuoLiu. All rights reserved.
//

import UIKit

class XLTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    weak var transitionContext: UIViewControllerContextTransitioning?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        self.transitionContext = transitionContext
        
        let containerView = transitionContext.containerView()
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! ViewController
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! ViewController
        let button = fromVC.popBtn
        
        containerView?.addSubview(toVC.view)
        
        let circleMaskPathInitial = UIBezierPath(ovalInRect: button.frame)
        let extremePoint = CGPoint(x: button.center.x, y: button.center.y - CGRectGetHeight(toVC.view.bounds))
        let radius = sqrt((extremePoint.x * extremePoint.x) + (extremePoint.y * extremePoint.y))
        let circleMaskPathFinal = UIBezierPath(ovalInRect: CGRectInset(button.frame, -radius, -radius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = circleMaskPathFinal.CGPath
        toVC.view.layer.mask = maskLayer
        
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = circleMaskPathInitial.CGPath
        maskLayerAnimation.toValue = circleMaskPathFinal.CGPath
        maskLayerAnimation.duration = self.transitionDuration(transitionContext)
        maskLayerAnimation.delegate = self
        maskLayer.addAnimation(maskLayerAnimation, forKey: "path")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
        self.transitionContext?.completeTransition(!self.transitionContext!.transitionWasCancelled())
        self.transitionContext?.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view.layer.mask = nil
    }
}

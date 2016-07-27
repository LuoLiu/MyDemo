//
//  XLNavigationDelegate.swift
//  NavAnimation
//
//  Created by LuoLiu on 16/7/27.
//  Copyright © 2016年 LuoLiu. All rights reserved.
//

import UIKit

class XLNavigationDelegate: NSObject, UINavigationControllerDelegate {

    @IBOutlet weak var navigationController: UINavigationController!
    var interactionController: UIPercentDrivenInteractiveTransition?
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return XLTransitionAnimator();
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return self.interactionController
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.panned(_:)))
        self.navigationController.view.addGestureRecognizer(panGesture)
    }
    
    func panned(gestureRecognizer: UIPanGestureRecognizer) {
        
        switch gestureRecognizer.state {
        case .Began:
            self.interactionController = UIPercentDrivenInteractiveTransition()
            if self.navigationController.viewControllers.count > 1 {
                self.navigationController.popViewControllerAnimated(true)
            } else {
                self.navigationController.topViewController?.performSegueWithIdentifier("PushSegue", sender: nil)
            }
            
        case .Changed:
            let translation = gestureRecognizer.translationInView(self.navigationController.view)
            let completionProgress = translation.x / CGRectGetWidth(self.navigationController.view.bounds)
            self.interactionController?.updateInteractiveTransition(abs(completionProgress))
            
        case .Ended:
            let completionProgress = gestureRecognizer.translationInView(self.navigationController.view).x / CGRectGetWidth(self.navigationController.view.bounds)

            if abs(completionProgress) > 0.1 {
                self.interactionController?.finishInteractiveTransition()
            } else {
                self.interactionController?.cancelInteractiveTransition()
            }

            self.interactionController = nil
            
        default:
            self.interactionController?.cancelInteractiveTransition()
            self.interactionController = nil
        }
    }
}

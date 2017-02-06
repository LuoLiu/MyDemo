//
//  ViewController.swift
//  AnimationDemo
//
//  Created by LuoLiu on 16/12/26.
//  Copyright © 2016年 LuoLiu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var containerOne: UIView!
    
    @IBOutlet weak var containerTwo: UIView!
    
    @IBOutlet weak var containerThree: UIView!
    
    @IBOutlet weak var helloLabel: UILabel!
    
    let viewOne = UIImageView()
    let viewTwo = UIImageView()
    let viewThree = UIImageView()
    let helloLabelCopy = UILabel()

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewOne.frame = containerOne.bounds
        viewOne.image = UIImage(named: "1")
        viewOne.layer.shadowOffset = CGSizeMake(3, 2)
        viewOne.layer.shadowOpacity = 0.5
        
        viewTwo.frame = containerTwo.bounds
        viewTwo.image = UIImage(named: "2")
        viewTwo.layer.shadowOffset = CGSizeMake(3, 2)
        viewTwo.layer.shadowOpacity = 0.5
        
        viewThree.frame = containerThree.bounds
        viewThree.image = UIImage(named: "3")
        viewThree.layer.shadowOffset = CGSizeMake(3, 2)
        viewThree.layer.shadowOpacity = 0.5
        
        helloLabelCopy.frame = self.helloLabel.frame
        helloLabelCopy.alpha = 0.0
        helloLabelCopy.text = self.helloLabel.text
        helloLabelCopy.font = self.helloLabel.font
        helloLabelCopy.textColor = self.helloLabel.textColor
        helloLabelCopy.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.0, 0.1), CGAffineTransformMakeTranslation(1.0, self.helloLabel.frame.height / 2))
        self.view.addSubview(helloLabelCopy)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        delay(0) {
            UIView.transitionWithView(self.containerOne, duration: 1.5, options: [.CurveEaseOut, .TransitionFlipFromBottom], animations: {
                self.containerOne.addSubview(self.viewOne)
                }, completion: nil)
        }
        
        delay(1) {
            UIView.transitionWithView(self.containerTwo, duration: 1.5, options: [.CurveEaseOut, .TransitionFlipFromLeft], animations: {
                self.containerTwo.addSubview(self.viewTwo)
                }, completion: nil)
        }
        
        delay(2) {
            UIView.transitionWithView(self.containerThree, duration: 1.5, options: [.CurveEaseOut, .TransitionFlipFromRight], animations: {
                self.containerThree.addSubview(self.viewThree)
                }, completion: nil)
        }
        
        UIView.animateWithDuration(2.0, delay: 3.0, options: [.Repeat], animations: {
            self.helloLabel.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.0, 0.5), CGAffineTransformMakeTranslation(1.0, -self.helloLabel.frame.height / 2))
            self.helloLabel.alpha = 0.0
            self.helloLabelCopy.alpha = 1.0
            self.helloLabelCopy.transform = CGAffineTransformIdentity
            }, completion: nil)
    }
    
    func delay(seconds: Double, completion:()->()) {
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC) * seconds))
        dispatch_after(delayTime, dispatch_get_main_queue()) { 
            completion()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


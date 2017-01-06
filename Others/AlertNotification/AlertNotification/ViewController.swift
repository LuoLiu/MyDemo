//
//  ViewController.swift
//  AlertNotification
//
//  Created by LuoLiu on 17/1/6.
//  Copyright © 2017年 LuoLiu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func popAlert(_ sender: Any) {
        
        if let alertView = Bundle.main.loadNibNamed("AlertNotificationView", owner: self, options: nil)?.first as? AlertNotificationView {
            alertView.showAtContainerView(containerView: self.view)
        }
//                let a = UIAlertController(title: "1", message: "1", preferredStyle: .alert)
//                a.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
//                    a.dismiss(animated: true, completion: nil)
//                }))
//                self.present(a, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


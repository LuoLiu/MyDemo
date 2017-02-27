//
//  ViewController.swift
//  MarqueeLabel
//
//  Created by LuoLiu on 17/2/27.
//  Copyright © 2017年 Fenrir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titles = ["111111", "22222222", "33333333", "4444444444", "555555"]
        let mView = MarqueeView(frame: CGRect(x: 5, y: 64, width: self.view.frame.size.width-10, height: 30), titles: titles)
        mView.backgroundColor = UIColor.black
        mView.textColor = UIColor.white
        mView.fontSize = 20.0
        mView.timeInterval = 2
        
        self.view.addSubview(mView)
        mView.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


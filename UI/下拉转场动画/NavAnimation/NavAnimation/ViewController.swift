//
//  ViewController.swift
//  NavAnimation
//
//  Created by LuoLiu on 16/7/27.
//  Copyright © 2016年 LuoLiu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var popBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func popClick(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}


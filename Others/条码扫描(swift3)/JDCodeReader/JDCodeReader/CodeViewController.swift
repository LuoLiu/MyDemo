//
//  CodeViewController.swift
//  JDCodeReader
//
//  Created by LuoLiu on 17/1/19.
//  Copyright © 2017年 LuoLiu. All rights reserved.
//

import UIKit

class CodeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    @IBAction func unwindToHomeScreen(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
}

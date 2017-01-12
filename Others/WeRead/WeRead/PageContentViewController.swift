//
//  PageContentViewController.swift
//  WeRead
//
//  Created by LuoLiu on 17/1/10.
//  Copyright © 2017年 LuoLiu. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {
    
    var pageIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        let label = UILabel(frame: CGRect(x: 140, y: 100, width: 100, height: 30))
        label.text = "Page \(pageIndex!)"
        view.addSubview(label)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

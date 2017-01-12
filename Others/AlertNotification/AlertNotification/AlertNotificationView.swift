//
//  AlertNotificationView.swift
//  AlertNotification
//
//  Created by LuoLiu on 17/1/6.
//  Copyright © 2017年 LuoLiu. All rights reserved.
//

import UIKit

class AlertNotificationView: UIView {
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tableHeightConst: NSLayoutConstraint!
    
    @IBOutlet weak var badgeLabelOne: UILabel!
    @IBOutlet weak var badgeLabelTwo: UILabel!

    var detailTable: AlertTableViewController?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        backgroundColor = UIColor(white: 0.0, alpha: 0.3)

        self.bindData()
    }

    private func bindData() {
        // 测试数据
        let m1 = TestModel(title: "フリーワードが入ります、フリーワフリーワードが入ります、フリーワ")
        let m2 = TestModel(title: "群馬県：新前橋、前橋、前橋大島、群馬県：新前橋、前橋、前橋大島")
        let m3 = TestModel(title: "正社員")

        detailTable = AlertTableViewController(dataList: [m1, m2, m3])
        
        badgeLabelOne.text = "10"
        badgeLabelTwo.text = "3"
    }

    func showAtContainerView(containerView: UIView) {
        self.alertView.alpha = 0.0
        self.frame = containerView.frame
        containerView.addSubview(self)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.transitionCrossDissolve], animations: {
            self.resizeDetailTableView()
        }) { _ in
            self.alertView.alpha = 1.0
        }
    }
    
    func hiddenAnimation() {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
            self.alpha = 0.0
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
    private func resizeDetailTableView() {
        if let tableView = self.detailTable?.tableView {
            tableView.reloadData()
            tableView.layoutIfNeeded()
            
            var frame = CGRect()
            frame.origin.x = self.topView.frame.origin.x + 4
            frame.origin.y = self.topView.frame.origin.y + self.topView.frame.height + 8
            frame.size.width = self.topView.frame.width - 8
            frame.size.height = min(tableView.contentSize.height, 250) // 250是随便写的最大高度
            
            tableView.frame = frame
            tableView.bounces = tableView.contentSize.height > 250
            self.tableHeightConst.constant = frame.height + 16
            // 下面两句代码的顺序不要乱动
            self.layoutIfNeeded()
            self.alertView.addSubview(tableView)
        }
    }
    
    @IBAction func cellOneTapped(_ sender: Any) {
        print("You click [新着のMy求人]")
    }
    
    @IBAction func cellTwoTapped(_ sender: Any) {
        print("You click [すべてのMy求人]")
    }
    
    @IBAction func okBtnTapped(_ sender: Any) {
        self.hiddenAnimation()
    }
}

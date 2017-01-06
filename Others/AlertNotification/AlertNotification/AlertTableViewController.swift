//
//  AlertTableViewController.swift
//  AlertNotification
//
//  Created by LuoLiu on 17/1/6.
//  Copyright © 2017年 LuoLiu. All rights reserved.
//

import UIKit

// 测试数据的Model
struct TestModel {
    var image: UIImage = #imageLiteral(resourceName: "image1")
    var title: String = ""
    
    init(title: String) {
        self.title = title
    }
}

class AlertTableViewController: UITableViewController {

    var dataList: Array<TestModel>?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(dataList: [TestModel]) {
        self.dataList = dataList
        super.init(style: .plain)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 20
        
        tableView.register(UINib.init(nibName: "AlertDetailCell", bundle: nil), forCellReuseIdentifier: AlertDetailCell.identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlertDetailCell.identifier, for: indexPath) as! AlertDetailCell

        let data = dataList![indexPath.row]
        cell.configCell(iconImage: data.image, content: data.title)

        return cell
    }
}

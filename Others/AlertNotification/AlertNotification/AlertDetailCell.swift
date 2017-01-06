//
//  AlertDetailCell.swift
//  AlertNotification
//
//  Created by LuoLiu on 17/1/6.
//  Copyright © 2017年 LuoLiu. All rights reserved.
//

import UIKit

class AlertDetailCell: UITableViewCell {

    static let identifier = "AlertDetailCell"
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    func configCell(iconImage: UIImage, content: String) {
        self.iconImage.image = iconImage
        self.contentLabel.text = content
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

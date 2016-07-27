//
//  TagCell.swift
//  AlbumDemo
//
//  Created by LuoLiu on 16/6/23.
//  Copyright © 2016年 fenrir. All rights reserved.
//

import UIKit

class MyTagCell: UICollectionViewCell {
    
    let lbTag: UILabel
    var isHeightCalculated: Bool = false

    override init(frame: CGRect) {
        lbTag = UILabel(frame: frame)
        lbTag.translatesAutoresizingMaskIntoConstraints = false
        super.init(frame: frame)

        contentView.addSubview(lbTag)
        
        let views = ["lbTag" : lbTag]
        // 宽度约束为cell最大宽度
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-8-[lbTag(<=120)]-8-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[lbTag(40)]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        contentView.backgroundColor = .whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func preferredLayoutAttributesFittingAttributes(layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        super.preferredLayoutAttributesFittingAttributes(layoutAttributes)
        
        if !isHeightCalculated {
            setNeedsLayout()
            layoutIfNeeded()
            let size = contentView.systemLayoutSizeFittingSize(layoutAttributes.size)
            layoutAttributes.frame.size.width = CGFloat(ceilf(Float(size.width)))
            isHeightCalculated = true
        }
        return layoutAttributes
    }
}

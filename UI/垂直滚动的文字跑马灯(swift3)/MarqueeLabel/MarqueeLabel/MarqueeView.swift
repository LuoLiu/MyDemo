//
//  MarqueeView.swift
//  MarqueeLabel
//
//  Created by LuoLiu on 17/2/27.
//  Copyright © 2017年 Fenrir. All rights reserved.
//

import UIKit

class MarqueeView: UIView {
    
    private var titles: [String]
    private var lblOne = UILabel()
    private var lblTwo = UILabel()
    private var lblArr = [UILabel]()
    private var index: Int
    private var leftMargin: CGFloat = 0
    private var timer: Timer?
    
    var textColor: UIColor = UIColor.black {
        willSet {
            lblOne.textColor = newValue
            lblTwo.textColor = newValue
        }
    }
    
    var fontSize: CGFloat = 14 {
        willSet {
            lblOne.font = UIFont.systemFont(ofSize: newValue)
            lblTwo.font = UIFont.systemFont(ofSize: newValue)
        }
    }
    
    var timeInterval = TimeInterval(1) {
        willSet {
            self.timer = Timer(timeInterval: newValue * 2, target: self, selector: #selector(scrollAnimation), userInfo: nil, repeats: true)
        }
    }
    
    init(frame: CGRect, titles: [String]) {
        
        self.titles = titles
        self.index = 0
        
        super.init(frame: frame)
        
        if self.titles.count > 0 {
            lblOne.text = self.titles[index]
        }
        lblOne.textAlignment = .center
        lblTwo.textAlignment = .center
        self.addSubview(lblOne)
        self.addSubview(lblTwo)
        lblArr = [lblOne, lblTwo]
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollAnimation() {
        
        guard titles.count > 1 else {
            timer?.invalidate()
            timer = nil
            return
        }
        
        var currentLabel = UILabel()
        var hidenLabel = UILabel()
        
        lblArr.forEach { label in
            let str = titles[index]
            if label.text == str {
                currentLabel = label
            } else {
                hidenLabel = label
            }
        }
        
        if index != titles.count - 1 {
            index += 1
        } else {
            index = 0
        }
        
        hidenLabel.text = self.titles[index]
        hidenLabel.alpha = 0.0
        UIView.animate(withDuration: timeInterval, delay: 0, options: .curveEaseIn, animations: {
            hidenLabel.frame = CGRect(x: self.leftMargin, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
            hidenLabel.alpha = 1.0
            currentLabel.frame = CGRect(x: self.leftMargin, y: -self.bounds.size.height, width: self.bounds.size.width, height: self.bounds.size.height)
            currentLabel.alpha = 0.0
        }) { _ in
            currentLabel.frame = CGRect(x: self.leftMargin, y: self.bounds.size.height, width: self.bounds.size.width, height: self.bounds.size.height)
            currentLabel.alpha = 1.0
        }
    }
    
    func start() {
        RunLoop.main.add(timer!, forMode: .defaultRunLoopMode)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        lblOne.frame = CGRect(x: leftMargin, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        lblTwo.frame = CGRect(x: leftMargin, y: self.bounds.size.height, width: self.bounds.size.width, height: self.bounds.size.height)
    }
}

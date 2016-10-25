//
//  FigureView.swift
//  UndoManager
//
//  Created by LuoLiu on 16/10/24.
//  Copyright © 2016年 LuoLiu. All rights reserved.
//

import UIKit

class FigureView: UIView {
    
    override var undoManager: UndoManager {
        return UndoManager()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.undoManager.groupsByEvent = false
        self.setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        let defaultColor = UIColor.lightGray
        backgroundColor = defaultColor
        layer.borderColor = defaultColor.cgColor
        layer.borderWidth = 1.0
    }
    
    var cornerRadius: NSNumber {
        set {
            self.layer.cornerRadius = CGFloat(newValue.floatValue)
        }
        
        get {
            return NSNumber(value: Float(self.layer.cornerRadius))
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
}

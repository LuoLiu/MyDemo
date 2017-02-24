//
//  MyStyle.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/11/25.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import GradientCircularProgress

public struct MyStyle: StyleProperty {
    /*** style properties **********************************************************************************/
    
    // Progress Size
    public var progressSize: CGFloat = 320
    
    // Gradient Circular
    public var arcLineWidth: CGFloat = 10.0
    public var startArcColor: UIColor = UIColor.black
    public var endArcColor: UIColor = UIColor.black
    
    // Base Circular
    public var baseLineWidth: CGFloat? = 11.0
    public var baseArcColor: UIColor? = UIColor.lightGray
    
    // Ratio
    public var ratioLabelFont: UIFont? = UIFont(name: "Verdana-Bold", size: 16.0)
    public var ratioLabelFontColor: UIColor? = UIColor.black
    
    // Message
    public var messageLabelFont: UIFont? = UIFont.systemFont(ofSize: 16.0)
    public var messageLabelFontColor: UIColor? = UIColor.black
    
    // Background
    public var backgroundStyle: BackgroundStyles = .none
    
    // Dismiss
    public var dismissTimeInterval: Double? // 'nil' for default setting.
    
    /*** style properties **********************************************************************************/
    
    public init() {}
}

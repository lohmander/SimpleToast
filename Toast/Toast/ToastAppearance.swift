//
//  ToastAppearance.swift
//  Toast
//
//  Created by Hannes Lohmander on 13/07/15.
//  Copyright (c) 2015 Lohmander. All rights reserved.
//

import Foundation

public class ToastAppearance {
    
    /// Toast background corner radius
    public var cornerRadius: CGFloat = 4
    
    /// Padding between the text label and the toast background
    public var padding: CGFloat = 10
    
    /// The label text color
    public var color: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
    
    /// The label text color
    public var textColor: UIColor = UIColor.whiteColor()
    
    /// The duration of the fade in animation
    public var animationDuration: NSTimeInterval = 0.5
    
    public var font: UIFont = UIFont(name: "Roboto-Regular", size: 20)!
}

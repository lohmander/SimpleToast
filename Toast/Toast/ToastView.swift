//
//  ToastView.swift
//  Toast
//
//  Created by Hannes Lohmander on 13/07/15.
//  Copyright (c) 2015 Lohmander. All rights reserved.
//

import Foundation

extension UILabel{
    
    func requiredHeight() -> CGFloat{
        
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, self.frame.width, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = self.font
        label.text = self.text
        
        label.sizeToFit()
        
        return label.frame.height
    }
}

class ToastView: UIView {
    var textLabel: UILabel?
    
    private var constraintsSet: Bool = false
    
    private var ko = KeyboardObserver()
    
    required init() {
        super.init(frame: CGRectZero)
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    init(text: String, parent: UIView, appearance: ToastAppearance) {
        super.init(frame: CGRectZero)
        setup(text, parent: parent, appearance: appearance)
    }
    
    private func setup(text: String, parent: UIView, appearance: ToastAppearance) {
        
        self.alpha = 0
        self.backgroundColor = appearance.backgroundColor
        self.layer.cornerRadius = appearance.cornerRadius
        
        textLabel = UILabel()
        textLabel?.textColor = appearance.textColor
        textLabel?.numberOfLines = 0
        textLabel?.textAlignment = NSTextAlignment.Center
        textLabel?.font = appearance.font
        
        self.addSubview(textLabel!)
        
        frame = CGRectMake(10, parent.frame.size.height, parent.frame.size.width - 20, 100)
        
        textLabel?.frame = CGRectMake(0 + appearance.padding,
                                      0 + appearance.padding,
                                      frame.size.width - appearance.padding * 2,
                                      1000)
        textLabel?.text = text
        let size = textLabel?.sizeThatFits(CGSizeMake(frame.size.width - appearance.padding * 2, 1000))
        textLabel!.frame = CGRectMake( textLabel!.frame.origin.x,
                                      textLabel!.frame.origin.y,
                                      textLabel!.frame.size.width,
                                      size!.height
        )
        
        let yMargin: CGFloat
        
        if let kO = Toast.keyboardObserver {
            yMargin = kO.offset
        } else {
            yMargin = 0
        }
        
        frame = CGRectMake(frame.origin.x,
                           frame.origin.y - textLabel!.frame.size.height - appearance.padding * 2 - 10 - yMargin,
                           frame.size.width,
                           textLabel!.frame.size.height + appearance.padding * 2)
    }
 
}

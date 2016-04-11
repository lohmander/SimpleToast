//
//  Toast.swift
//  Toast
//
//  Created by Hannes Lohmander on 13/07/15.
//  Copyright (c) 2015 Lohmander. All rights reserved.
//

import Foundation

public class Toast {
    public static let LENGTH_SHORT: Double = 2
    public static let LENGTH_LONG: Double = 5
    
    /// Shared toast appearance settings
    let appearance: ToastAppearance!
    
    /// Shared keyboard observer used to determine appropriate toast position
    static var keyboardObserver: KeyboardObserver?
    
    var text: String!
    var duration: Double!
    var toast: ToastView!
    
    public init(appearance: ToastAppearance) {
        self.appearance = appearance
    }
    
    /**
        Initializes keyboard observer used to figure out the appropriate
        toast position 
    
        :returns: Void
    */
    public class func initKeyboardObserver() -> Void {
        Toast.keyboardObserver = KeyboardObserver()
    }
    
    /**
        Initializes a Toast-object with sepcified text and duration
    
        :param: text Text message to show
        :param: duration Time to show the toast
        
        :returns: Toast
    */
    public class func makeText(text: String, duration: Double = Toast.LENGTH_LONG, appearance: ToastAppearance = ToastAppearance()) -> Toast {
        let toast = Toast(appearance: appearance)
        
        toast.text = text
        toast.duration = duration
        
        return toast
    }
    
    /**
        Displays the toast on screen
    
        :returns: Void
    */
    public func show() -> Void {
        let nc = UIApplication.sharedApplication().keyWindow!.rootViewController as! UINavigationController
        let vc = nc.viewControllers.last
                
        if let windowView = vc?.view {
            toast = ToastView(text: self.text, parent: windowView, appearance: appearance)
            
            windowView.addSubview(toast)
            
            UIView.animateWithDuration(appearance.animationDuration, animations: { () -> Void in
                self.toast.alpha = 1
            })
            
            delayHide(duration)
        }
    }
    
    /**
        Hide the toast
    
        :returns: Void
    */
    public func hide() -> Void {
        UIView.animateWithDuration(appearance.animationDuration, animations: { () -> Void in
            self.toast.alpha = 0
        }) { (_) -> Void in
            self.remove()
        }
    }
    
    /**
        Hide the toast after x seconds
    
        :param: delay Number of seconds to wait before hiding
    
        :returns: Void
    */
    public func delayHide(delay: Double) -> Void {
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
        
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.hide()
        }
    }
    
    /**
        Remove the toast from the view tree (automatically called by
        hide after animation has finished)
    
        :returns: Void
    */
    public func remove() -> Void {
        self.toast.removeFromSuperview()
    }
}

//
//  OptionsMenuButton.swift
//  VeriForm
//
//  Created by Niklas Fahl on 9/2/15.
//  Copyright © 2015 CAPS. All rights reserved.
//

import UIKit

public class CAPSOptionsMenuButton: UIButton {
    var optionsMenuButtonBackgroundColor: UIColor = UIColor.whiteColor()
    var optionsMenuButtonHighlightedColor: UIColor = UIColor.lightGrayColor()
    
    /// Options Action Initializer
    ///
    /// - parameters:
    ///   - frame: Initial frame of menu button
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = optionsMenuButtonBackgroundColor
    }
    
    /// Options Action Initializer
    ///
    /// - parameters:
    ///   - frame: Initial frame of menu button
    ///   - backgroundColor: Menu button background color
    ///   - highlightedColor: Menu button color for highlighted state
    init(frame: CGRect, backgroundColor: UIColor?, highlightedColor: UIColor?) {
        super.init(frame: frame)
        
        if let bgColor = backgroundColor { optionsMenuButtonBackgroundColor = bgColor }
        if let hColor = highlightedColor { optionsMenuButtonHighlightedColor = hColor }
        
        self.backgroundColor = optionsMenuButtonBackgroundColor
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Tap handling
    override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        touchDown()
    }
    
    override public func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        touchUp()
    }
    
    override public func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        super.touchesCancelled(touches, withEvent: event)
        touchUp()
    }
    
    // MARK: - Touch down/up
    private func touchDown() {
        UIView.animateWithDuration(0.1) { () -> Void in
            self.backgroundColor = self.optionsMenuButtonHighlightedColor
        }
    }
    
    private func touchUp() {
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.15 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.backgroundColor = self.optionsMenuButtonBackgroundColor
        }
    }

}

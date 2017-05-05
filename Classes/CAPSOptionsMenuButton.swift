//
//  OptionsMenuButton.swift
//  VeriForm
//
//  Created by Niklas Fahl on 9/2/15.
//  Copyright © 2015 CAPS. All rights reserved.
//

import UIKit

public class CAPSOptionsMenuButton: UIButton {
    var optionsMenuButtonBackgroundColor: UIColor = UIColor.white
    var optionsMenuButtonHighlightedColor: UIColor = UIColor.lightGray
    
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
    public init(frame: CGRect, backgroundColor: UIColor?, highlightedColor: UIColor?) {
        super.init(frame: frame)
        
        if let bgColor = backgroundColor { optionsMenuButtonBackgroundColor = bgColor }
        if let hColor = highlightedColor { optionsMenuButtonHighlightedColor = hColor }
        
        self.backgroundColor = optionsMenuButtonBackgroundColor
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Tap handling
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        touchDown()
    }
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        touchUp()
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        super.touchesCancelled(touches!, with: event)
        touchUp()
    }
    
    // MARK: - Touch down/up
    private func touchDown() {
        UIView.animate(withDuration: 0.1) { () -> Void in
            self.backgroundColor = self.optionsMenuButtonHighlightedColor
        }
    }
    
    private func touchUp() {
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.backgroundColor = self.optionsMenuButtonBackgroundColor
        }
    }

}

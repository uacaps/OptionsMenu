//
//  OptionsMenuButton.swift
//  VeriForm
//
//  Created by Niklas Fahl on 9/2/15.
//  Copyright © 2015 CAPS. All rights reserved.
//

import UIKit

class CAPSOptionsMenuButton: UIButton {
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
    init(frame: CGRect, backgroundColor: UIColor?, highlightedColor: UIColor?) {
        super.init(frame: frame)
        
        if let bgColor = backgroundColor { optionsMenuButtonBackgroundColor = bgColor }
        if let hColor = highlightedColor { optionsMenuButtonHighlightedColor = hColor }
        
        self.backgroundColor = optionsMenuButtonBackgroundColor
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Tap handling
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        touchDown()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        touchUp()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        touchUp()
    }
    
    // MARK: - Touch down/up
    fileprivate func touchDown() {
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.backgroundColor = self.optionsMenuButtonHighlightedColor
        }) 
    }
    
    fileprivate func touchUp() {
        let delayTime = DispatchTime.now() + Double(Int64(0.15 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            self.backgroundColor = self.optionsMenuButtonBackgroundColor
        }
    }

}

//
//  OptionsMenuAction.swift
//  VeriForm
//
//  Created by Niklas Fahl on 8/31/15.
//  Copyright © 2015 CAPS. All rights reserved.
//

import UIKit

public class CAPSOptionsMenuAction: NSObject {
    var title: String = ""
    var actionHandler: ((CAPSOptionsMenuAction) -> Void)
    var image: UIImage?
    
    /// Options Action Initializer
    ///
    /// - parameters:
    ///   - title: Title to be displayed on action button in menu
    ///   - handler: Completion handler for action button tap
    public init(title: String, handler: ((CAPSOptionsMenuAction) -> Void)) {
        actionHandler = handler
        super.init()
    
        self.title = title
    }
    
    
    public convenience init(title: String, image: UIImage?, handler: ((CAPSOptionsMenuAction) -> Void) ) {
        self.init(title: title, handler: handler)
        self.image = image
    }
    
}

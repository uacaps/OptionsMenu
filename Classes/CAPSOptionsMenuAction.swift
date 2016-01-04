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
    
    /// Options Action Initializer
    ///
    /// - parameters:
    ///   - title: Title to be displayed on action button in menu
    ///   - handler: Completion handler for action button tap
    init(title: String, handler: ((CAPSOptionsMenuAction) -> Void)) {
        actionHandler = handler
        super.init()
    
        self.title = title
    }
}

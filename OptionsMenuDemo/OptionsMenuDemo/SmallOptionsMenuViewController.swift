//
//  SmallOptionsMenuViewController.swift
//  OptionsMenuDemo
//
//  Created by Niklas Fahl on 9/2/15.
//  Copyright © 2015 CAPS. All rights reserved.
//

import UIKit

class SmallOptionsMenuViewController: UIViewController {

    var optionsMenu: CAPSOptionsMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Small Options Menu"
        
        addOptionsMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addOptionsMenu() {
        optionsMenu = CAPSOptionsMenu(viewController: self, barButtonSystemItem: UIBarButtonSystemItem.Organize, keepBarButtonAtEdge: true)
        optionsMenu?.menuActionButtonsHighlightedColor(UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0))
        optionsMenu?.menuCornerRadius(2.0)
        
        let menuAction1: CAPSOptionsMenuAction = CAPSOptionsMenuAction(title: "Action Title 1") { (action: CAPSOptionsMenuAction) -> Void in
            print("Tapped Action Button 1")
        }
        optionsMenu?.addAction(menuAction1)
        
        let menuAction2: CAPSOptionsMenuAction = CAPSOptionsMenuAction(title: "Action Title 2") { (action: CAPSOptionsMenuAction) -> Void in
            print("Tapped Action Button 2")
        }
        optionsMenu?.addAction(menuAction2)
        
        let menuAction3: CAPSOptionsMenuAction = CAPSOptionsMenuAction(title: "Action Title 3") { (action: CAPSOptionsMenuAction) -> Void in
            print("Tapped Action Button 3")
        }
        optionsMenu?.addAction(menuAction3)
    }
    
    @IBAction func animationSegmentedControlChangedValue(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            optionsMenu?.menuAnimationOption(AnimationOption.Expand)
        } else {
            optionsMenu?.menuAnimationOption(AnimationOption.Fade)
        }
    }
    
    @IBAction func animationDurationSegmentedControlChangedValue(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            optionsMenu?.menuAnimationDuration(0.2)
        } else {
            optionsMenu?.menuAnimationDuration(0.0)
        }
    }
}

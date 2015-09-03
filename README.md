<img src="https://raw.githubusercontent.com/uacaps/ResourceRepo/master/OptionsMenu/OptionsMenuHeader.png" alt="OptionsMenuHeader">

**Built for Swift 2.0 and developed by [Niklas Fahl (fahlout)](http://bit.ly/fahlout)**

## Description

OptionsMenu is a library written in Swift based on the options menu in material design in Android that allows you to easily add a menu to the navigation bar by adding a bar button item to the right side of the navigation bar, which then lets you open and close the menu. OptionsMenu is a popover style menu, which is set up as easy as a UIAlertController with every added action corresponding to a button in the menu. Actions are easily handled with a completion handler.

<img src="https://raw.githubusercontent.com/uacaps/ResourceRepo/master/OptionsMenu/OptionsMenuDemoGif.gif" alt="OptionsMenuDemoGif">

## Table of Contents

* [Installation](#installation)
* [How to use OptionsMenu](#how-to-use-optionsmenu)
* [Customization](#customization)
* [Apps using OptionsMenu](#apps-using-optionsmenu)
* [Future Work](#future-work)
* [License](#license)

## Installation

**Cocoa Pods**

* Coming soon

**Carthage**

* Coming soon

**Manual Installation**

The class files required for OptionsMenu are located in the Classes folder in the root of this repository as listed below:

```Swift
CAPSOptionsMenu.swift
CAPSOptionsMenuAction.swift
CAPSOptionsMenuButton.swift
```

## How to use OptionsMenu

Once installed (See Installation section for more details) you will need a view controller, which is inside of a navigation controller in order to set up the menu. After that it is very easy to set up OptionsMenu from that view controller as shown below.

```Swift
/// Initialize with parent view controller and bar button image name
///
/// -parameters:
///   - viewController: View controller holding the navigation controller with the navigation bar the menu is to be put on
///   - imageName: Name for menu bar button image
///   - keepBarButtonOnRightEdge: If `true`, menu bar button will always stay on the rightmost position
let optionsMenu: CAPSOptionsMenu  = CAPSOptionsMenu(viewController: self, imageName: "ImageName", keepBarButtonAtEdge: true)

/// Initialize with parent view controller and bar button image
///
/// -parameters:
///   - viewController: View controller holding the navigation controller with the navigation bar the menu is to be put on
///   - image: Image for menu bar button
///   - keepBarButtonOnRightEdge: If `true`, menu bar button will always stay on the rightmost position
let optionsMenu: CAPSOptionsMenu  = CAPSOptionsMenu(viewController: self, image: UIImage(), keepBarButtonAtEdge: true)

/// Initialize with parent view controller and bar button system item
///
/// -parameters:
///   - viewController: View controller holding the navigation controller with the navigation bar the menu is to be put on
///   - barButtonSystemItem: Bar button system item for menu bar button
///   - keepBarButtonOnRightEdge: If `true`, menu bar button will always stay on the rightmost position
let optionsMenu: CAPSOptionsMenu  = CAPSOptionsMenu(viewController: self, barButtonSystemItem: UIBarButtonSystemItem.Organize, keepBarButtonAtEdge: true)
```
(If you want to do further manipulation on the menu later on, don't forget to set it up as a property in the view controller)

Menu Actions can be added easily as shown below. You can add as many actions as you would like. If there is not enough space to show all actions the menu will start to scroll.

```Swift
/// Options Action Setup
///
/// - parameters:
///   - title: Title to be displayed on action button in menu
///   - handler: Completion handler for action button tap (can be nil)
let menuAction1: CAPSOptionsMenuAction = CAPSOptionsMenuAction(title: "Action Title 1") { (action: CAPSOptionsMenuAction) -> Void in
   print("Tapped Action Button 1")
}
optionsMenu.addAction(menuAction1)
```

## Customization
OptionsMenu is fully customizable and lets you be able to make it fit in with your app's theme. In order to make sure everything updates properly please only use the functions listed below to make customization changes and don't set any properties manually as that won't necessarily reflect the way you would expect it in the OptionsMenu.

**Customize everything at once**

If you want to make a lot of changes at once I recommend using the following method as it lets you change every customization options possible at once and be able to send in 'nil' for any property that you want to leave as the default value.
```Swift
/// This methods lets you customize every customization option in one method call
///
/// - parameters:
///   - width: Maximum width of the menu
///   - shadow: If `true`, shadow is added to the menu
///   - shadowColor: Shadow color for the menu
///   - backgroundColor: Background color for the menu
///   - borderWidth: Border width for the menu
///   - borderColor: Border color for the menu
///   - actionButtonsTitleColor: Title color for the menu action buttons
///   - actionButtonsHighlightedColor: Background color for the menu action buttons when tapped
///   - cornerRadius: Corner radius for the menu
///   - animationOption: Animation option for the menu open/close animation style
///      - .Fade - menu will fade in/out
///      - .Expand - menu will expand and contract from bar button center
///      - .None - menu will appear and disappear without animations
///   - animationDuration: Animation duration for the menu open/close animation
func customizeWith(maxMenuWidth maxMenuWidth: CGFloat?, shadow: Bool?, shadowColor: UIColor?, backgroundColor: UIColor?, borderWidth: CGFloat?, borderColor: UIColor?, actionButtonsTitleColor: UIColor?, actionButtonsHighlightedColor: UIColor?, cornerRadius: CGFloat?, animationOption: AnimationOption?, animationDuration: NSTimeInterval?)
```

**Customize individual options**

* Menu Max Width
```Swift
/// - parameters:
///   - width: Maximum width of the menu
func menuMaxWidth(width: CGFloat)
```    

* Menu Has Shadow
```Swift
/// - parameters:
///   - shadow: If `true`, shadow is added to the menu
func menuHasShadow(shadow: Bool)
```

* Menu Shadow Color
```Swift
/// - parameters:
///   - color: Shadow color for the menu
func menuShadowColor(color: UIColor)
```

* Menu Background Color
```Swift
/// - parameters:
///   - color: Background color for the menu
func menuBackgroundColor(color: UIColor)
```

* Menu Border Width
```Swift
/// - parameters:
///   - width: Border width for the menu
func menuBorderWidth(width: CGFloat)
```

* Menu Border Color
```Swift
/// - parameters:
///   - color: Border color for the menu
func menuBorderColor(color: UIColor)
```

* Menu Action Buttons Title Color
```Swift
/// - parameters:
///   - color: Title color for the menu action buttons
func menuActionButtonsTitleColor(color: UIColor)
```

* Menu Action Buttons Highlighted Color
```Swift
/// - parameters:
///   - color: Background color for the menu action buttons when tapped
func menuActionButtonsHighlightedColor(color: UIColor)
```

* Menu Corner Radius
```Swift
/// - parameters:
///   - radius: Corner radius for the menu
func menuCornerRadius(radius: CGFloat)
```

* Menu Animation Option
```Swift
/// - parameters:
///   - option: Animation option for the menu open/close animation style
///      - .Fade - menu will fade in/out
///      - .Expand - menu will expand and contract from bar button center
///      - .None - menu will appear and disappear without animations
func menuAnimationOption(option: AnimationOption)
```

* Menu Animation Duration
```Swift
/// - parameters:
///   - duration: Animation duration for the menu open/close animation
func menuAnimationDuration(duration: NSTimeInterval)
```

## Apps using OptionsMenu

Please let me know if your app in the AppStore uses this library so I can add your app to this list.

## Future Work
- [ ] Ability to remove actions dynamically
- [ ] Ability to set the menu to be on left side of the navigation bar
- [ ] Compatibility with iPad multitasking

## License

Copyright (c) 2014 The Board of Trustees of The University of Alabama
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:

 1. Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.
 2. Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.
 3. Neither the name of the University nor the names of the contributors
    may be used to endorse or promote products derived from this software
    without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
OF THE POSSIBILITY OF SUCH DAMAGE.

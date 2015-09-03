<img src="https://raw.githubusercontent.com/uacaps/ResourceRepo/master/OptionsMenu/OptionsMenuHeader.png" alt="OptionsMenuHeader">

## Description

OptionsMenu is a library written in Swift based on the options menu in material design in Android that allows you to easily add a menu to the navigation bar by adding a bar button item to the right side of the navigation bar, which then lets you open and close the menu. OptionsMenu is a popover style menu, which is set up as easy as a UIAlertController with every added action corresponding to a button in the menu. Actions are easily handled with a completion handler.

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

Menu Actions can be added easily as shown below. You can add as many actions as you would like. If there is not enough space to show all actions the menu will start to scroll

```Swift
let menuAction1: CAPSOptionsMenuAction = CAPSOptionsMenuAction(title: "Action Title 1") { (action: CAPSOptionsMenuAction) -> Void in
   print("Tapped Action Button 1")
}
optionsMenu.addAction(menuAction1)
```



## License ##

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

//
//  OptionsMenu.swift
//  VeriForm
//
//  Created by Niklas Fahl on 8/31/15.
//  Copyright © 2015 CAPS. All rights reserved.
//
//  DISCLAIMER: Works on iPhone 5 or newer as well as all iPads on iOS 7 or newer

import UIKit

public enum AnimationOption {
    case Fade
    case Expand
    case None
}

public class CAPSOptionsMenu: UIView, UIGestureRecognizerDelegate {
    private var parentViewController: UIViewController?
    private var targetNavigationController: UINavigationController?
    
    private var barItem: UIBarButtonItem?
    private var menuScrollView: UIScrollView?
    
    var isShown: Bool = false
    private var didTapActionButton: Bool = false
    
    private var actions: [CAPSOptionsMenuAction] = []
    private var actionButtons: [CAPSOptionsMenuButton] = []
    
    private var barButtonX: CGFloat = 0.0
    private var barButtonXOrientation: UIInterfaceOrientation = UIInterfaceOrientation.Unknown
    private var barButtonView: UIView = UIView()
    
    private var closedFrame: CGRect = CGRectZero
    private var openedFrame: CGRect = CGRectZero
    
    // Customization options defaults
    var menuKeepBarButtonAtEdge: Bool = true
    var maxMenuWidth: CGFloat = 200.0
    var hasShadow: Bool = true
    var menuShadowColor: UIColor = UIColor.grayColor()
    var menuBackgroundColor: UIColor = UIColor.whiteColor()
    var menuBorderWidth: CGFloat = 0.0
    var menuBorderColor: UIColor = UIColor.blackColor()
    var menuActionButtonsTitleColor: UIColor = UIColor.blackColor()
    var menuActionButtonsHiglightedColor: UIColor = UIColor.lightGrayColor()
    var menuCornerRadius: CGFloat = 0.0
    var menuAnimationOption: AnimationOption = AnimationOption.Expand
    var menuAnimationDuration: NSTimeInterval = 0.2
    
    /// Initialize with parent view controller and bar button image name
    ///
    /// -parameters:
    ///   - viewController: View controller holding the navigation controller with the navigation bar the menu is to be put on
    ///   - imageName: Name for menu bar button image
    ///   - keepBarButtonOnRightEdge: If `true`, menu bar button will always stay on the rightmost position
    public init(viewController: UIViewController, imageName: String, keepBarButtonAtEdge: Bool) {
        parentViewController = viewController
        targetNavigationController = viewController.navigationController
        super.init(frame: targetNavigationController!.view.frame)
        
        addBarButtonWithImageName(imageName)
        
        menuKeepBarButtonAtEdge = keepBarButtonAtEdge
        setUpOptionsMenu()
    }
    
    /// Initialize with parent view controller and bar button image
    ///
    /// -parameters:
    ///   - viewController: View controller holding the navigation controller with the navigation bar the menu is to be put on
    ///   - image: Image for menu bar button
    ///   - keepBarButtonOnRightEdge: If `true`, menu bar button will always stay on the rightmost position
    public init(viewController: UIViewController, image: UIImage, keepBarButtonAtEdge: Bool) {
        parentViewController = viewController
        targetNavigationController = viewController.navigationController
        super.init(frame: targetNavigationController!.view.frame)
        
        addBarButtonWithImage(image)
        
        menuKeepBarButtonAtEdge = keepBarButtonAtEdge
        setUpOptionsMenu()
    }
    
    /// Initialize with parent view controller and bar button system item
    ///
    /// -parameters:
    ///   - viewController: View controller holding the navigation controller with the navigation bar the menu is to be put on
    ///   - barButtonSystemItem: Bar button system item for menu bar button
    ///   - keepBarButtonOnRightEdge: If `true`, menu bar button will always stay on the rightmost position
    public init(viewController: UIViewController, barButtonSystemItem: UIBarButtonSystemItem, keepBarButtonAtEdge: Bool) {
        parentViewController = viewController
        targetNavigationController = viewController.navigationController
        super.init(frame: targetNavigationController!.view.frame)
        
        addBarButtonWithSystemItem(barButtonSystemItem)
        
        menuKeepBarButtonAtEdge = keepBarButtonAtEdge
        setUpOptionsMenu()
    }
    
    
    public init(viewController: UIViewController, barButtonItem: UIBarButtonItem, keepBarButtonAtEdge: Bool) {
        parentViewController = viewController
        targetNavigationController = viewController.navigationController
        super.init(frame: targetNavigationController!.view.frame)
        
        barItem = barButtonItem
        barItem?.target = self
        barItem?.action = "barButtonAction:event:"
        // addItemToNavigationBar()
        
        menuKeepBarButtonAtEdge = keepBarButtonAtEdge
        setUpOptionsMenu()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Set up
    private func setUpOptionsMenu() {
        self.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        
        targetNavigationController?.view.insertSubview(self, aboveSubview: targetNavigationController!.navigationBar)
        
        self.hidden = true
        self.backgroundColor = UIColor.clearColor()
        
        setUpMenuView()
    }
    
    private func setUpMenuView() {
        menuScrollView = UIScrollView(frame: closedFrame)
        menuScrollView?.backgroundColor = menuBackgroundColor
        menuScrollView?.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        self.addSubview(menuScrollView!)
        
        let backgroundTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "toggleMenu")
        backgroundTapGesture.delegate = self
        self.addGestureRecognizer(backgroundTapGesture)
        
        if menuCornerRadius > 0.0 {
            menuScrollView!.layer.cornerRadius = menuCornerRadius
            menuScrollView!.clipsToBounds = true
        }
        
        if hasShadow { addShadowAndCornerRadiusToMenuView() }
        if menuBorderWidth > 0.0 { addBorderToMenuView() }
    }
    
    private func addShadowAndCornerRadiusToMenuView() {
        self.layer.shadowColor = menuShadowColor.CGColor
        self.layer.shadowOffset = CGSizeMake(0, 0)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = true
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.mainScreen().scale
    }
    
    private func addBorderToMenuView() {
        menuScrollView?.layer.borderWidth = menuBorderWidth
        menuScrollView?.layer.borderColor = menuBorderColor.CGColor
    }
    
    // MARK: - Customization
    
    /// Menu Customization 
    /// 
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
    ///   - animationDuration: Animation duration for the menu open/close animation
    public func customizeWith(maxMenuWidth maxMenuWidth: CGFloat?, shadow: Bool?, shadowColor: UIColor?, backgroundColor: UIColor?, borderWidth: CGFloat?, borderColor: UIColor?, actionButtonsTitleColor: UIColor?, actionButtonsHighlightedColor: UIColor?, cornerRadius: CGFloat?, animationOption: AnimationOption?, animationDuration: NSTimeInterval?) {
        if let mMenuWidth = maxMenuWidth { self.maxMenuWidth = mMenuWidth }
        if let sh = shadow { hasShadow = sh }
        if let shColor = shadowColor { menuShadowColor = shColor }
        if let bgColor = backgroundColor { menuBackgroundColor = bgColor }
        if let bWidth = borderWidth { menuBorderWidth = bWidth }
        if let bColor = borderColor { menuBorderColor = bColor }
        if let aBTColor = actionButtonsTitleColor { menuActionButtonsTitleColor = aBTColor }
        if let aBHColor = actionButtonsHighlightedColor { menuActionButtonsHiglightedColor = aBHColor }
        if let cRadius = cornerRadius { menuCornerRadius = cRadius }
        if let aOption = animationOption { menuAnimationOption = aOption }
        if let aDuration = animationDuration { menuAnimationDuration = aDuration }
        
        updateForCustomizationOptions()
    }
    
    private func updateForCustomizationOptions() {
        menuScrollView?.backgroundColor = menuBackgroundColor
        
        if menuCornerRadius > 0.0 {
            menuScrollView!.layer.cornerRadius = menuCornerRadius
            menuScrollView!.clipsToBounds = true
        }
        
        if hasShadow {
            addShadowAndCornerRadiusToMenuView()
        } else {
            // Remove shadow
            self.layer.shadowRadius = 0.0
            self.layer.shadowOpacity = 0.0
        }
        
        if menuBorderWidth > 0.0 { addBorderToMenuView() }
    }
    
    // MARK: - Customization Setters
    
    /// Menu Max Width
    /// - parameters:
    ///   - width: Maximum width of the menu
    public func menuMaxWidth(width: CGFloat) {
        maxMenuWidth = width
    }
    
    /// Menu Has Shadow
    /// - parameters:
    ///   - shadow: If `true`, shadow is added to the menu
    public func menuHasShadow(shadow: Bool) {
        hasShadow = shadow
        
        if hasShadow {
            addShadowAndCornerRadiusToMenuView()
        } else {
            // Remove shadow
            self.layer.shadowRadius = 0.0
            self.layer.shadowOpacity = 0.0
        }
    }
    
    /// Menu Shadow Color
    /// - parameters:
    ///   - color: Shadow color for the menu
    public func menuShadowColor(color: UIColor) {
        menuShadowColor = color
        self.layer.shadowColor = menuShadowColor.CGColor
    }
    
    /// Menu Background Color
    /// - parameters:
    ///   - color: Background color for the menu
    public func menuBackgroundColor(color: UIColor) {
        menuBackgroundColor = color
        menuScrollView?.backgroundColor = menuBackgroundColor
    }
    
    /// Menu Border Width
    /// - parameters:
    ///   - width: Border width for the menu
    public func menuBorderWidth(width: CGFloat) {
        menuBorderWidth = width
        if menuBorderWidth > 0.0 { addBorderToMenuView() }
    }
    
    /// Menu Border Color
    /// - parameters:
    ///   - color: Border color for the menu
    public func menuBorderColor(color: UIColor) {
        menuBorderColor = color
        if menuBorderWidth > 0.0 { addBorderToMenuView() }
    }
    
    /// Menu Action Buttons Title Color
    /// - parameters:
    ///   - color: Title color for the menu action buttons
    public func menuActionButtonsTitleColor(color: UIColor) {
        menuActionButtonsTitleColor = color
    }
    
    /// Menu Action Buttons Highlighted Color
    /// - parameters:
    ///   - color: Background color for the menu action buttons when tapped
    public func menuActionButtonsHighlightedColor(color: UIColor) {
        menuActionButtonsHiglightedColor = color
    }
    
    /// Menu Corner Radius
    /// - parameters:
    ///   - radius: Corner radius for the menu
    public func menuCornerRadius(radius: CGFloat) {
        menuCornerRadius = radius
        if menuCornerRadius > 0.0 {
            menuScrollView!.layer.cornerRadius = menuCornerRadius
            menuScrollView!.clipsToBounds = true
        }
    }
    
    /// Menu Animation Option
    /// - parameters:
    ///   - option: Animation option for the menu open/close animation style
    public func menuAnimationOption(option: AnimationOption) {
        menuAnimationOption = option
    }
    
    /// Menu Animation Duration
    /// - parameters:
    ///   - duration: Animation duration for the menu open/close animation
    public func menuAnimationDuration(duration: NSTimeInterval) {
        menuAnimationDuration = duration
    }
    
    // MARK: - Bar Button Item
    private func addBarButtonWithImageName(name: String) {
        barItem = UIBarButtonItem(image: UIImage(named: name), style: UIBarButtonItemStyle.Plain, target: self, action: "barButtonAction:event:")
        addItemToNavigationBar()
    }
    
    private func addBarButtonWithImage(image: UIImage) {
        barItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: "barButtonAction:event:")
        addItemToNavigationBar()
    }
    
    private func addBarButtonWithSystemItem(systemItem: UIBarButtonSystemItem) {
        barItem = UIBarButtonItem(barButtonSystemItem: systemItem, target: self, action: "barButtonAction:event:")
        addItemToNavigationBar()
    }
    
    
    
    
    private func addItemToNavigationBar() {
        if barItem != nil {
            if let navigationItem = parentViewController?.navigationItem {
                if navigationItem.rightBarButtonItems?.count > 1
                {
                    let tempBarButtons = navigationItem.rightBarButtonItems
                    if menuKeepBarButtonAtEdge {
                        navigationItem.rightBarButtonItems? = [barItem!] + tempBarButtons!
                    } else {
                        navigationItem.rightBarButtonItems? = tempBarButtons! + [barItem!]
                    }
                }
                else if navigationItem.rightBarButtonItem != nil
                {
                    let tempBarButton : UIBarButtonItem = navigationItem.rightBarButtonItem!
                    if menuKeepBarButtonAtEdge {
                        navigationItem.rightBarButtonItems = [barItem!, tempBarButton]
                    } else {
                        navigationItem.rightBarButtonItems = [tempBarButton, barItem!]
                    }
                }
                else
                {
                    navigationItem.rightBarButtonItem = barItem!
                }
            }
        }
    }
    
    // MARK: - Helpers
    private func getNavigationBarHeight() -> CGFloat {
        return targetNavigationController!.navigationBar.frame.origin.y + targetNavigationController!.navigationBar.frame.height
    }
    
    private func getScreenBoundsForInterfaceOrientation(orientation: UIInterfaceOrientation) -> CGRect {
        var deviceWidth: CGFloat = 0.0
        var deviceHeight: CGFloat = 0.0
        
        if (UIInterfaceOrientationIsLandscape(orientation))
        { // Landscape
            deviceWidth = max(UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
            deviceHeight = min(UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
        }
        else
        { // Portrait
            deviceWidth = min(UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
            deviceHeight = max(UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
        }
        
        return CGRectMake(0.0, 0.0, deviceWidth, deviceHeight)
    }
    
    private func setOpenClosedFrameForBarButtonFrame(statusBarOrientation: UIInterfaceOrientation) {
        // Get appropriate screen bounds for actual interface orientation
        let screenBounds = getScreenBoundsForInterfaceOrientation(statusBarOrientation)
        
        // calculate y offset for bar button and make appropriate rect for bar button frame
        let navigationBarFrame = targetNavigationController!.navigationBar.frame
        let barButtonY = navigationBarFrame.origin.y + barButtonView.frame.origin.y
        let frame = CGRectMake(barButtonX, barButtonY, barButtonView.frame.width, barButtonView.frame.height)
        
        // Calculate opened frames for menu
        let barButtonRightOffset = screenBounds.width - CGRectGetMaxX(frame)
        let menuWidth = min(maxMenuWidth, screenBounds.width - barButtonRightOffset - barButtonY)
        let barMenuY = (navigationBarFrame.origin.y == 0 ? barButtonY : barButtonY - navigationBarFrame.origin.y)
        let menuHeight = min(CGFloat(44 * actions.count), parentViewController!.view.frame.height + navigationBarFrame.height - barMenuY - barButtonY)
        let barMenuX = barButtonX + barButtonView.frame.width - menuWidth
        openedFrame = CGRectMake(barMenuX, barButtonY, menuWidth, menuHeight)
        
        // Calculate opened frames for menu
        let barButtonCenterX = CGRectGetMidX(frame)
        let barButtonCenterY = CGRectGetMidY(frame)
        closedFrame = CGRectMake(barButtonCenterX, barButtonCenterY - 5.0, 0.0, 0.0)
        
        // Update frames
        menuScrollView?.frame = isShown ? openedFrame : closedFrame
        let actionsHeight: CGFloat = CGFloat(44 * actions.count)
        menuScrollView!.contentSize = CGSizeMake(menuScrollView!.frame.width, actionsHeight)
        
        // Update button width
        for button in actionButtons {
            button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, menuWidth, button.frame.height)
        }
    }
    
    // MARK: - Menu Functions
    public func barButtonAction(sender:UIBarButtonItem, event: UIEvent) {
        if let touches = event.allTouches() {
            if let touch = touches.first {
                if let view = touch.view {
                    // Save info about bar button
                    barButtonView = view
                    barButtonX = view.frame.origin.x
                    barButtonXOrientation = UIApplication.sharedApplication().statusBarOrientation
                    
                    // Update menu frames
                    setOpenClosedFrameForBarButtonFrame(UIApplication.sharedApplication().statusBarOrientation)
                    
                    // Open Menu
                    toggleMenu()
                }
            }
        }
    }
    
    public func toggleMenu() {
        isShown = !isShown
        
        if !isShown {
            animateMenuOpen(false, completion: { () -> Void in
                self.hidden = true
                self.menuScrollView?.hidden = true
            })
        } else {
            self.hidden = false
            self.menuScrollView?.hidden = false
            
            animateMenuOpen(true, completion: { () -> Void in
                self.didTapActionButton = false
            })
        }
    }
    
    private func animateMenuOpen(open: Bool, completion: (() -> Void)?) {
        var frameAnimatingTo: CGRect = CGRectZero
        
        if open {
            frameAnimatingTo = openedFrame
        } else {
            frameAnimatingTo = closedFrame
        }
        
        // Animating with option
        switch menuAnimationOption {
        case .Expand:
            menuScrollView?.alpha = 1.0
            UIView.animateWithDuration(menuAnimationDuration, animations: { () -> Void in
                self.menuScrollView?.frame = frameAnimatingTo
                }, completion: { (completed: Bool) -> Void in
                    if completion != nil { completion!() }
            })
        case .Fade:
            self.menuScrollView?.frame = self.openedFrame
            if isShown {
                menuScrollView?.alpha = 0.0
                menuScrollView?.layer.shadowOpacity = 0.0
            }
            UIView.animateWithDuration(menuAnimationDuration, animations: { () -> Void in
                if self.isShown { // Open
                    self.menuScrollView?.alpha = 1.0
                    if self.hasShadow { self.menuScrollView?.layer.shadowOpacity = 1.0 }
                } else { // Close
                    self.menuScrollView?.alpha = 0.0
                    if self.hasShadow { self.menuScrollView?.layer.shadowOpacity = 0.0 }
                }
                }, completion: { (completed: Bool) -> Void in
                    if completion != nil { completion!() }
            })
        case .None:
            self.menuScrollView?.frame = self.openedFrame
            if isShown {
                menuScrollView?.alpha = 0.0
                menuScrollView?.layer.shadowOpacity = 0.0
            }
            if self.isShown { // Open
                self.menuScrollView?.alpha = 1.0
                if self.hasShadow { self.menuScrollView?.layer.shadowOpacity = 1.0 }
            } else { // Close
                self.menuScrollView?.alpha = 0.0
                if self.hasShadow { self.menuScrollView?.layer.shadowOpacity = 0.0 }
            }
            if completion != nil { completion!() }
        }
    }
    
    // MARK: - Action
    public func addAction(action: CAPSOptionsMenuAction) {
        actions.append(action)
        addButtonForAction(action)
        
        // Update frame for actions
        let actionsHeight: CGFloat = CGFloat(44 * actions.count)
        openedFrame.size.height = actionsHeight
        menuScrollView!.contentSize = CGSizeMake(menuScrollView!.frame.width, actionsHeight)
    }
    
    private func addButtonForAction(action: CAPSOptionsMenuAction) {
        let buttonYOffset: CGFloat = CGFloat(44 * (actions.count - 1))
        let actionButtonFrame = CGRect(x: 0.0, y: buttonYOffset, width: 100.0, height: 44.0)
        let actionButton: CAPSOptionsMenuButton = CAPSOptionsMenuButton(frame: actionButtonFrame, backgroundColor: menuBackgroundColor, highlightedColor: menuActionButtonsHiglightedColor)
        actionButton.titleLabel?.font = UIFont.systemFontOfSize(14.0)
        actionButton.tag = actions.count - 1
        actionButton.setTitle(action.title, forState: UIControlState.Normal)
        actionButton.setImage(action.image, forState: .Normal)
        actionButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left;
        actionButton.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        actionButton.setTitleColor(menuActionButtonsTitleColor, forState: UIControlState.Normal)
        actionButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        menuScrollView!.addSubview(actionButton)
        actionButtons.append(actionButton)
    }
    
    public func buttonAction(sender: UIButton) {
        if !didTapActionButton {
            self.didTapActionButton = true
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.15 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                self.toggleMenu()
                self.actions[sender.tag].actionHandler(self.actions[sender.tag])
            }
        }
    }
    
    // MARK: - Gesture Recognizer Delegate
    public func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if touch.view == menuScrollView {
            return false
        }
        
        return true
    }
    
    // MARK: - Screen Rotation Handling in layout subviews
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        if isShown {
            let orientation = UIApplication.sharedApplication().statusBarOrientation
            
            // Make sure bar button x offset is always correct depending on orientation
            let idiom = UIDevice.currentDevice().userInterfaceIdiom
            if UIInterfaceOrientationIsPortrait(barButtonXOrientation) && UIInterfaceOrientationIsLandscape(orientation) {
                updateBarButtonXForIdiom(idiom, multiply: true)
            } else if UIInterfaceOrientationIsPortrait(orientation) && UIInterfaceOrientationIsLandscape(barButtonXOrientation) {
                updateBarButtonXForIdiom(idiom, multiply: false)
            }
            barButtonXOrientation = orientation
            
            // Update menu frames
            setOpenClosedFrameForBarButtonFrame(orientation)
        }
    }
    
    private func updateBarButtonXForIdiom(idiom: UIUserInterfaceIdiom, multiply: Bool) {
        // Static multipliers needed because barButton viw is not easily accessible
        var multiplier : CGFloat = 1.89 // 16:9
        
        if idiom == UIUserInterfaceIdiom.Pad {
            multiplier = 1.357 // 4:3
        }
        
        barButtonX = multiply ? round(barButtonX * multiplier) : round(barButtonX / multiplier)
    }
}
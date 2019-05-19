//
//  MenuType.swift
//  Menus
//
//  Created by Omar Albeik on 4/13/18.
//  Copyright © 2018 Mobilion. All rights reserved.
//

import UIKit

public typealias MenuViewController = UIViewController & MenuType

public protocol MenuType: class {

    /// The container view controller menu is contained in.
    var container: MenuContainer! { get set }

    /// Whether tapping the current view should close the menu or not.
    var shouldCloseWhenTappingCurrentView: Bool { get set }

    /// Conform to MenuDelegate to get notifications for various menu events.
    var delegate: MenuDelegate? { get set }

    /// Whether the menu is in the left or right side.
    var side: MenuSide { get }

    /// Whether the menu is open or closed.
    var state: MenuState { get }

    /// The width of the menu.
    var menuWidth: CGFloat { get }

	/// The blur animation style for container view when opening the window.
    var containerBlurStyle: UIBlurEffect.Style? { get }

    /// The blur animation end alpha for container view when opening the window.
    var containerBlurAlpha: CGFloat { get }

    /// The duration of opening and closing animations in seconds.
    var animationDuration: TimeInterval { get }

    /// The damping ratio for opening and closing animations, should be between 0 and 1.
    var animationDampingRatio: CGFloat { get }

    /// The scale factor that represents how much should the current view grow or shrink when opening the menu, should be between 0 and 1.
    var currentViewScaleFactor: CGFloat { get }

    /// The end corner radius of current view when opening the menu.
    var currentViewCornerRadius: CGFloat { get }

    /// Whether the menu should be opened or closed interactively or not.
    var isInteractiveSwipeEnabled: Bool { get }

    /// The margin from edge in current view where the menu can be opened when panning in.
    var interactiveSwipeMargin: CGFloat { get }

    /// Open the menu.
    ///
    /// - Parameters:
    ///   - animated: whether menu opening should be animated or not.
    ///   - completion: optional conpletion handler to be called after the menu is open.
    func open(animated: Bool, _ completion: (() -> Void)?)

    /// Close the menu.
    ///
    /// - Parameters:
    ///   - animated: whether menu closing should be animated or not.
    ///   - completion: optional conpletion handler to be called after the menu is closed.
    func close(animated: Bool, _ completion: (() -> Void)?)

    /// Open the menu if closed or close it if it is open.
    ///
    /// - Parameters:
    ///   - animated: whether menu toggling should be animated or not.
    ///   - completion: optional conpletion handler to be called after the menu is toggled.
    func toggle(animated: Bool, _ completion: (() -> Void)?)

}

// MARK: - UIViewController default implementation.
public extension MenuType where Self: UIViewController {

    /// Whether the menu is closed or open.
    var state: MenuState {
        let isOpen = UserDefaults.standard.object(forKey: side.key) as? Bool ?? false
        return .init(isOpen)
    }

    /// The width of the menu. (default is 250)
    var menuWidth: CGFloat {
        return 250
    }

	/// The blur animation style for container view when opening the window. (default is .dark)
    var containerBlurStyle: UIBlurEffect.Style? {
		return .dark
	}

    /// The blur animation end alpha for container view when opening the window. (default is 1)
    var containerBlurAlpha: CGFloat {
        return 1
    }

    /// The duration of opening and closing animations in seconds. (default is 0.5)
    var animationDuration: TimeInterval {
        return 0.5
    }

    /// The damping ratio for opening and closing animations, should be between 0 and 1. (default is 0.75)
    var animationDampingRatio: CGFloat {
        return 0.75
    }

    /// The scale factor that represents how much should the current view grow or shrink when opening the menu, should be between 0 and 1. (default is 1)
    var currentViewScaleFactor: CGFloat {
        return 1
    }

    /// The end corner radius of current view when opening the menu. (default is 0)
    var currentViewCornerRadius: CGFloat {
        return 0
    }

    /// Whether the menu should be opened or closed interactively or not. (default is true)
    var isInteractiveSwipeEnabled: Bool {
        return true
    }

    /// The margin from edge in current view where the menu can be opened when panning in. (default is 75)
    var interactiveSwipeMargin: CGFloat {
        return 75
    }

    /// Open the menu.
    ///
    /// - Parameters:
    ///   - animated: whether menu opening should be animated or not. (default is true)
    ///   - completion: optional conpletion handler to be called after the menu is open. (default is nil)
    func open(animated: Bool = true, _ completion: (() -> Void)? = nil) {
        if #available(iOS 10.0, *) {
            animateTransitionIfNeeded(to: .open, animated: animated, completion)
            container.animator?.startAnimation()
        } else {
            animateWithoutAnimator(to: .open, animated: animated, completion)
        }
    }

    /// Close the menu.
    ///
    /// - Parameters:
    ///   - animated: whether menu closing should be animated or not. (default is true)
    ///   - completion: optional conpletion handler to be called after the menu is closed. (default is nil)
    func close(animated: Bool = true, _ completion: (() -> Void)? = nil) {
        if #available(iOS 10.0, *) {
            animateTransitionIfNeeded(to: .closed, animated: animated, completion)
            container.animator?.startAnimation()
        } else {
            animateWithoutAnimator(to: .closed, animated: animated, completion)
        }
    }

    /// Open the menu if closed or close it if it is open.
    ///
    /// - Parameters:
    ///   - animated: whether menu toggling should be animated or not. (default is true)
    ///   - completion: optional conpletion handler to be called after the menu is toggled. (default is nil)
    func toggle(animated: Bool = true, _ completion: (() -> Void)? = nil) {
        switch state {
        case .open:
            close(animated: animated, completion)
        case .closed:
            open(animated: animated, completion)
        }
    }

}

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

    var delegate: MenuDelegate? { get set }

    var animator: UIViewPropertyAnimator? { get set }

    var container: MenuContainer! { get set }

    var shouldCloseWhenTappingCurrentView: Bool { get set }

    var side: MenuSide { get }

    /// Whether the menu is closed or open.
    var currentState: MenuState { get }

    /// The width of the menu.
    var menuWidth: CGFloat { get }

    /// The blur animation style for container view when opening the window.
    var containerBlurStyle: UIBlurEffectStyle? { get }

    /// The blur animation end alpha for container view when opening the window.
    var containerBlurAlpha: CGFloat { get }

    /// Whether user interactions are allowed in the current view while the window is open.
    var isUserInteractionsEnabledWhileOpen: Bool { get }

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
    public var currentState: MenuState {
        return .init(tag: view.tag)
    }

    /// The width of the menu. (default is 250)
    public var menuWidth: CGFloat {
        return 250
    }

    /// The blur animation style for container view when opening the window. (default is .regular)
    public var containerBlurStyle: UIBlurEffectStyle? {
        return .regular
    }

    /// The blur animation end alpha for container view when opening the window. (default is 0.95)
    public var containerBlurAlpha: CGFloat {
        return 0.95
    }

    /// Whether user interactions are allowed in the current view while the window is open. (default is false)
    public var isUserInteractionsEnabledWhileOpen: Bool {
        return false
    }

    /// The duration of opening and closing animations in seconds. (default is 0.5)
    public var animationDuration: TimeInterval {
        return 0.5
    }

    /// The damping ratio for opening and closing animations, should be between 0 and 1. (default is 0.75)
    public var animationDampingRatio: CGFloat {
        return 0.75
    }

    /// The scale factor that represents how much should the current view grow or shrink when opening the menu, should be between 0 and 1. (default is 1)
    public var currentViewScaleFactor: CGFloat {
        return 1
    }

    /// The end corner radius of current view when opening the menu. (default is 0)
    public var currentViewCornerRadius: CGFloat {
        return 0
    }

    /// Whether the menu should be opened or closed interactively or not. (default is true)
    public var isInteractiveSwipeEnabled: Bool {
        return true
    }

    /// The margin from edge in current view where the menu can be opened when panning in. (default is 75)
    public var interactiveSwipeMargin: CGFloat {
        return 75
    }

    /// Open the menu.
    ///
    /// - Parameters:
    ///   - animated: whether menu opening should be animated or not. (default is true)
    ///   - completion: optional conpletion handler to be called after the menu is open. (default is nil)
    public func open(animated: Bool = true, _ completion: (() -> Void)? = nil) {
        animateTransitionIfNeeded(to: .open, animated: animated, completion)
        animator?.startAnimation()
    }

    /// Close the menu.
    ///
    /// - Parameters:
    ///   - animated: whether menu closing should be animated or not. (default is true)
    ///   - completion: optional conpletion handler to be called after the menu is closed. (default is nil)
    public func close(animated: Bool = true, _ completion: (() -> Void)? = nil) {
        animateTransitionIfNeeded(to: .closed, animated: animated, completion)
        animator?.startAnimation()
    }

    /// Open the menu if closed or close it if it is open.
    ///
    /// - Parameters:
    ///   - animated: whether menu toggling should be animated or not. (default is true)
    ///   - completion: optional conpletion handler to be called after the menu is toggled. (default is nil)
    public func toggle(animated: Bool = true, _ completion: (() -> Void)? = nil) {
        switch currentState {
        case .closed:
            open(animated: animated, completion)
        case .open:
            close(animated: animated, completion)
        }
    }

}

// MARK: - UIViewController, internal animator helpers
internal extension MenuType where Self: UIViewController {

    internal func transform(for state: MenuState, side: MenuSide) -> CGAffineTransform {
        switch state {
        case .closed:
            return .identity
        case .open:
            let translationX = side == .left ? menuWidth : -menuWidth
            let xTransform = CGAffineTransform(translationX: translationX, y: 0)
            let scaleTransform = CGAffineTransform(scaleX: currentViewScaleFactor, y: currentViewScaleFactor)
            return xTransform.concatenating(scaleTransform)
        }
    }

    internal func cornerRadius(for state: MenuState) -> CGFloat {
        switch state {
        case .closed:
            return 0
        case .open:
            return currentViewCornerRadius
        }
    }

    internal func animator(for state: MenuState, animated: Bool = true, _ completion: (() -> Void)? = nil) -> UIViewPropertyAnimator {
        container.blurView = UIVisualEffectView()
        container.blurView?.alpha = containerBlurAlpha
        switch state {
        case .open:
            self.container.blurView?.effect = nil
        case .closed:
            if let style = self.containerBlurStyle {
                self.container.blurView?.effect = UIBlurEffect(style: style)
            }
        }

        let stateAnimator = UIViewPropertyAnimator(duration: animated ? animationDuration : 0, dampingRatio: animationDampingRatio, animations: nil)
        stateAnimator.addAnimations(animatorAnimations(for: state, animated: animated, completion))
        stateAnimator.addCompletion(animatorcCompletion(for: state, animated: animated, completion))
        return stateAnimator
    }

    internal func animatorAnimations(for state: MenuState, animated: Bool = true, _ completion: (() -> Void)? = nil) -> (() -> Void) {
        return { [unowned self] in
            let transform = self.transform(for: state, side: self.side)
            let cornerRadius = self.cornerRadius(for: state)

            self.container.currentViewTransfrorm = transform
            self.container.currentViewController?.view.transform = transform

            self.container.currentViewCornerRadius = cornerRadius
            self.container.currentViewController?.view.layer.cornerRadius = cornerRadius

            switch state {
            case .open:
                if let style = self.containerBlurStyle {
                    self.container.blurView?.effect = UIBlurEffect(style: style)
                }
            case .closed:
                self.container.blurView?.effect = nil
            }
        }
    }

    internal func animatorcCompletion(for state: MenuState, animated: Bool = true, _ completion: (() -> Void)? = nil) -> ((UIViewAnimatingPosition) -> Void) {
        return { [unowned self] position in
            switch position {
            case .start:
                self.didCloseMenu(animated: animated)
            case .end:
                self.view.tag = state == .closed ? 404 : 0
                if state == .closed {
                    self.didCloseMenu(animated: animated)
                } else {
                    self.didOpenMenu(animated: animated)
                }
            case .current:
                break
            }

            self.view.isUserInteractionEnabled = true
            self.animator = nil
            completion?()
        }
    }

    internal func animateTransitionIfNeeded(to state: MenuState, animated: Bool = true, _ completion: (() -> Void)? = nil) {
        if animator != nil { return } // animator was already defined

        self.view.isUserInteractionEnabled = false

        switch state {
        case .open:
            container.leftMenu?.view.isHidden = side == .right
            container.rightMenu?.view.isHidden = side == .left

            delegate?.menu(self, willOpen: animated)
        case .closed:
            delegate?.menu(self, willClose: animated)
        }

        animator = animator(for: state, animated: animated, completion)
    }

}

// MARK: - UIViewController, private helpers
private extension MenuType where Self: UIViewController {

    private func didCloseMenu(animated: Bool) {
        self.delegate?.menu(self, didClose: animated)
        self.container.blurView = nil
        self.container.currentViewController?.view.subviews.forEach { $0.isUserInteractionEnabled = true }
    }

    private func didOpenMenu(animated: Bool) {
        self.delegate?.menu(self, didOpen: animated)
        if !isUserInteractionsEnabledWhileOpen {
            self.container.currentViewController?.view.subviews.forEach { $0.isUserInteractionEnabled = false }
        }
    }

}

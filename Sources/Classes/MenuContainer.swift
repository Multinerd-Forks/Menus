//
//  MenuContainer.swift
//  Menus
//
//  Created by Omar Albeik on 4/13/18.
//  Copyright © 2018 Mobilion. All rights reserved.
//

import UIKit

open class MenuContainer: UIViewController {

    private var leftEdgePanGestureRecognizer: UIScreenEdgePanGestureRecognizer?
    private var rightEdgePanGestureRecognizer: UIScreenEdgePanGestureRecognizer?
    private var closeMenusTapGestureRecognizer: UITapGestureRecognizer?
    private var closeMenusPanGestureRecognizer: UIPanGestureRecognizer?

    private var leftMenuClosePanGestureRecognizer: UIPanGestureRecognizer?
    private var rightMenuClosePanGestureRecognizer: UIPanGestureRecognizer?

    internal var currentViewTransfrorm: CGAffineTransform = .identity
    internal var currentViewCornerRadius: CGFloat = 0

    open var isUserInteractionEnabledWhileMenuOpen = false

    public var hasOpenMenu: Bool {
        if leftMenu?.currentState == .open {
            return true
        }
        if rightMenu?.currentState == .open {
            return true
        }
        return false
    }

    public var currentViewController: UIViewController? {
        didSet {
            oldValue?.remove()
            setEdgePanGestureRecognizer(for: .left)
            setEdgePanGestureRecognizer(for: .right)

            guard let controller = currentViewController else { return }
            setCurrentViewController(controller)

            setCloseMenusTapGestureRecognizer()
        }
    }

    public var leftMenu: MenuViewController? {
        didSet {
            oldValue?.remove()
            setEdgePanGestureRecognizer(for: .left)
            setMenuPanGestureRecognizer(for: .left)
            guard let menu = leftMenu else { return }
            menu.container = self
            setMenu(menu, side: .left)
        }
    }

    public var rightMenu: MenuViewController? {
        didSet {
            oldValue?.remove()
            setEdgePanGestureRecognizer(for: .right)
            setMenuPanGestureRecognizer(for: .right)
            guard let menu = rightMenu else { return }
            menu.container = self
            setMenu(menu, side: .right)
        }
    }

}

// MARK: - Helpers
private extension MenuContainer {

    func setCurrentViewController(_ controller: UIViewController) {
        controller.view.clipsToBounds = true
        controller.view.transform = currentViewTransfrorm
        controller.view.layer.cornerRadius = currentViewCornerRadius

        addChildViewController(controller)
        view.addSubview(controller.view)
        controller.didMove(toParentViewController: self)

        setCloseMenusPanGestureRecognizer()
    }

    func setMenu(_ menu: MenuViewController, side: MenuSide) {
        menu.view.tag = 404
        menu.view.isHidden = true

        switch side {
        case .left:
            menu.view.autoresizingMask = [.flexibleRightMargin, .flexibleHeight]
            menu.view.frame = .init(x: 0, y: 0, width: menu.menuWidth, height: view.frame.height)
        case .right:
            menu.view.autoresizingMask = [.flexibleLeftMargin, .flexibleHeight]
            menu.view.frame = .init(x: view.frame.width - menu.menuWidth, y: 0, width: menu.menuWidth, height: view.frame.height)
        }

        if let currentView = currentViewController?.view {
            view.insertSubview(menu.view, belowSubview: currentView)
        } else {
            view.addSubview(menu.view)
        }

        menu.didMove(toParentViewController: self)
    }

    func setEdgePanGestureRecognizer(for side: MenuSide) {
        let currentView = currentViewController?.view

        switch side {
        case .left:
            if let menu = leftMenu, menu.isInteractiveSwipeEnabled {
                leftEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(didPanFromLeftEdge(_:)))
                leftEdgePanGestureRecognizer?.edges = .left
                currentView?.addGestureRecognizer(leftEdgePanGestureRecognizer!)
            } else {
                leftEdgePanGestureRecognizer?.remove(from: currentView)
            }
        case .right:
            if let menu = rightMenu, menu.isInteractiveSwipeEnabled {
                rightEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(didPanFromRightEdge(_:)))
                rightEdgePanGestureRecognizer?.edges = .right
                currentView?.addGestureRecognizer(rightEdgePanGestureRecognizer!)
            } else {
                rightEdgePanGestureRecognizer?.remove(from: currentView)
            }
        }
    }

    func setMenuPanGestureRecognizer(for side: MenuSide) {
        switch side {
        case .left:
            if let menu = leftMenu, menu.isInteractiveSwipeEnabled {
                leftMenuClosePanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPanToCloseLeftMenu(_:)))
                menu.view.addGestureRecognizer(leftMenuClosePanGestureRecognizer!)
            } else {
                leftMenuClosePanGestureRecognizer?.remove(from: leftMenu?.view)
            }
        case .right:
            if let menu = rightMenu, menu.isInteractiveSwipeEnabled {
                rightMenuClosePanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPanToCloseRightMenu(_:)))
                menu.view.addGestureRecognizer(rightMenuClosePanGestureRecognizer!)
            } else {
                rightMenuClosePanGestureRecognizer?.remove(from: rightMenu?.view)
            }
        }
    }

    func setCloseMenusTapGestureRecognizer() {
        closeMenusTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapCurrentView))
        currentViewController?.view.addGestureRecognizer(closeMenusTapGestureRecognizer!)
    }

    func setCloseMenusPanGestureRecognizer() {
        closeMenusPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPanCurrentView(_:)))
        currentViewController?.view.addGestureRecognizer(closeMenusPanGestureRecognizer!)
    }

    func menu(for side: MenuSide) -> MenuViewController? {
        switch side {
        case .left:
            return leftMenu
        case .right:
            return rightMenu
        }
    }

    func fractionComplete(for recognizer: UIPanGestureRecognizer, in menu: MenuViewController) -> CGFloat {
        let xTranslation = recognizer.translation(in: menu.view).x

        switch menu.side {
        case .left:
            return xTranslation / menu.menuWidth
        case .right:
            return -xTranslation / menu.menuWidth
        }
    }

    func shouldCancelAnimation(for recognizer: UIPanGestureRecognizer, in menu: MenuViewController) -> Bool {
        let xLocation = recognizer.location(in: menu.view).x
        let ratio: CGFloat = xLocation / menu.menuWidth
        let xVelocity = recognizer.velocity(in: menu.view).x

        let allowedRatio: CGFloat = 0.5

        switch menu.side {
        case .left:
            guard xVelocity > 0 else { return true }
            return ratio < allowedRatio
        case .right:
            guard xVelocity < 0 else { return true }
            return ratio > allowedRatio && xVelocity > 0
        }
    }

    func handlePanGestureRecognizer(_ recognizer: UIPanGestureRecognizer, side: MenuSide) {
        guard let menu = menu(for: side) else { return }

        switch recognizer.state {
        case .began:
            menu.animateTransitionIfNeeded(to: .open)
            menu.animator.pauseAnimation()

        case .changed:
            menu.animator.fractionComplete = fractionComplete(for: recognizer, in: menu)

        case .ended, .cancelled:
            if shouldCancelAnimation(for: recognizer, in: menu) {
                menu.animator.isReversed = true
            }
            menu.animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)

        default:
            break
        }
    }

}

// MARK: - Selectors
private extension MenuContainer {

    @objc func didPanFromLeftEdge(_ sender: UIScreenEdgePanGestureRecognizer) {
        guard !hasOpenMenu else { return }
        handlePanGestureRecognizer(sender, side: .left)
    }

    @objc func didPanFromRightEdge(_ sender: UIScreenEdgePanGestureRecognizer) {
        guard !hasOpenMenu else { return }
        handlePanGestureRecognizer(sender, side: .right)
    }

    @objc func didTapCurrentView() {
        if let menu = leftMenu, menu.currentState == .open && menu.shouldCloseWhenTappingCurrentView {
            menu.close {
                print(menu.animator)
            }
        }
        if let menu = rightMenu, menu.currentState == .open && menu.shouldCloseWhenTappingCurrentView {
            menu.close {
                print(menu.animator)
            }
        }
    }

    @objc func didPanCurrentView(_ sender: UIPanGestureRecognizer) {
        //        let xTranslation = sender.translation(in: currentViewController?.view).x
        //        print(xTranslation)

        //        if xTranslation < 0 {
        //            if let menu = leftMenu, menu.shouldCloseWhenTappingCurrentView {
        //                handlePanGestureRecognizer(sender, side: .left)
        //            }
        //        } else {
        //            if let menu = rightMenu, menu.shouldCloseWhenTappingCurrentView {
        ////                menu.close()
        //            }
        //        }
    }

    @objc func didPanToCloseLeftMenu(_ sender: UIPanGestureRecognizer) {
        let xTranslation = sender.translation(in: leftMenu?.view).x
        print(xTranslation)
        handlePanGestureRecognizer(sender, side: .left)
        //
        //        if xTranslation < 0 {
        //            if let menu = leftMenu, menu.state == .open, menu.shouldCloseWhenTappingCurrentView {
        //                menu.close()
        //            }
        //        }
    }

    @objc func didPanToCloseRightMenu(_ sender: UIPanGestureRecognizer) {
        //        let xTranslation = sender.translation(in: rightMenu?.view).x
        //        print(xTranslation)
        //
        //        if xTranslation > 0 {
        //            if let menu = rightMenu, menu.state == .open, menu.shouldCloseWhenTappingCurrentView {
        //                menu.close()
        //            }
        //        }
    }

}

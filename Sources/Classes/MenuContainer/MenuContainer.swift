//
//  MenuContainer.swift
//  Menus
//
//  Created by Omar Albeik on 4/13/18.
//  Copyright © 2018 Mobilion. All rights reserved.
//

import UIKit

open class MenuContainer: UIViewController {

    internal var currentViewPanGestureRecognizer: PanGestureRecognizer?
    internal var currentViewTapGestureRecognizer: UITapGestureRecognizer?

    internal var leftEdgePanGestureRecognizer: ScreenEdgePanGestureRecognizer?
    internal var leftMenuPanGestureRecognizer: PanGestureRecognizer?

    internal var rightEdgePanGestureRecognizer: ScreenEdgePanGestureRecognizer?
    internal var rightMenuPanGestureRecognizer: PanGestureRecognizer?

    internal var currentViewTransfrorm: CGAffineTransform = .identity
    internal var currentViewCornerRadius: CGFloat = 0

    internal var blurView: UIVisualEffectView? {
        willSet {
            blurView?.removeFromSuperview()
        }
        didSet {
            if let bView = blurView {
                bView.frame = view.frame
                view.insertSubview(bView, at: 1)
            }
        }
    }

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
            guard let controller = currentViewController else { return }
            addCurrentViewController(controller)
        }
    }

    public var leftMenu: MenuViewController? {
        willSet {
            if let currentMenu = leftMenu, currentMenu.currentState == .open {
                fatalError("Menus: menus can not be changed while they are open.")
            }
        }
        didSet {
            oldValue?.remove()
            if let menu = leftMenu {
                addMenu(menu)
            }
            setPanGestureRecognizers(for: .left)
        }
    }

    public var rightMenu: MenuViewController? {
        willSet {
            if let currentMenu = rightMenu, currentMenu.currentState == .open {
                fatalError("Menus: menus can not be changed while they are open.")
            }
        }
        didSet {
            oldValue?.remove()
            if let menu = rightMenu {
                addMenu(menu)
            }
            setPanGestureRecognizers(for: .right)
        }
    }

    open override var shouldAutorotate: Bool {
        return !hasOpenMenu
    }

}

// MARK: - Private Extensions
private extension UIViewController {

    func remove() {
        willMove(toParentViewController: nil)
        removeFromParentViewController()
        view.removeFromSuperview()
    }

}

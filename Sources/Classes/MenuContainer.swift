//
//  MenuContainer.swift
//  Menus
//
//  Created by Omar Albeik on 4/13/18.
//  Copyright © 2018 Mobilion. All rights reserved.
//

import UIKit

open class MenuContainer: UIViewController {

    internal var leftEdgePanGestureRecognizer: ScreenEdgePanGestureRecognizer?
    internal var rightEdgePanGestureRecognizer: ScreenEdgePanGestureRecognizer?
	internal var currentViewPanGestureRecognizer: PanGestureRecognizer?

    internal var closeMenusTapGestureRecognizer: UITapGestureRecognizer?

	internal var leftMenuClosePanGestureRecognizer: PanGestureRecognizer?
    internal var rightMenuClosePanGestureRecognizer: PanGestureRecognizer?

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
            guard let controller = currentViewController else { return }
            setCurrentViewController(controller)
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

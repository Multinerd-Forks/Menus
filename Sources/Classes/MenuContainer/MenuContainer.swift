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

    internal var leftMenuPanGestureRecognizer: PanGestureRecognizer?
    internal var rightMenuPanGestureRecognizer: PanGestureRecognizer?

    internal var currentViewTransfrorm: CGAffineTransform = .identity
    internal var currentViewCornerRadius: CGFloat = 0

	internal lazy var blurView: UIVisualEffectView = {
		let view = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	@available(iOS 10.0, *)
	internal lazy var animator: UIViewPropertyAnimator? = { return nil }()

    public var hasOpenMenu: Bool {
        if leftMenu?.state == .open { return true }
        if rightMenu?.state == .open { return true }
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
            if let currentMenu = leftMenu, currentMenu.state == .open {
                fatalError("Menus: menus can not be changed while they are open.")
            }
        }
        didSet {
            oldValue?.remove()
			oldValue?.setState(nil)

            if let menu = leftMenu {
				menu.setState(.closed)
                addMenu(menu)
            }
            setPanGestureRecognizers(for: .left)
        }
    }

    public var rightMenu: MenuViewController? {
        willSet {
            if let currentMenu = rightMenu, currentMenu.state == .open {
                fatalError("Menus: menus can not be changed while they are open.")
            }
        }
        didSet {
            oldValue?.remove()
			oldValue?.setState(nil)

            if let menu = rightMenu {
				menu.setState(.closed)
                addMenu(menu)
            }
            setPanGestureRecognizers(for: .right)
        }
    }

	open override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
		leftMenu?.close()
		rightMenu?.close()
	}

	open override func viewDidLoad() {
		super.viewDidLoad()

		view.addSubview(blurView)
		blurView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
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

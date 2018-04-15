//
//  MenuContainer+Setup.swift
//  Menus
//
//  Created by Omar Albeik on 4/13/18.
//

// MARK: - Setup
internal extension MenuContainer {

	func setCurrentViewController(_ controller: UIViewController) {
		controller.view.clipsToBounds = true
		controller.view.transform = currentViewTransfrorm
		controller.view.layer.cornerRadius = currentViewCornerRadius

		addChildViewController(controller)
		view.addSubview(controller.view)
		controller.didMove(toParentViewController: self)

		setCloseMenusPanGestureRecognizer()
		setCloseMenusTapGestureRecognizer()

		setEdgePanGestureRecognizer(for: .left)
		setMenuPanGestureRecognizer(for: .left)

		setEdgePanGestureRecognizer(for: .right)
		setMenuPanGestureRecognizer(for: .right)
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

	func setCurrentViewPanGestureRecognizer() {
		currentViewPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPanCurrentView(_:)))
		currentViewController?.view.addGestureRecognizer(currentViewPanGestureRecognizer!)
	}

}

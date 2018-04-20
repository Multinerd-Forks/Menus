//
//  MenuContainer+Setup.swift
//  Menus
//
//  Created by Omar Albeik on 4/13/18.
//

// MARK: - Setup
internal extension MenuContainer {

	func addCurrentViewController(_ controller: UIViewController) {
        controller.view.clipsToBounds = true
		controller.view.transform = currentViewTransfrorm
		controller.view.layer.cornerRadius = currentViewCornerRadius

		addChildViewController(controller)
		view.addSubview(controller.view)
		controller.didMove(toParentViewController: self)

		setCurrentViewPanGestureRecognizer()
		setCurrentViewTapGestureRecognizer()

        setPanGestureRecognizers(for: .left)
        setPanGestureRecognizers(for: .right)
	}

	func addMenu(_ menu: MenuViewController) {
        menu.container = self
		menu.view.isHidden = true

		switch menu.side {
		case .left:
			menu.view.autoresizingMask = [.flexibleRightMargin, .flexibleHeight]
			menu.view.frame = .init(x: 0, y: 0, width: menu.menuWidth, height: view.frame.height)
		case .right:
			menu.view.autoresizingMask = [.flexibleLeftMargin, .flexibleHeight]
			menu.view.frame = .init(x: view.frame.width - menu.menuWidth, y: 0, width: menu.menuWidth, height: view.frame.height)
		}

		if let currentView = currentViewController?.view {
			view.insertSubview(menu.view, belowSubview: currentView)
			blurView.bringSubview(toFront: menu.view)
		} else {
			view.addSubview(menu.view)
		}

		menu.didMove(toParentViewController: self)
	}

    func setPanGestureRecognizers(for side: MenuSide) {
        switch side {
        case .left:
            if let menu = leftMenu, menu.isInteractiveSwipeEnabled {
                leftMenuPanGestureRecognizer = PanGestureRecognizer(target: self, action: #selector(didPanToCloseLeftMenu(_:)))
                menu.view.addGestureRecognizer(leftMenuPanGestureRecognizer!)

            } else {
                leftMenuPanGestureRecognizer?.remove(from: leftMenu?.view)
            }
        case .right:
            if let menu = rightMenu, menu.isInteractiveSwipeEnabled {
                rightMenuPanGestureRecognizer = PanGestureRecognizer(target: self, action: #selector(didPanToCloseRightMenu(_:)))
                menu.view.addGestureRecognizer(rightMenuPanGestureRecognizer!)

            } else {
                rightMenuPanGestureRecognizer?.remove(from: rightMenu?.view)
            }
        }

    }

	func setCurrentViewTapGestureRecognizer() {
		currentViewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapCurrentView))
		currentViewController?.view.addGestureRecognizer(currentViewTapGestureRecognizer!)
	}

	func setCurrentViewPanGestureRecognizer() {
		currentViewPanGestureRecognizer = PanGestureRecognizer(target: self, action: #selector(didPanCurrentView(_:)))
		currentViewController?.view.addGestureRecognizer(currentViewPanGestureRecognizer!)
	}

}

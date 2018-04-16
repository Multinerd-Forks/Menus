//
//  MenuContainer+Selectors.swift
//  Menus
//
//  Created by Omar Albeik on 4/13/18.
//

// MARK: - Selectors
internal extension MenuContainer {

	@objc func didPanFromLeftEdge(_ sender: ScreenEdgePanGestureRecognizer) {
		guard !hasOpenMenu else { return }
		guard let menu = leftMenu, menu.isInteractiveSwipeEnabled else { return }
		sender.handleEdgePan(for: menu)
	}

	@objc func didPanFromRightEdge(_ sender: ScreenEdgePanGestureRecognizer) {
		guard !hasOpenMenu else { return }
		guard let menu = rightMenu, menu.isInteractiveSwipeEnabled else { return }
		sender.handleEdgePan(for: menu)
	}

	@objc func didTapCurrentView() {
		if let menu = leftMenu, menu.currentState == .open && menu.shouldCloseWhenTappingCurrentView {
			menu.close()
		}
		if let menu = rightMenu, menu.currentState == .open && menu.shouldCloseWhenTappingCurrentView {
			menu.close()
		}
	}

	@objc func didPanCurrentView(_ sender: PanGestureRecognizer) {
		switch sender.state {
		case .began:
			print(sender.shouldOpenMenu(leftMenu, in: currentViewController?.view))
			if sender.shouldOpenMenu(leftMenu, in: currentViewController?.view) {
				leftMenu?.animateTransitionIfNeeded(to: .open)
				leftMenu?.animator?.pauseAnimation()
			}

			if sender.shouldOpenMenu(rightMenu, in: currentViewController?.view) {
				rightMenu?.animateTransitionIfNeeded(to: .open)
				rightMenu?.animator?.pauseAnimation()
			}

		case .changed:
			leftMenu?.animator?.fractionComplete = sender.fractionComplete(in: leftMenu!)

		case .ended, .cancelled:
			leftMenu?.animator?.continueAnimation(withTimingParameters: nil, durationFactor: 0)

		default:
			break
		}
	}

	@objc func didPanToCloseLeftMenu(_ sender: PanGestureRecognizer) {

	}

	@objc func didPanToCloseRightMenu(_ sender: PanGestureRecognizer) {

	}

}

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
        sender.menu = menu
		sender.handleEdgePan()
	}

	@objc func didPanFromRightEdge(_ sender: ScreenEdgePanGestureRecognizer) {
		guard !hasOpenMenu else { return }
		guard let menu = rightMenu, menu.isInteractiveSwipeEnabled else { return }
        sender.menu = menu
		sender.handleEdgePan()
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

            if hasOpenMenu {
                if sender.shouldCloseMenu(leftMenu, in: currentViewController?.view) {
                    leftMenu?.close()
                }
                if sender.shouldCloseMenu(rightMenu, in: currentViewController?.view) {
                    rightMenu?.close()
                }

            } else {
                if sender.shouldOpenMenu(leftMenu, in: currentViewController?.view) {
                    sender.menu = leftMenu
                }

                if sender.shouldOpenMenu(rightMenu, in: currentViewController?.view) {
                    sender.menu = rightMenu
                }

                sender.menu?.animateTransitionIfNeeded(to: .open)
                sender.menu?.animator?.pauseAnimation()
            }

		case .changed:
			sender.menu?.animator?.fractionComplete = sender.fractionComplete

		case .ended, .cancelled:
            if sender.shouldCancelAnimation {
                sender.menu.animator?.isReversed = true
            }
			sender.menu?.animator?.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            sender.menu = nil

		default:
			break
		}
	}

	@objc func didPanToCloseLeftMenu(_ sender: PanGestureRecognizer) {

	}

	@objc func didPanToCloseRightMenu(_ sender: PanGestureRecognizer) {

	}

}

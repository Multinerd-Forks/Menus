//
//  MenuContainer+Selectors.swift
//  Menus
//
//  Created by Omar Albeik on 4/13/18.
//

// MARK: - Selectors
internal extension MenuContainer {

	@objc func didTapCurrentView() {
		if let menu = leftMenu, menu.state == .open && menu.shouldCloseWhenTappingCurrentView {
			menu.close()
		}
		if let menu = rightMenu, menu.state == .open && menu.shouldCloseWhenTappingCurrentView {
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
                animator?.pauseAnimation()
            }

        case .changed:
            animator?.fractionComplete = sender.fractionComplete

        case .ended, .cancelled:
            if sender.shouldCancelAnimation {
                animator?.isReversed = true
            }
            animator?.continueAnimation(withTimingParameters: nil, durationFactor: 0)
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

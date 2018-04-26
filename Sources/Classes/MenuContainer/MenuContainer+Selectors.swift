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

	// swiftlint:disable:next cyclomatic_complexity
	@objc func didPanCurrentView(_ sender: PanGestureRecognizer) {
		switch sender.state {
		case .began:

            if sender.shouldOpenMenu(leftMenu, in: currentViewController?.view) {
                sender.menu = leftMenu
            }

            if sender.shouldOpenMenu(rightMenu, in: currentViewController?.view) {
                sender.menu = rightMenu
            }

            if leftMenu?.state == .open {
                sender.menu = leftMenu
            }

            if rightMenu?.state == .open {
                sender.menu = rightMenu
            }

            if #available(iOS 10.0, *) {
                sender.menu?.animateTransitionIfNeeded(to: hasOpenMenu ? .closed : .open)
                animator?.pauseAnimation()
            } else {
                hasOpenMenu ? sender.menu?.close() : sender.menu?.open()
            }

		case .changed:

            if #available(iOS 10.0, *) {
                animator?.fractionComplete = sender.fractionComplete
			}

		case .ended, .cancelled:

            if #available(iOS 10.0, *) {
				if sender.shouldCancelAnimation {
					animator?.isReversed = true
				}
				animator?.continueAnimation(withTimingParameters: nil, durationFactor: 0)
			}
			sender.menu = nil

		default:
			break
		}
	}

	@objc func didPanToCloseLeftMenu(_ sender: PanGestureRecognizer) {
        print("didPanToCloseLeftMenu")
//        print(sender.location(in: leftMenu?.view))
	}

	@objc func didPanToCloseRightMenu(_ sender: PanGestureRecognizer) {
        print("didPanToCloseRightMenu")
//        print(sender.location(in: rightMenu?.view))
	}

}

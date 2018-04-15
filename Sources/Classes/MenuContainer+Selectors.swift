//
//  MenuContainer+Selectors.swift
//  Menus
//
//  Created by Omar Albeik on 4/13/18.
//

// MARK: - Selectors
internal extension MenuContainer {

	@objc func didPanFromLeftEdge(_ sender: UIScreenEdgePanGestureRecognizer) {
		guard !hasOpenMenu else { return }
		guard let menu = leftMenu else { return }

		switch sender.state {
		case .began:
			menu.animateTransitionIfNeeded(to: .open)
			menu.animator?.pauseAnimation()

		case .changed:
			menu.animator?.fractionComplete = fractionComplete(for: sender, in: menu)

		case .ended, .cancelled:
			if shouldCancelAnimation(for: sender, in: menu) {
				menu.animator?.isReversed = true
			}
			menu.animator?.continueAnimation(withTimingParameters: nil, durationFactor: 0)

		default:
			break
		}
	}

	@objc func didPanFromRightEdge(_ sender: UIScreenEdgePanGestureRecognizer) {
		guard !hasOpenMenu else { return }
		guard let menu = rightMenu else { return }

		switch sender.state {
		case .began:
			menu.animateTransitionIfNeeded(to: .open)
			menu.animator?.pauseAnimation()

		case .changed:
			menu.animator?.fractionComplete = fractionComplete(for: sender, in: menu)

		case .ended, .cancelled:
			if shouldCancelAnimation(for: sender, in: menu) {
				menu.animator?.isReversed = true
			}
			menu.animator?.continueAnimation(withTimingParameters: nil, durationFactor: 0)

		default:
			break
		}
	}

	@objc func didTapCurrentView() {
		if let menu = leftMenu, menu.currentState == .open && menu.shouldCloseWhenTappingCurrentView {
			menu.close()
		}
		if let menu = rightMenu, menu.currentState == .open && menu.shouldCloseWhenTappingCurrentView {
			menu.close()
		}
	}

	@objc func didPanCurrentView(_ sender: UIPanGestureRecognizer) {
		switch sender.state {
		case .began:
			if sender.shouldOpenMenu(leftMenu, in: currentViewController?.view) {
				leftMenu?.animateTransitionIfNeeded(to: .open)
				leftMenu?.animator?.pauseAnimation()
			}

			if sender.shouldOpenMenu(rightMenu, in: currentViewController?.view) {
				rightMenu?.animateTransitionIfNeeded(to: .open)
				rightMenu?.animator?.pauseAnimation()
			}

		case .changed:
			leftMenu?.animator?.fractionComplete = fractionComplete(for: sender, in: leftMenu!)

		case .ended, .cancelled:
			leftMenu?.animator?.continueAnimation(withTimingParameters: nil, durationFactor: 0)

		default:
			break
		}
	}

	@objc func didPanToCloseLeftMenu(_ sender: UIPanGestureRecognizer) {

	}

	@objc func didPanToCloseRightMenu(_ sender: UIPanGestureRecognizer) {

	}

}

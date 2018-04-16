//
//  ScreenEdgePanGestureRecognizer.swift
//  Menus
//
//  Created by Omar Albeik on 4/16/18.
//

import UIKit

internal class ScreenEdgePanGestureRecognizer: UIScreenEdgePanGestureRecognizer, MenuPanning {

	func handleEdgePan(for menu: MenuViewController) {
		switch state {
		case .began:
			menu.animateTransitionIfNeeded(to: .open)
			menu.animator?.pauseAnimation()

		case .changed:
			menu.animator?.fractionComplete = fractionComplete(in: menu)

		case .ended, .cancelled:
			if shouldCancelAnimation(in: menu) {
				menu.animator?.isReversed = true
			}
			menu.animator?.continueAnimation(withTimingParameters: nil, durationFactor: 0)

		default:
			break
		}
	}

}

//
//  Extensions.swift
//  Menus
//
//  Created by Omar Albeik on 4/13/18.
//  Copyright © 2018 Mobilion. All rights reserved.
//

import UIKit

internal extension UIGestureRecognizer {

	func remove(from view: UIView?) {
		view?.removeGestureRecognizer(self)
	}

}

internal extension UIViewController {

	func remove() {
		willMove(toParentViewController: nil)
		removeFromParentViewController()
		view.removeFromSuperview()
	}

}

internal extension UIPanGestureRecognizer {

	func shouldOpenMenu(_ menu: MenuType?, in view: UIView?) -> Bool {
		guard let aView = view else { return false }
		guard let aMenu = menu else { return false }

		let xLocation = location(in: aView).x
		let xVelocity = velocity(in: aView).x

		if xLocation < aMenu.interactiveSwipeMargin && xVelocity > 0 {
			return aMenu.side == .left
		}
		if xLocation > aView.frame.width - aMenu.interactiveSwipeMargin && xVelocity < 0 {
			return aMenu.side == .right
		}
		return false
	}

}

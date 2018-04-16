//
//  PanGestureRecognizer.swift
//  Menus
//
//  Created by Omar Albeik on 4/15/18.
//

import UIKit

internal class PanGestureRecognizer: UIPanGestureRecognizer, MenuPanning {

	var menuToOpen: MenuType?

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

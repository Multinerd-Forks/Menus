//
//  MenuPanning.swift
//  Menus
//
//  Created by Omar Albeik on 4/16/18.
//

import UIKit

internal protocol MenuPanning: class {

	func fractionComplete(in menu: MenuViewController) -> CGFloat
	func shouldCancelAnimation(in menu: MenuViewController) -> Bool
	func remove(from view: UIView?)

}

internal extension MenuPanning where Self: UIPanGestureRecognizer {

	internal func fractionComplete(in menu: MenuViewController) -> CGFloat {
		let xTranslation = translation(in: menu.view).x

		switch menu.side {
		case .left:
			return xTranslation / menu.menuWidth
		case .right:
			return -xTranslation / menu.menuWidth
		}
	}

	internal func shouldCancelAnimation(in menu: MenuViewController) -> Bool {
		let xLocation = location(in: menu.view).x
		let ratio: CGFloat = xLocation / menu.menuWidth
		let xVelocity = velocity(in: menu.view).x

		let allowedRatio: CGFloat = 0.5

		switch menu.side {
		case .left:
			guard xVelocity > 0 else { return true }
			return ratio < allowedRatio
		case .right:
			guard xVelocity < 0 else { return true }
			return ratio > allowedRatio && xVelocity > 0
		}
	}

	func remove(from view: UIView?) {
		view?.removeGestureRecognizer(self)
	}
	
}

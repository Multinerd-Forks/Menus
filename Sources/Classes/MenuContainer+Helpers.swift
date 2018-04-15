//
//  MenuContainer+Helpers.swift
//  Menus
//
//  Created by Omar Albeik on 4/13/18.
//

// MARK: - Helpers
internal extension MenuContainer {

	func menu(for side: MenuSide) -> MenuViewController? {
		switch side {
		case .left:
			return leftMenu
		case .right:
			return rightMenu
		}
	}

}

// MARK: - Helpers
internal extension MenuContainer {

	func fractionComplete(for recognizer: UIPanGestureRecognizer, in menu: MenuViewController) -> CGFloat {
		let xTranslation = recognizer.translation(in: menu.view).x

		switch menu.side {
		case .left:
			return xTranslation / menu.menuWidth
		case .right:
			return -xTranslation / menu.menuWidth
		}
	}

	func shouldCancelAnimation(for recognizer: UIPanGestureRecognizer, in menu: MenuViewController) -> Bool {
		let xLocation = recognizer.location(in: menu.view).x
		let ratio: CGFloat = xLocation / menu.menuWidth
		let xVelocity = recognizer.velocity(in: menu.view).x

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

}

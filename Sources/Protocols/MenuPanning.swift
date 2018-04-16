//
//  MenuPanning.swift
//  Menus
//
//  Created by Omar Albeik on 4/16/18.
//

import UIKit

internal protocol MenuPanning: class {

    var menu: MenuViewController! { get set }
    var fractionComplete: CGFloat { get }
    var shouldCancelAnimation: Bool { get }

	func remove(from view: UIView?)

}

internal extension MenuPanning where Self: UIPanGestureRecognizer {

    internal var fractionComplete: CGFloat {
        let xTranslation = translation(in: menu.view).x

        switch menu.side {
        case .left:
            return xTranslation / menu.menuWidth
        case .right:
            return -xTranslation / menu.menuWidth
        }
    }

    internal var shouldCancelAnimation: Bool {
        guard let aMenu = menu else { return false }
        let xLocation = location(in: aMenu.view).x
        let ratio: CGFloat = xLocation / aMenu.menuWidth
        let xVelocity = velocity(in: aMenu.view).x

        let allowedRatio: CGFloat = 0.5

        switch aMenu.side {
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

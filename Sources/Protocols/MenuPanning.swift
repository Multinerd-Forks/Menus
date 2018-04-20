//
//  MenuPanning.swift
//  Menus
//
//  Created by Omar Albeik on 4/16/18.
//

import UIKit

internal protocol MenuPanning: class {

    var menu: MenuViewController? { get set }

    var fractionComplete: CGFloat { get }
    var shouldCancelAnimation: Bool { get }

    func shouldOpenMenu(_ menu: MenuType?, in view: UIView?) -> Bool
    func shouldCloseMenu(_ menu: MenuType?, in view: UIView?) -> Bool
    func remove(from view: UIView?)

}

// MARK: - UIPanGestureRecognizer
internal extension MenuPanning where Self: UIPanGestureRecognizer {

    internal var fractionComplete: CGFloat {
        guard let aMenu = menu else { return 0 }
        let xTranslation = translation(in: aMenu.view).x

        switch aMenu.side {
        case .left:
            return xTranslation / aMenu.menuWidth
        case .right:
            return -xTranslation / aMenu.menuWidth
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

    internal func shouldOpenMenu(_ menu: MenuType?, in view: UIView?) -> Bool {
        guard let aView = view else { return false }
        guard let aMenu = menu else { return false }
        guard aMenu.state == .closed else { return false }

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

    internal func shouldCloseMenu(_ menu: MenuType?, in view: UIView?) -> Bool {
        guard let aView = view else { return false }
        guard let aMenu = menu else { return false }
        guard aMenu.state == .open else { return false }

        let xVelocity = velocity(in: aView).x

        if xVelocity < 0 {
            return aMenu.side == .left
        }
        if xVelocity > 0 {
            return aMenu.side == .right
        }

        return false
    }

    func remove(from view: UIView?) {
        view?.removeGestureRecognizer(self)
    }

}

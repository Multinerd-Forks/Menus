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
    //    func shouldCloseMenu(_ menu: MenuType?, in view: UIView?) -> Bool
    func remove(from view: UIView?)

}

// MARK: - UIPanGestureRecognizer
internal extension MenuPanning where Self: UIPanGestureRecognizer {

    internal var fractionComplete: CGFloat {
        guard let menu = self.menu else { return 0 }

        let xTr = translation(in: menu.view).x
        let xFr = (menu.side == .left ? xTr : -xTr) / menu.menuWidth

        return menu.state == .closed ? xFr : -xFr
    }

    internal var shouldCancelAnimation: Bool {
        guard let menu = self.menu else { return false }

        let xLoc = location(in: menu.view).x
        let xVel = velocity(in: menu.view).x

        let ratio: CGFloat = (xLoc / menu.menuWidth)
        let allowedRatio: CGFloat = 0.5

        var shouldCancel: Bool {
            switch menu.side {
            case .left:
                guard xVel > 0 else { return true }
                return ratio < allowedRatio
            case .right:
                guard xVel < 0 else { return true }
                return ratio > allowedRatio
            }
        }

        return menu.state == .closed ? shouldCancel : !shouldCancel
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

    //    internal func shouldCloseMenu(_ menu: MenuType?, in view: UIView?) -> Bool {
    //        guard let aView = view else { return false }
    //        guard let aMenu = menu else { return false }
    //        guard aMenu.state == .open else { return false }
    //
    //        let xVelocity = velocity(in: aView).x
    //
    //        if xVelocity < 0 {
    //            return aMenu.side == .left
    //        }
    //        if xVelocity > 0 {
    //            return aMenu.side == .right
    //        }
    //
    //        return false
    //    }
    //
    func remove(from view: UIView?) {
        view?.removeGestureRecognizer(self)
    }

}

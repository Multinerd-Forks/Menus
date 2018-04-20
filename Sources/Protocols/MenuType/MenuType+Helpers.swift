//
//  MenuType+Helpers.swift
//  Menus
//
//  Created by Omar Albeik on 4/19/18.
//  Copyright © 2018 Mobilion. All rights reserved.
//

internal extension MenuType where Self: UIViewController {

    /// Concatenated transform for the opened state.
    internal var transformForOpened: CGAffineTransform {
        var translationX: CGFloat {
            switch side {
            case .left:
                return menuWidth
            case .right:
                return -menuWidth
            }
        }
        let xTransform = CGAffineTransform(translationX: translationX, y: 0)
        let scaleTransform = CGAffineTransform(scaleX: currentViewScaleFactor, y: currentViewScaleFactor)
        return xTransform.concatenating(scaleTransform)
    }

    internal func setState(_ state: MenuState?) {
        guard let aState = state else {
            UserDefaults.standard.set(nil, forKey: side.key)
            UserDefaults.standard.synchronize()
            return
        }
        switch aState {
        case .open:
            UserDefaults.standard.set(true, forKey: side.key)
        case .closed:
            UserDefaults.standard.set(false, forKey: side.key)
        }
        UserDefaults.standard.synchronize()
    }

}

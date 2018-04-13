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

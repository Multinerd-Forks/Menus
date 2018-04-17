//
//  ClientsMenu.swift
//  MenusExample
//
//  Created by Omar Albeik on 4/13/18.
//  Copyright © 2018 Mobilion. All rights reserved.
//

import UIKit
import Menus

class ClientsMenu: UITableViewController, MenuType {

    weak var delegate: MenuDelegate?

    var animator: UIViewPropertyAnimator?

    var container: MenuContainer!

    var shouldCloseWhenTappingCurrentView: Bool = true

    var side: MenuSide {
        return .right
    }

    var currentViewScaleFactor: CGFloat {
        return 1
    }

    var currentViewCornerRadius: CGFloat {
        return 0
    }

    var menuWidth: CGFloat {
        return 200
    }

    var containerBlurStyle: UIBlurEffectStyle? {
        return nil
    }

    var isInteractiveSwipeEnabled: Bool {
        return false
    }

    @IBAction func didTap(_ sender: Any) {
        close()
    }

}

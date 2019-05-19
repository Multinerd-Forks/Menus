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

    var container: MenuContainer!

    var shouldCloseWhenTappingCurrentView: Bool = true

    weak var delegate: MenuDelegate?

    var side: MenuSide {
        return .right
    }

    var menuWidth: CGFloat {
        return 200
    }

    var containerBlurStyle: UIBlurEffect.Style? {
        return nil
    }

    var isInteractiveSwipeEnabled: Bool {
        return false
    }

    @IBAction func didTap(_ sender: Any) {
        close()
    }

}

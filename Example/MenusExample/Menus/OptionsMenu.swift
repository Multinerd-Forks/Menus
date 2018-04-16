//
//  OptionsMenu.swift
//  MenusExample
//
//  Created by Omar Albeik on 4/13/18.
//  Copyright © 2018 Mobilion. All rights reserved.
//

import UIKit
import Menus

class OptionsMenu: UIViewController, MenuType {

    var delegate: MenuDelegate?

    var animator: UIViewPropertyAnimator?

    var container: MenuContainer!

    var shouldCloseWhenTappingCurrentView: Bool = true

    var side: MenuSide {
        return .right
    }

    var currentViewScaleFactor: CGFloat {
        return 1
    }

    var menuWidth: CGFloat {
        return 200
    }

    var currentViewBlurStyle: UIBlurEffectStyle? {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
    }

}

//
//  MainMenu.swift
//  MenusExample
//
//  Created by Omar Albeik on 4/13/18.
//  Copyright © 2018 Mobilion. All rights reserved.
//

import UIKit
import Menus

class MainMenu: UITableViewController, MenuType {

    weak var delegate: MenuDelegate?

    var animator: UIViewPropertyAnimator?

    var container: MenuContainer!

    var shouldCloseWhenTappingCurrentView: Bool = true

    var side: MenuSide {
        return .left
    }

    var currentViewBlurAlpha: CGFloat {
        return 0.92
    }

    var currentViewCornerRadius: CGFloat {
        return 20
    }

    var isInteractiveSwipeEnabled: Bool {
        return false
    }

    var currentViewBlurStyle: UIBlurEffectStyle? {
        return .regular
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            container.currentViewController = storyboard?.instantiateViewController(withIdentifier: "NavigationController")
            close()

        case 1:
            container.currentViewController = storyboard?.instantiateViewController(withIdentifier: "AboutViewController")
            close()

        case 2:
            container.leftMenu?.close {
                self.container.rightMenu?.open()
            }

        case 3:
            let url = URL(string: "https://github.com/MobilionOSS/Menus")!
            close {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            
        default:
            break
        }
    }

}

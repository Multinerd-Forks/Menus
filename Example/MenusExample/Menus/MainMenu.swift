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

    var container: MenuContainer!

    var shouldCloseWhenTappingCurrentView: Bool = true

    weak var delegate: MenuDelegate?

    var side: MenuSide {
        return .left
    }

    var currentViewCornerRadius: CGFloat {
        return 20
    }

    var currentViewScaleFactor: CGFloat {
        return 0.75
    }

    var isInteractiveSwipeEnabled: Bool {
        return false
    }

    var containerBlurStyle: UIBlurEffectStyle? {
        return .dark
    }

	var containerBlurAlpha: CGFloat {
		return 0.9
	}

    var interactiveSwipeMargin: CGFloat {
        return 150
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            container.currentViewController = storyboard?.instantiateViewController(withIdentifier: "HomeNavigationController")
            close()

        case 1:
            container.currentViewController = storyboard?.instantiateViewController(withIdentifier: "AboutViewController")
            close()

        case 2:
            container.currentViewController = storyboard?.instantiateViewController(withIdentifier: "HomeNavigationController")
            container.leftMenu?.close {
                self.container.rightMenu?.open()
            }

        case 3:
            container.currentViewController = storyboard?.instantiateViewController(withIdentifier: "OpensourceNavigationController")
            close()

        case 4:
            let alert = UIAlertController(title: "View on Github", message: "Do you want to leave the app and open Safari", preferredStyle: .alert)

            let openAction = UIAlertAction(title: "Open", style: .default) { _ in
                let url = URL(string: "https://github.com/MobilionOSS/Menus")!
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                self.open()
            }

            alert.addAction(openAction)
            alert.addAction(cancelAction)

            close()
            present(alert, animated: true, completion: nil)

        default:
            break
        }
    }

}

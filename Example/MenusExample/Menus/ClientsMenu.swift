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

    var containerBlurStyle: UIBlurEffectStyle? {
        return nil
    }

    var interactiveSwipeMargin: CGFloat {
        return UIScreen.main.bounds.width
    }

    @IBAction func didTap(_ sender: Any) {
        close()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ClientsMenu, viewDidLoad")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ClientsMenu, viewWillAppear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ClientsMenu, viewDidAppear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ClientsMenu, viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ClientsMenu, viewDidDisappear")
    }

}

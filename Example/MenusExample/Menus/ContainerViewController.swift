//
//  ContainerViewController.swift
//  MenusExample
//
//  Created by Omar Albeik on 4/13/18.
//  Copyright © 2018 Mobilion. All rights reserved.
//

import UIKit
import Menus

class ContainerViewController: MenuContainer {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ContainerViewController, viewDidLoad")

        view.backgroundColor = .black

        currentViewController = storyboard?.instantiateViewController(withIdentifier: "HomeNavigationController")
        leftMenu = storyboard?.instantiateViewController(withIdentifier: "MainMenu") as? MainMenu
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ContainerViewController, viewWillAppear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ContainerViewController, viewDidAppear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ContainerViewController, viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ContainerViewController, viewDidDisappear")
    }

}

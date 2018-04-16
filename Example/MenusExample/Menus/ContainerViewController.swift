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

        view.backgroundColor = .black

        currentViewController = storyboard!.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
        
        leftMenu = storyboard!.instantiateViewController(withIdentifier: "MainMenu") as! MainMenu
        rightMenu = storyboard!.instantiateViewController(withIdentifier: "ClientsMenu") as! ClientsMenu

    }

}

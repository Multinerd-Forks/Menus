//
//  AboutViewController.swift
//  MenusExample
//
//  Created by Omar Albeik on 4/13/18.
//  Copyright © 2018 Mobilion. All rights reserved.
//

import UIKit
import Menus

class AboutViewController: UIViewController, MenuContainable {

    @IBAction func didTapReturnHomeButton(_ sender: UIButton) {
        let homeNavController = storyboard?.instantiateViewController(withIdentifier: "HomeNavigationController")
        container?.currentViewController = homeNavController
    }

}

//
//  ViewController.swift
//  MenusExample
//
//  Created by Omar Albeik on 4/13/18.
//  Copyright © 2018 Mobilion. All rights reserved.
//

import UIKit
import Menus

class ViewController: UIViewController, MenuContainable {

    @IBAction func didTapLeftBarButtonItem(_ sender: UIBarButtonItem) {
        container?.leftMenu?.toggle()
    }

    @IBAction func didTapRightBarButtonItem(_ sender: UIBarButtonItem) {
        container?.rightMenu?.toggle()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        container?.leftMenu?.delegate = self
        container?.rightMenu?.delegate = self
    }

}

extension ViewController: MenuDelegate {}

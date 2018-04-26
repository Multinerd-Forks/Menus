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

    override func viewDidLoad() {
        super.viewDidLoad()
        print("AboutViewController, viewDidLoad")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("AboutViewController, viewWillAppear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("AboutViewController, viewDidAppear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("AboutViewController, viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("AboutViewController, viewDidDisappear")
    }

}

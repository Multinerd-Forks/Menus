//
//  HomeViewController.swift
//  MenusExample
//
//  Created by Omar Albeik on 4/13/18.
//  Copyright © 2018 Mobilion. All rights reserved.
//

import UIKit
import Menus

class HomeViewController: UIViewController, MenuContainable {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("HomeViewController, viewDidLoad")

        navigationController?.navigationBar.setBackgroundColor(.white)
        container?.rightMenu = storyboard?.instantiateViewController(withIdentifier: "ClientsMenu") as? ClientsMenu

        container?.leftMenu?.delegate = self
        container?.rightMenu?.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("HomeViewController, viewWillAppear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("HomeViewController, viewDidAppear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("HomeViewController, viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("HomeViewController, viewDidDisappear")
    }

    @IBAction func didTapLeftBarButtonItem(_ sender: UIBarButtonItem) {
        container?.leftMenu?.toggle()
    }

    @IBAction func didTapRightBarButtonItem(_ sender: UIBarButtonItem) {
        container?.rightMenu?.toggle()
    }

}

extension HomeViewController: MenuDelegate {

    func menu(_ menu: MenuViewController, willOpen animated: Bool) {
        print("\(menu.side) menu will open")
    }

    func menu(_ menu: MenuViewController, didOpen animated: Bool) {
        print("\(menu.side) menu did open")
    }

    func menu(_ menu: MenuViewController, willClose animated: Bool) {
        print("\(menu.side) menu will close")
    }

    func menu(_ menu: MenuViewController, didClose animated: Bool) {
        print("\(menu.side) menu did close")
    }

}

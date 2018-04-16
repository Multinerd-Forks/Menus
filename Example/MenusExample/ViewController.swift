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

        navigationController?.navigationBar.makeTransparent()

        container?.leftMenu?.delegate = self
        container?.rightMenu?.delegate = self
    }

}

extension ViewController: MenuDelegate {

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

private extension UINavigationBar {

    func makeTransparent() {
        isTranslucent = true
        backgroundColor = .clear
        barTintColor = .clear
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
    }

}

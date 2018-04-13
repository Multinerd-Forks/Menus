//
//  MenuDelegate.swift
//  Menus
//
//  Created by Omar Albeik on 4/13/18.
//  Copyright © 2018 Mobilion. All rights reserved.
//

import UIKit

public protocol MenuDelegate: class {
    func menu(_ menu: MenuViewController, willOpen animated: Bool)
    func menu(_ menu: MenuViewController, didOpen animated: Bool)
    func menu(_ menu: MenuViewController, willClose animated: Bool)
    func menu(_ menu: MenuViewController, didClose animated: Bool)
}

extension MenuDelegate {
    func menu(_ menu: MenuViewController, willOpen animated: Bool) {}
    func menu(_ menu: MenuViewController, didOpen animated: Bool) {}
    func menu(_ menu: MenuViewController, willClose animated: Bool) {}
    func menu(_ menu: MenuViewController, didClose animated: Bool) {}
}

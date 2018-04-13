//
//  MenuContainable.swift
//  Menus
//
//  Created by Omar Albeik on 4/13/18.
//  Copyright © 2018 Mobilion. All rights reserved.
//

import UIKit

public protocol MenuContainable: class {
    var container: MenuContainer? { get }
}

public extension MenuContainable where Self: UIViewController {

    public var container: MenuContainer? {
        if let nav = self.navigationController {
            if let tab = nav.tabBarController {
                return tab.parent as? MenuContainer
            }
            return nav.parent as? MenuContainer
        }
        if let tab = tabBarController {
            return tab.parent as? MenuContainer
        }
        return parent as? MenuContainer
    }

}

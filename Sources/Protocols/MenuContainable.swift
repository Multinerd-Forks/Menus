//
//  MenuContainable.swift
//  Menus
//
//  Created by Omar Albeik on 4/13/18.
//  Copyright © 2018 Mobilion. All rights reserved.
//

import UIKit

/// Conform to MenuContainable for view controllers that are used for currentViewController
public protocol MenuContainable: class {

    /// Menus container view controller.
    var container: MenuContainer? { get }

}

// MARK: - UIViewController
public extension MenuContainable where Self: UIViewController {

    /// Menus container view controller.
    public var container: MenuContainer? {
        if let nav = navigationController {
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

//
//  MenuDelegate.swift
//  Menus
//
//  Created by Omar Albeik on 4/13/18.
//  Copyright © 2018 Mobilion. All rights reserved.
//

import UIKit

/// Conform to MenuDelegate to get notifications for various menu events.
public protocol MenuDelegate: class {

    /// Called before menu is about to be opened.
    ///
    /// - Parameters:
    ///   - menu: menu view controller.
    ///   - animated: whether menu will be opened with animation or not.
    func menu(_ menu: MenuViewController, willOpen animated: Bool)

    /// Called after menu is opened.
    ///
    /// - Parameters:
    ///   - menu: menu view controller.
    ///   - animated: whether menu was opened with animation or not.
    func menu(_ menu: MenuViewController, didOpen animated: Bool)

    /// Called before menu is about to be closed.
    ///
    /// - Parameters:
    ///   - menu: menu view controller.
    ///   - animated: whether menu will be closed with animation or not.
    func menu(_ menu: MenuViewController, willClose animated: Bool)

    /// Called after menu is closed.
    ///
    /// - Parameters:
    ///   - menu: menu view controller.
    ///   - animated: whether menu was closed with animation or not.
    func menu(_ menu: MenuViewController, didClose animated: Bool)

}

// MARK: - MenuDelegate, optional methods.
public extension MenuDelegate {

    /// Called before menu is about to be opened.
    ///
    /// - Parameters:
    ///   - menu: menu view controller.
    ///   - animated: whether menu will be opened with animation or not.
    func menu(_ menu: MenuViewController, willOpen animated: Bool) {}

    /// Called after menu is opened.
    ///
    /// - Parameters:
    ///   - menu: menu view controller.
    ///   - animated: whether menu was opened with animation or not.
    func menu(_ menu: MenuViewController, didOpen animated: Bool) {}

    /// Called before menu is about to be closed.
    ///
    /// - Parameters:
    ///   - menu: menu view controller.
    ///   - animated: whether menu will be closed with animation or not.
    func menu(_ menu: MenuViewController, willClose animated: Bool) {}

    /// Called after menu is closed.
    ///
    /// - Parameters:
    ///   - menu: menu view controller.
    ///   - animated: whether menu was closed with animation or not.
    func menu(_ menu: MenuViewController, didClose animated: Bool) {}

}

//
//  MenuState.swift
//  Menus
//
//  Created by Omar Albeik on 4/19/18.
//  Copyright © 2018 Mobilion. All rights reserved.
//

import Foundation

public enum MenuState {
    case open
    case closed
}

public extension MenuState {

    public var opposite: MenuState {
        switch self {
        case .closed:
            return .open
        case .open:
            return .closed
        }
    }

}

// MARK: - CustomStringConvertible
extension MenuState: CustomStringConvertible {

    public var description: String {
        switch self {
        case .closed:
            return "closed"
        case .open:
            return "open"
        }
    }

}

// MARK: - Internal initializers
internal extension MenuState {

    internal init(_ isOpen: Bool) {
        self = isOpen ? .open : .closed
    }

}

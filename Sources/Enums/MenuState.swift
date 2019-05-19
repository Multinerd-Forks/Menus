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

    var opposite: MenuState {
        switch self {
        case .closed:
            return .open
        case .open:
            return .closed
        }
    }

}

internal extension MenuState {

    init(_ isOpen: Bool) {
        self = isOpen ? .open : .closed
    }

}

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

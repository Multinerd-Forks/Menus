//
//  MenuState.swift
//  Menus
//
//  Created by Omar Albeik on 4/13/18.
//  Copyright © 2018 Mobilion. All rights reserved.
//

import Foundation

public enum MenuState {
    case closed
    case open

    internal init(tag: Int) {
        self = tag == 404 ? .closed : .open
    }
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

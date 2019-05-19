//
//  MenuSide.swift
//  Menus
//
//  Created by Omar Albeik on 4/13/18.
//  Copyright © 2018 Mobilion. All rights reserved.
//

import Foundation

public enum MenuSide {
	case left
	case right
}

internal extension MenuSide {

    var key: String {
		switch self {
		case .left:
			return "Menus: Left Menu"
		case .right:
			return "Menus: Right Menu"
		}
	}

}

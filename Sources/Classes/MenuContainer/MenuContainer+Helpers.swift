//
//  MenuContainer+Helpers.swift
//  Menus
//
//  Created by Omar Albeik on 4/13/18.
//

// MARK: - Helpers
internal extension MenuContainer {

	internal func menu(for side: MenuSide) -> MenuViewController? {
		switch side {
		case .left:
			return leftMenu
		case .right:
			return rightMenu
		}
	}

}

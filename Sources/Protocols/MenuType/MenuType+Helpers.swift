//
//  MenuType+Helpers.swift
//  Menus
//
//  Created by Omar Albeik on 4/19/18.
//  Copyright © 2018 Mobilion. All rights reserved.
//

internal extension MenuType where Self: UIViewController {

	/// Perpare menu's container blur view for animation.
    func prepareBlurView(for finalState: MenuState) {
		guard let style = containerBlurStyle else {
			container.blurView.isHidden = true
			return
		}

		container.blurView.isHidden = false
		container.blurView.alpha = containerBlurAlpha

		switch finalState {
		case .closed:
			container.blurView.effect = UIBlurEffect(style: style)

		case .open:
			container.blurView.effect = nil
		}
	}

	/// Animate menu's container blur view style.
    func animateBlurView(for finalState: MenuState) {
		switch finalState {
		case .closed:
			self.container.blurView.effect = nil
		case .open:
			if let style = self.containerBlurStyle {
				self.container.blurView.effect = UIBlurEffect(style: style)
			}
		}
	}

    /// Concatenated transform for the opened state.
    var transformForOpened: CGAffineTransform {
        var translationX: CGFloat {
            switch side {
            case .left:
                return menuWidth
            case .right:
                return -menuWidth
            }
        }
        let xTransform = CGAffineTransform(translationX: translationX, y: 0)
        let scaleTransform = CGAffineTransform(scaleX: currentViewScaleFactor, y: currentViewScaleFactor)
        return xTransform.concatenating(scaleTransform)
    }

    func setState(_ state: MenuState?) {
        guard let aState = state else {
            UserDefaults.standard.set(nil, forKey: side.key)
            UserDefaults.standard.synchronize()
            return
        }
        switch aState {
        case .open:
            UserDefaults.standard.set(true, forKey: side.key)
        case .closed:
            UserDefaults.standard.set(false, forKey: side.key)
        }
        UserDefaults.standard.synchronize()
    }

}

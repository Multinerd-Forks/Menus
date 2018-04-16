//
//  ScreenEdgePanGestureRecognizer.swift
//  Menus
//
//  Created by Omar Albeik on 4/16/18.
//

import UIKit

internal class ScreenEdgePanGestureRecognizer: UIScreenEdgePanGestureRecognizer, MenuPanning {

    internal var menu: MenuViewController!

    internal func handleEdgePan() {
        guard let aMenu = menu else { return }

        switch state {
        case .began:
            aMenu.animateTransitionIfNeeded(to: .open)
            aMenu.animator?.pauseAnimation()

        case .changed:
            aMenu.animator?.fractionComplete = fractionComplete

        case .ended, .cancelled:
            if shouldCancelAnimation {
                aMenu.animator?.isReversed = true
            }
            aMenu.animator?.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            menu = nil

        default:
            break
        }
    }

}

//
//  MenuType+Legacy.swift
//  Menus
//
//  Created by Omar Albeik on 4/19/18.
//  Copyright © 2018 Mobilion. All rights reserved.
//

internal extension MenuType where Self: UIViewController {

    /// Open or close menu for iOS 9 where UIViewPropertyAnimator is not available
    internal func animateWithoutAnimator(to finalState: MenuState, animated: Bool = true, _ completion: (() -> Void)? = nil) {

		prepareBlurView(for: finalState)

        switch finalState {
        case .open:
            delegate?.menu(self, willOpen: animated)
        case .closed:
            delegate?.menu(self, willClose: animated)
        }

        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: animationDampingRatio, initialSpringVelocity: 0, options: .curveEaseInOut, animations: { [unowned self] in

			self.animateBlurView(for: finalState)

            switch finalState {
            case .open:
                self.container.currentViewController?.view.transform = self.transformForOpened
                self.container.currentViewController?.view.layer.cornerRadius = self.currentViewCornerRadius

            case .closed:
                self.container.currentViewController?.view.transform = .identity
                self.container.currentViewController?.view.layer.cornerRadius = 0
            }

            }, completion: { _ in

                switch finalState {
                case .open:
                    self.container.currentViewController?.view.subviews.forEach { $0.isUserInteractionEnabled = false }
                    self.delegate?.menu(self, didOpen: animated)
                case .closed:
                    self.container.currentViewController?.view.subviews.forEach { $0.isUserInteractionEnabled = true }
                    self.delegate?.menu(self, didClose: animated)
                }

                completion?()
        })
    }

}

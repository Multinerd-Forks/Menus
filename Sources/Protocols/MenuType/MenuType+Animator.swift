//
//  MenuType+Animator.swift
//  Menus
//
//  Created by Omar Albeik on 4/19/18.
//  Copyright © 2018 Mobilion. All rights reserved.
//

internal extension MenuType where Self: UIViewController {

	internal func prepareBlurView(for finalState: MenuState) {
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

	internal func animateBlurView(for finalState: MenuState) {
		switch finalState {
		case .closed:
			self.container.blurView.effect = nil
		case .open:
			if let style = self.containerBlurStyle {
				self.container.blurView.effect = UIBlurEffect(style: style)
			}
		}
	}

    @available(iOS 10.0, *)
    internal func animateTransitionIfNeeded(to finalState: MenuState, animated: Bool = true, _ completion: (() -> Void)? = nil) {
        if container.animator != nil { return } // animator is already defined

		prepareBlurView(for: finalState)

        switch finalState {
        case .closed:
            delegate?.menu(self, willClose: animated)
        case .open:
			container.leftMenu?.view.isHidden = side == .right
			container.rightMenu?.view.isHidden = side == .left
            delegate?.menu(self, willOpen: animated)
        }

        view.isUserInteractionEnabled = false

        let duration: TimeInterval = animated ? animationDuration : 0
        let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: animationDampingRatio)

        animator.addAnimations { [unowned self] in
            var transform: CGAffineTransform {
                switch finalState {
                case .closed:
                    return .identity
                case .open:
                    return self.transformForOpened
                }
            }
            self.container.currentViewTransfrorm = transform
            self.container.currentViewController?.view.transform = transform
        }

        animator.addAnimations { [unowned self] in
            var radius: CGFloat {
                switch finalState {
                case .closed:
                    return 0
                case .open:
                    return self.currentViewCornerRadius
                }
            }
            self.container.currentViewCornerRadius = radius
            self.container.currentViewController?.view.layer.cornerRadius = radius
        }

		animator.addAnimations { [unowned self] in
			self.animateBlurView(for: finalState)
		}

        animator.addCompletion { [unowned self] position in
            switch position {
            case .start:
                // print("start", "\(self.state)", "reversed: \(animator.isReversed)")
                break
            case .end:
                self.setState(finalState)
                // print("end", "\(self.state)", "reversed: \(animator.isReversed)")
            case .current:
                // print("current", "\(self.state)", "reversed: \(animator.isReversed)")
                break
            }

            switch self.state {
            case .open:
                self.container.currentViewController?.view.subviews.forEach { $0.isUserInteractionEnabled = false }
                self.delegate?.menu(self, didOpen: animated)
            case .closed:
                self.container.currentViewController?.view.subviews.forEach { $0.isUserInteractionEnabled = true }
                self.delegate?.menu(self, didClose: animated)
            }

            self.view.isUserInteractionEnabled = true
            self.container.animator = nil
            completion?()
        }

        container.animator = animator
    }

}

//
//  MenuType.swift
//  Menus
//
//  Created by Omar Albeik on 4/13/18.
//  Copyright © 2018 Mobilion. All rights reserved.
//

import UIKit

public typealias MenuViewController = UIViewController & MenuType

public protocol MenuType: class {

	var delegate: MenuDelegate? { get set }

	var animator: UIViewPropertyAnimator? { get set }

	var container: MenuContainer! { get set }

	var shouldCloseWhenTappingCurrentView: Bool { get set }

	var side: MenuSide { get }

	var currentState: MenuState { get }

	var menuWidth: CGFloat { get }

	var animationDuration: TimeInterval { get }

	var animationDampingRatio: CGFloat { get }

	var currentViewScaleFactor: CGFloat { get }

	var currentViewCornerRadius: CGFloat { get }

	var isInteractiveSwipeEnabled: Bool { get }

	var interactiveSwipeMargin: CGFloat { get }

	func open(animated: Bool, _ completion: (() -> Void)?)

	func close(animated: Bool, _ completion: (() -> Void)?)

	func toggle(animated: Bool, _ completion: (() -> Void)?)

}

public extension MenuType where Self: UIViewController {

	public var currentState: MenuState {
		return .init(tag: view.tag)
	}

	public var menuWidth: CGFloat {
		return 250
	}

	public var animationDuration: TimeInterval {
		return 0.4
	}

	public var animationDampingRatio: CGFloat {
		return 0.8
	}

	public var currentViewScaleFactor: CGFloat {
		return 0.8
	}

	public var currentViewCornerRadius: CGFloat {
		return 0
	}

	public var isInteractiveSwipeEnabled: Bool {
		return true
	}

	public var interactiveSwipeMargin: CGFloat {
		return 75
	}

	public func close(animated: Bool = true, _ completion: (() -> Void)? = nil) {
		animateTransitionIfNeeded(to: .closed, animated: animated, completion)
		animator?.startAnimation()
	}

	public func toggle(animated: Bool = true, _ completion: (() -> Void)? = nil) {
		switch currentState {
		case .closed:
			open(animated: animated, completion)
		case .open:
			close(animated: animated, completion)
		}
	}

	public func open(animated: Bool = true, _ completion: (() -> Void)? = nil) {
		animateTransitionIfNeeded(to: .open, animated: animated, completion)
		animator?.startAnimation()
	}

}

internal extension MenuType where Self: UIViewController {

	internal func transform(for state: MenuState, side: MenuSide) -> CGAffineTransform {
		switch state {
		case .closed:
			return .identity
		case .open:
			let translationX = side == .left ? menuWidth : -menuWidth
			let xTransform = CGAffineTransform(translationX: translationX, y: 0)
			let scaleTransform = CGAffineTransform(scaleX: currentViewScaleFactor, y: currentViewScaleFactor)
			return xTransform.concatenating(scaleTransform)
		}
	}

	internal func cornerRadius(for state: MenuState) -> CGFloat {
		switch state {
		case .closed:
			return 0
		case .open:
			return currentViewCornerRadius
		}
	}

	internal func animator(for state: MenuState, animated: Bool = true, _ completion: (() -> Void)? = nil) -> UIViewPropertyAnimator {
		let stateAnimator = UIViewPropertyAnimator(duration: animated ? animationDuration : 0, dampingRatio: animationDampingRatio) {
			let transform = self.transform(for: state, side: self.side)
			let cornerRadius = self.cornerRadius(for: state)

			self.container.currentViewTransfrorm = transform
			self.container.currentViewController?.view.transform = transform

			self.container.currentViewCornerRadius = cornerRadius
			self.container.currentViewController?.view.layer.cornerRadius = cornerRadius
		}

		stateAnimator.addCompletion { position in
			switch position {
			case .start:
				self.delegate?.menu(self, didClose: animated)
			case .end:
				self.view.tag = state == .closed ? 404 : 0
				if state == .closed {
					self.delegate?.menu(self, didClose: animated)
				} else {
					self.delegate?.menu(self, didOpen: animated)
				}
			case .current:
				break
			}

			self.view.isUserInteractionEnabled = true
			self.animator = nil
			completion?()
		}

		return stateAnimator
	}

	internal func animateTransitionIfNeeded(to state: MenuState, animated: Bool = true, _ completion: (() -> Void)? = nil) {
		if animator != nil { return }

		self.view.isUserInteractionEnabled = false
		
		switch state {
		case .open:
			container.leftMenu?.view.isHidden = side == .right
			container.rightMenu?.view.isHidden = side == .left

			delegate?.menu(self, willOpen: animated)
		case .closed:
			delegate?.menu(self, willClose: animated)
		}

		animator = animator(for: state, animated: animated, completion)
	}

}

//
//  BGStatePickerView.swift
//  BGStatePicker
//
//  Created by Benjamin Grima on 21/03/16.
//  Copyright © 2016 Benjamin Grima. All rights reserved.
//

import UIKit
public func toto() {
}
public class BGStatePickerView: UIView {

	public var delegate: BGStatePickerDelegate?
	public var datasource: BGStatePickerDatasource?

	var selected: BGStateable?
	var cachedStates: [BGStateable] = []
	var folded = false
	var animationDuration = 1.0
	var selectedIndex: Int?

	public override init(frame: CGRect) {
		super.init(frame: frame)
	}
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	public func reloadData() {
		subviews.forEach {
			$0.removeFromSuperview()
		}

		cachedStates = [BGStateable]()

		var xOffset: CGFloat = 0

		if let datasource = datasource {
			for index in 0 ..< datasource.numberOfState() {
				let state: BGStateable = datasource.stateForIndex(index)
				cachedStates.append(state)
				let button = self.buttonFromState(state)
				let size = state.stateSize
				button.frame = CGRect(x: xOffset, y: 0, width: size.width, height: size.height)
				xOffset += size.width
				self.addSubview(button)
			}
		}
		self.reloadViews()
	}

	func buttonFromState(state: BGStateable) -> BGStateView {
		let action = #selector(BGStatePickerView.didTapOnState(_:))
		let stateView = BGStateView(state: state)
		stateView.addTarget(self, action: action, forControlEvents: .TouchUpInside)
		return stateView
	}

	func didTapOnState(sender: BGStateView) {
		// retrieve selected state
		if let state = sender.pickerState {
			// update selected state
			selected = state
			if let i = self.subviews.indexOf(sender) {
				selectedIndex = i
			}

			// call delegate
			delegate?.didPickState(state)
		}
		// update
		self.folded = !folded

		// refresh view
		self.reloadViews()
	}

	func reloadViews() {

		if let i = self.selectedIndex {
			if let current = self.subviews[i] as? BGStateView {
				self.willRemoveSubview(current)
				current.removeFromSuperview()
				self.insertSubview(current, atIndex: 0)
			}
		}

		UIView.animateWithDuration(1.0, animations: {
			var x: CGFloat = 0.0
			self.subviews.forEach {
				if self.folded {
					$0.frame.origin.x = 0.0
				} else {
					if let sub = $0 as? BGStateView {
						if let s1 = sub.pickerState, s2 = self.selected where s1 == s2 {
							$0.frame.origin.x = 0.0
						} else {
							$0.frame.origin.x = x
						}
					}
				}
				x += $0.frame.width
			}
		}) { (Bool) in

			self.subviews.forEach {
				if self.folded {
					if let sub = $0 as? BGStateView {
						if let s1 = sub.pickerState, s2 = self.selected where s1 == s2 {
							$0.hidden = false
						} else {
							$0.hidden = true
						}
					}
				} else {
					$0.hidden = false
				}
			}
		}
	}
}

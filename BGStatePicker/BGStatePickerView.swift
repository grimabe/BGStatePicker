//
//  BGStatePickerView.swift
//  BGStatePicker
//
//  Created by Benjamin Grima on 21/03/16.
//  Copyright © 2016 Benjamin Grima. All rights reserved.
//

import UIKit

@IBDesignable
public class BGStatePickerView: UIControl {

	public var datasource: BGStatePickerDatasource?

	private(set) public var selectedValue: BGStateable?

	var cachedStates: [BGStateable] = []
	var folded = false
	var animationDuration = 0.33
	var selectedIndex: Int?
	var reloading = false

	@IBInspectable var foldLeft: Bool = true

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

		if let datasource = datasource {
			for index in 0 ..< datasource.numberOfState(self) {
				let state: BGStateable = datasource.stateForIndex(self, index: index)
				cachedStates.append(state)
				let button = buttonFromState(state)
				addSubview(button)
			}
		}
		reloadViews()
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
			selectedValue = state
			if let i = subviews.indexOf(sender) {
				selectedIndex = i
			}

			// call delegate
			sendActionsForControlEvents([.ValueChanged])
		}
		// update
		folded = !folded

		// refresh view
		reloadViews()
	}

	func reloadViews() {

		if reloading {
			return
		}
		reloading = true

		userInteractionEnabled = false

		reloadViewsBasedOnDataSource()

		bringSelectedViewToFront()

		// set position within an animation
		UIView.animateWithDuration(animationDuration, animations: {
			var x: CGFloat = 0.0
			self.subviews.reverse().forEach {
				if self.folded {
					$0.frame.origin.x = 0.0
				} else {
					$0.hidden = false
					if let sub = $0 as? BGStateView {
						if let s1 = sub.pickerState, s2 = self.selectedValue where s1 == s2 {

							$0.frame.origin.x = 0.0
						} else {
							$0.frame.origin.x = x
						}
					}
				}
				x += $0.frame.width
			}
		}) { (Bool) in
			self.animationCompleted()
		}
	}

	func reloadViewsBasedOnDataSource() {
		// reload stateview sizes
		subviews.forEach {
			if let sub = $0 as? BGStateView {
				if let size = sub.pickerState?.stateSize {
					var f = $0.frame
					f.size = size
					$0.frame = f
				}
			}
		}
	}

	func bringSelectedViewToFront() {
		if let i = selectedIndex {
			if let current = subviews[i] as? BGStateView {
				bringSubviewToFront(current)
			}
		}
	}

	func animationCompleted() {
		userInteractionEnabled = true
		subviews.reverse().forEach {
			if folded {
				if let sub = $0 as? BGStateView {
					if let s1 = sub.pickerState, s2 = selectedValue where s1 == s2 {
						$0.hidden = false
					} else {
						$0.hidden = true
					}
				}
			} else {
				$0.hidden = false
			}
		}
		reloading = false
	}

	public override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
		if let v = super.hitTest(point, withEvent: event) {
			return v
		}
		if selectedValue != nil && !reloading {
			folded = true
			reloadViews()
		}
		return nil
	}

	public override func prepareForInterfaceBuilder() {
		let label = UILabel(frame: bounds)
		label.text = foldLeft ? "Coming left => " : "Coming right <="
		label.textAlignment = foldLeft ? .Left : .Right
		self.addSubview(label)
	}
}

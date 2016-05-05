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
	var initiated = false

	@IBInspectable public var foldLeft: Bool = true
	@IBInspectable public var keepOrder: Bool = true

	public override init(frame: CGRect) {
		super.init(frame: frame)
	}

	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	public override func layoutSubviews() {
		super.layoutSubviews()
		initiated = true
		reloadViews(false)
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
		reloadViews(false)
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
			if folded == false {
				sendActionsForControlEvents([.ValueChanged])
			}
		}
		// update
		folded = !folded

		// refresh view
		reloadViews(true)
	}

	func reloadViews(animated: Bool) {
		if !initiated || reloading {
			return
		}

		if self.selectedValue == nil && self.cachedStates.count > 0 {
			selectedValue = cachedStates[0]
			selectedIndex = 0
		}
		reloading = true

		userInteractionEnabled = false

		reloadSizes()
		bringSelectedViewToFront()
		// set position within an animation

		if animated {
			UIView.animateWithDuration(animationDuration, animations: {
				self.reloadPositions()
			}) { (Bool) in
				self.animationCompleted()
			}
		} else {
			reloadPositions()
			animationCompleted()
		}
	}

	func reloadSizes() {
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

	func reloadPositions() {
		var offset: CGFloat = foldLeft ? 0 : frame.width
		subviews.reverse().forEach {
			if folded {
				$0.frame.origin.x = foldLeft ? 0 : frame.width - $0.frame.width
			} else {
				$0.hidden = false
				if let state = ($0 as? BGStateView)?.pickerState {
					var xPos: CGFloat
					if keepOrder {
						let xOrderedPos = self.orderedPosition(state)
						xPos = foldLeft ? xOrderedPos : frame.width - xOrderedPos - state.stateSize.width
					} else {
						if let s2 = selectedValue where state == s2 {
							xPos = foldLeft ? 0 : self.frame.width - $0.frame.width
						} else {
							xPos = foldLeft ? offset : offset - $0.frame.width
						}
					}
					$0.frame.origin.x = xPos
				}
			}
			offset += foldLeft ? $0.frame.width : -$0.frame.width
		}
	}

	func orderedPosition(state: BGStateable) -> CGFloat {
		var position: CGFloat = 0
		for s in cachedStates {
			if s == state {
				break
			}
			position += state.stateSize.width
		}
		return position
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

	func openPicker(open: Bool, animated: Bool) {
		if folded == open && !reloading {
			folded = !open
			reloadViews(animated)
		}
	}

	public func open(animated: Bool) {
		openPicker(true, animated: animated)
	}

	public func close(animated: Bool) {
		openPicker(false, animated: animated)
	}

	public override func prepareForInterfaceBuilder() {
		let label = UILabel(frame: bounds)
		label.text = foldLeft ? "Coming left => " : "Coming right <="
		label.textAlignment = foldLeft ? .Left : .Right
		addSubview(label)
	}
}

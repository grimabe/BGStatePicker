//
//  BGStatePickerView.swift
//  BGStatePicker
//
//  Created by Benjamin Grima on 21/03/16.
//  Copyright © 2016 Benjamin Grima. All rights reserved.
//

import UIKit

@IBDesignable
open class BGStatePickerView: UIControl {

	open var datasource: BGStatePickerDatasource?

	fileprivate(set) open var selectedValue: BGStateable?

	var cachedStates: [BGStateable] = []
	var folded = false
	var animationDuration = 0.33
	var selectedIndex: Int?
	var reloading = false
	var initiated = false

	@IBInspectable open var foldLeft: Bool = true
	@IBInspectable open var keepOrder: Bool = true

	public override init(frame: CGRect) {
		super.init(frame: frame)
	}

	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	open override func layoutSubviews() {
		super.layoutSubviews()
		initiated = true
		reloadViews(false)
	}

	open func reloadData() {
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

	func buttonFromState(_ state: BGStateable) -> BGStateView {
		let action = #selector(BGStatePickerView.didTapOnState(_:))
		let stateView = BGStateView(state: state)
		stateView.addTarget(self, action: action, for: .touchUpInside)
		return stateView
	}

	func didTapOnState(_ sender: BGStateView) {
		// retrieve selected state
		if let state = sender.pickerState {
			// update selected state
			selectedValue = state
			if let i = subviews.index(of: sender) {
				selectedIndex = i
			}

			// call delegate
			if folded == false {
				sendActions(for: [.valueChanged])
			}
		}
		// update
		folded = !folded

		// refresh view
		reloadViews(true)
	}

	func reloadViews(_ animated: Bool) {
		if !initiated || reloading {
			return
		}

		if self.selectedValue == nil && self.cachedStates.count > 0 {
			selectedValue = cachedStates[0]
			selectedIndex = 0
		}
		reloading = true

		isUserInteractionEnabled = false

		reloadSizes()
		bringSelectedViewToFront()
		// set position within an animation

		if animated {
			UIView.animate(withDuration: animationDuration, animations: {
				self.reloadPositions()
			}, completion: { (Bool) in
				self.animationCompleted()
			}) 
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
				bringSubview(toFront: current)
			}
		}
	}

	func allItemsWidth() -> CGFloat {
		var total: CGFloat = 0.0
		subviews.forEach {
			total += $0.frame.width
		}
		return total
	}

	func reloadPositions() {
		var offset: CGFloat = foldLeft ? 0 : 0
		let foldRightOffest: CGFloat = frame.width - allItemsWidth()
		subviews.reversed().forEach {
			if folded {
				$0.frame.origin.x = foldLeft ? 0 : frame.width - $0.frame.width
			} else {
				$0.isHidden = false
				if let state = ($0 as? BGStateView)?.pickerState {
					var xPos: CGFloat
					if keepOrder {
						let xOrderedPos = self.orderedPosition(state)
						xPos = foldLeft ? xOrderedPos : foldRightOffest + xOrderedPos
					} else {
						if let s2 = selectedValue, state == s2 {
							xPos = foldLeft ? 0 : self.frame.width - $0.frame.width
						} else {
							print("\(self.frame.width) \(offset) \($0.frame.width)")
							xPos = foldLeft ? offset : self.frame.width - offset - $0.frame.width
						}
					}
					$0.frame.origin.x = xPos
				}
			}
			offset += foldLeft ? $0.frame.width : $0.frame.width
		}
	}

	func orderedPosition(_ state: BGStateable) -> CGFloat {
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
		isUserInteractionEnabled = true
		subviews.reversed().forEach {
			if folded {
				if let sub = $0 as? BGStateView {
					if let s1 = sub.pickerState, let s2 = selectedValue, s1 == s2 {
						$0.isHidden = false
					} else {
						$0.isHidden = true
					}
				}
			} else {
				$0.isHidden = false
			}
		}
		reloading = false
	}

	func openPicker(_ open: Bool, animated: Bool) {
		if folded == open && !reloading {
			folded = !open
			reloadViews(animated)
		}
	}

	open func open(_ animated: Bool) {
		openPicker(true, animated: animated)
	}

	open func close(_ animated: Bool) {
		openPicker(false, animated: animated)
	}

	open override func prepareForInterfaceBuilder() {
		let label = UILabel(frame: bounds)
		label.text = foldLeft ? "Coming left => " : "Coming right <="
		label.textAlignment = foldLeft ? .left : .right
		addSubview(label)
	}
}

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
	}

	func buttonFromState(state: BGStateable) -> BGStateView {
		let action = #selector(BGStatePickerView.didTapOnState(_:))
		let stateView = BGStateView(state: state)
		stateView.addTarget(self, action: action, forControlEvents: .TouchUpInside)
		return stateView
	}

	func didTapOnState(sender: BGStateView) {
		// retrieve selected state
		let state = sender.pickerState

		// update selected state
		selected = state

		// call delegate
		delegate?.didPickState(state)

		// update
		self.folded = !folded
	}
}

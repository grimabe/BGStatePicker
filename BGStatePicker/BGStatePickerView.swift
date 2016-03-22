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
			for index in 0 ..< datasource.numberOfState() {
				let state: BGStateable = datasource.stateForIndex(index)
				cachedStates.append(state)
				let button = UIButton()
				button.backgroundColor = state.stateBackgroundColor()
				button.setTitle(state.stateText(), forState: .Normal)
                button.addTarget(self, action: #selector(didTapOnState), forControlEvents: .TouchUpInside)
				button.titleLabel?.font = state.stateTextFont()

				self.addSubview(button)
			}
		}
	}

	func didTapOnState(sender: UIView) {
		// retrieve selected state

		// update selected state

		// call delegate
	}
}

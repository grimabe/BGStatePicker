//
//  BGStateView.swift
//  BGStatePicker
//
//  Created by Benjamin Grima on 24/03/16.
//  Copyright © 2016 Benjamin Grima. All rights reserved.
//

import UIKit

class BGStateView: UIButton {
	var pickerState: BGStateable?

	init(state: BGStateable) {
		self.pickerState = state
		super.init(frame: CGRect.zero)
		backgroundColor = state.stateBackgroundColor
		setTitle(state.stateText, for: UIControlState())
		titleLabel?.font = state.stateTextFont
		setTitleColor(state.stateTextColor, for: UIControlState())
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
}

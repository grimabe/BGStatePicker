//
//  BGSampleState.swift
//  BGStatePicker
//
//  Created by Benjamin Grima on 21/04/16.
//  Copyright © 2016 Benjamin Grima. All rights reserved.
//

import Foundation
import BGStatePicker

class BGSampleState: UITableViewCell {

	class func state() -> BGStateable {
		let sampleState = BGStateable()
		sampleState.stateText = "Blue"
		sampleState.stateSize = CGSize(width: 33, height: 33)
		sampleState.stateBackgroundColor = .blueColor()
		sampleState.stateTextFont = .systemFontOfSize(10)
		sampleState.stateTextColor = .redColor()
		return sampleState
	}
}

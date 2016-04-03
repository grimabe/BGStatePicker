//
//  BGMockStatePickerDatasource.swift
//  BGStatePicker
//
//  Created by Benjamin Grima on 21/03/16.
//  Copyright © 2016 Benjamin Grima. All rights reserved.
//

import Foundation
import BGStatePicker

class BGMockStatePickerDatasource: BGStatePickerDatasource {

	var states = [BGStateable]()

	func numberOfState(statePickerView: BGStatePickerView) -> Int {
		return states.count
	}
	func stateForIndex(statePickerView: BGStatePickerView, index: Int) -> BGStateable {
		return states[index]
	}
}

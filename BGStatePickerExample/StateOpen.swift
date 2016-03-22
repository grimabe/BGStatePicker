//
//  StateOpen.swift
//  BGStatePicker
//
//  Created by Benjamin Grima on 22/03/16.
//  Copyright © 2016 Benjamin Grima. All rights reserved.
//

import Foundation
import BGStatePicker

class StateOpen: BGStateable {
	func stateText() -> String {
		return "Open"
	}
	func stateTextFont() -> UIFont {
		return UIFont.systemFontOfSize(20)
	}
	func stateBackgroundColor() -> UIColor {
		return UIColor.greenColor()
	}
	func stateTextColor() -> UIColor {
		return UIColor.whiteColor()
	}
	func stateSize() -> CGSize {
		return CGSize(width: 80, height: 80)
	}
}

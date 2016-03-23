//
//  BGMockStatePickerStateable.swift
//  BGStatePicker
//
//  Created by Benjamin Grima on 21/03/16.
//  Copyright © 2016 Benjamin Grima. All rights reserved.
//

import Foundation
import BGStatePicker
import UIKit

class BGMockStatePickerStateable: BGStateable {

	var text = "red"
	var color = UIColor.redColor()
	var backgroundColor = UIColor.blueColor()
	var font = UIFont.systemFontOfSize(10)
	var size = CGSize(width: 40, height: 40)
	func stateText() -> String {
		return text
	}

	func stateTextColor() -> UIColor {
		return color
	}

	func stateBackgroundColor() -> UIColor {
		return backgroundColor
	}

	func stateTextFont() -> UIFont {
		return font
	}

	func stateSize() -> CGSize {
		return size
	}
}

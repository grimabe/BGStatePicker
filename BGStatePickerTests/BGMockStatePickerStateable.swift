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
	var stateText: String {
		get {
			return "Blue"
		}
	}
	var stateSize: CGSize {
		get {
			return CGSize(width: 40, height: 40)
		}
	}
	var stateTextFont: UIFont {
		get {
			return .systemFontOfSize(10)
		}
	}
	var stateTextColor: UIColor {
		get {
			return .redColor()
		}
	}
	var stateBackgroundColor: UIColor {
		get {
			return .blueColor()
		}
	}
}

//
//  BGStatable.swift
//  BGStatePicker
//
//  Created by Benjamin Grima on 21/03/16.
//  Copyright © 2016 Benjamin Grima. All rights reserved.
//

import Foundation

public protocol BGStateable {
	func stateText() -> String
	func stateTextColor() -> UIColor
	func stateTextFont() -> UIFont
	func stateBackgroundColor() -> UIColor
	func stateSize() -> CGSize
}

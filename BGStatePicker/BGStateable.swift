//
//  BGStatable.swift
//  BGStatePicker
//
//  Created by Benjamin Grima on 21/03/16.
//  Copyright © 2016 Benjamin Grima. All rights reserved.
//

import Foundation

public protocol BGStateable {
	var stateText: String { get }
	var stateTextColor: UIColor { get }
	var stateTextFont: UIFont { get }
	var stateBackgroundColor: UIColor { get }
	var stateSize: CGSize { get }
}

public extension BGStateable {
	var stateText: String {
		get {
			return "Text"
		}
	}
	var stateSize: CGSize {
		get {
			return CGSize(width: 40, height: 40)
		}
	}
	var stateTextFont: UIFont {
		get {
			return .systemFontOfSize(14)
		}
	}
	var stateTextColor: UIColor {
		get {
			return .whiteColor()
		}
	}
	var stateBackgroundColor: UIColor {
		get {
			return .greenColor()
		}
	}
}

func == (lhs: BGStateable, rhs: BGStateable) -> Bool {
	return lhs.stateText == rhs.stateText
}

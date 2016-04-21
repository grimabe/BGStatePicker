//
//  BGStatable.swift
//  BGStatePicker
//
//  Created by Benjamin Grima on 21/03/16.
//  Copyright © 2016 Benjamin Grima. All rights reserved.
//

import Foundation

public class BGStateable {

	public var stateText: String = "Text"
	public var stateSize: CGSize = CGSize(width: 40, height: 40)
	public var stateTextFont: UIFont = .systemFontOfSize(14)
	public var stateTextColor: UIColor = .whiteColor()
	public var stateBackgroundColor: UIColor = .greenColor()

	public init() {
	}
}

func == (lhs: BGStateable, rhs: BGStateable) -> Bool {
	return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}

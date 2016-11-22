//
//  BGStatable.swift
//  BGStatePicker
//
//  Created by Benjamin Grima on 21/03/16.
//  Copyright © 2016 Benjamin Grima. All rights reserved.
//

import Foundation

open class BGStateable {

	open var stateText: String = "Text"
	open var stateSize: CGSize = CGSize(width: 40, height: 40)
	open var stateTextFont: UIFont = .systemFont(ofSize: 14)
	open var stateTextColor: UIColor = .white
	open var stateBackgroundColor: UIColor = .green

	public init() {
	}
}

func == (lhs: BGStateable, rhs: BGStateable) -> Bool {
	return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}

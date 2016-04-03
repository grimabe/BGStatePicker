//
//  BGStatePickerDelegate.swift
//  BGStatePicker
//
//  Created by Benjamin Grima on 21/03/16.
//  Copyright © 2016 Benjamin Grima. All rights reserved.
//

import Foundation

public protocol BGStatePickerDelegate {
	func didPickState(statePickerView: BGStatePickerView, state: BGStateable)
}

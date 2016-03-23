//
//  BGStatePickerStateableTests.swift
//  BGStatePicker
//
//  Created by Benjamin Grima on 21/03/16.
//  Copyright © 2016 Benjamin Grima. All rights reserved.
//

import XCTest
import BGStatePicker

class BGStatePickerStateableTests: XCTestCase {

	override func setUp() {
		super.setUp()
	}

	override func tearDown() {
		super.tearDown()
	}

	func testStateable() {

		let mockState = BGMockStatePickerStateable()

		let view = BGStatePickerView()
		let datasource = BGMockStatePickerDatasource()
		view.datasource = datasource
		datasource.states = [mockState]

		view.reloadData()

		XCTAssertEqual(view.subviews.count, 1)

		guard let subview = view.subviews.first as? UIButton else {
			XCTFail()
			return
		}
		subview.layoutIfNeeded()
		XCTAssertEqual(subview.titleLabel?.text, mockState.stateText)
		XCTAssertEqual(subview.titleLabel?.font, mockState.stateTextFont)
		XCTAssertEqual(subview.titleLabel?.textColor, mockState.stateTextColor)
		XCTAssertEqual(subview.frame.size, mockState.stateSize)
		guard let backgroundColor = subview.backgroundColor else {
			XCTFail()
			return
		}

		XCTAssertEqual(backgroundColor, mockState.stateBackgroundColor)
	}
}

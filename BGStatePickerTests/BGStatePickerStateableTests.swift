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

		let view = BGStatePickerView()
		let datasource = BGMockStatePickerDatasource()
		view.datasource = datasource
		let sampleState = BGSampleState.state()
		datasource.states = [sampleState]

		view.reloadData()

		XCTAssertEqual(view.subviews.count, 1)

		guard let subview = view.subviews.first as? UIButton else {
			XCTFail()
			return
		}
		view.layoutIfNeeded()
		XCTAssertEqual(subview.titleLabel?.text, sampleState.stateText)
		XCTAssertEqual(subview.titleLabel?.font, sampleState.stateTextFont)
		XCTAssertEqual(subview.titleLabel?.textColor, sampleState.stateTextColor)
		XCTAssertEqual(subview.frame.size, sampleState.stateSize)
		guard let backgroundColor = subview.backgroundColor else {
			XCTFail()
			return
		}

		XCTAssertEqual(backgroundColor, sampleState.stateBackgroundColor)
	}
}

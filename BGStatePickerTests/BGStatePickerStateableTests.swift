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
		let mockText = "blue"
		let mockTextColor = UIColor.purpleColor()
		let mockBackgroundColor = UIColor.darkGrayColor()
		let mockTextFont = UIFont.systemFontOfSize(37.5)
		let mockSize = CGSize(width: 77, height: 33)

		let mockState = BGMockStatePickerStateable()
		mockState.text = mockText
		mockState.color = mockTextColor
		mockState.font = mockTextFont
		mockState.backgroundColor = mockBackgroundColor
		mockState.size = mockSize

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
		XCTAssertEqual(subview.titleLabel?.text, mockText)
		XCTAssertEqual(subview.titleLabel?.font, mockTextFont)
		XCTAssertEqual(subview.titleLabel?.textColor, mockTextColor)
		XCTAssertEqual(subview.frame.size, mockSize)
		guard let backgroundColor = subview.backgroundColor else {
			XCTFail()
			return
		}

		XCTAssertEqual(backgroundColor, mockBackgroundColor)
	}
}

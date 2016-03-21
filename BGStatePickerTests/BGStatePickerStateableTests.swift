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
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}

	func testStateable() {
		let mock = BGMockStatePickerStateable()
		mock.text = "blue"
		mock.color = UIColor.purpleColor()
		mock.font = UIFont.systemFontOfSize(37.5)
		mock.backgroundColor = UIColor.darkGrayColor()

		let view = BGStatePickerView()
		let datasource = BGMockStatePickerDatasource()
		view.datasource = datasource
		datasource.states = [mock]

		view.reloadData()

		XCTAssertEqual(view.subviews.count, 1)

		let subview = view.subviews.first! as! UIButton

		XCTAssertEqual(subview.titleLabel?.text, "blue")
		XCTAssertEqual(subview.titleLabel?.font, UIFont.systemFontOfSize(37.5))
		// TODO Add test for color
	}
}

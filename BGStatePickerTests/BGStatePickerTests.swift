//
//  BGStatePickerTests.swift
//  BGStatePickerTests
//
//  Created by Benjamin Grima on 21/03/16.
//  Copyright © 2016 Benjamin Grima. All rights reserved.
//

import XCTest
@testable import BGStatePicker

class BGStatePickerTests: XCTestCase {

	var view: BGStatePickerView!

	override func setUp() {
		super.setUp()
		view = BGStatePickerView()
	}

	override func tearDown() {
		view = nil
		super.tearDown()
	}

	func testPickerView() {
		view.reloadData()
		XCTAssertEqual(view.subviews.count, 0)
	}

	func testPickerViewDataSource() {
		let datasource = BGMockStatePickerDatasource()
		view.datasource = datasource
		view.reloadData()
		XCTAssertEqual(view.subviews.count, 0)
	}

	func testPickerViewDataSourceWithOneState() {
		XCTAssertEqual(view.subviews.count, 0)
		let datasource = BGMockStatePickerDatasource()
		view.datasource = datasource
		datasource.states = [BGMockStatePickerStateable()]
		XCTAssertEqual(view.subviews.count, 0)
		view.reloadData()
		XCTAssertEqual(view.subviews.count, 1)
	}

	func testPickerViewDataSourceWithOneStateAndChangeTheStatesAfterInit() {
		let datasource = BGMockStatePickerDatasource()
		view.datasource = datasource
		datasource.states = [BGMockStatePickerStateable()]
		XCTAssertEqual(view.subviews.count, 0)
		view.reloadData()
		XCTAssertEqual(view.subviews.count, 1)
		datasource.states = [BGMockStatePickerStateable()]
		XCTAssertEqual(view.subviews.count, 1)
		view.reloadData()
		XCTAssertEqual(view.subviews.count, 1)
	}

	func testPickerViewDataSourceWithOneStateAndAddAStateAfterReload() {
		let datasource = BGMockStatePickerDatasource()
		view.datasource = datasource
		datasource.states = [BGMockStatePickerStateable()]
		view.reloadData()
		XCTAssertEqual(view.subviews.count, 1)
		datasource.states = [BGMockStatePickerStateable(), BGMockStatePickerStateable()]
		view.reloadData()
		XCTAssertEqual(view.subviews.count, 2)
	}

	func testPickerViewDataSourceWithTwoStatesAndChangeTheStatesAfterInit() {
		let datasource = BGMockStatePickerDatasource()
		view.datasource = datasource
		datasource.states = [BGMockStatePickerStateable(), BGMockStatePickerStateable()]
		view.reloadData()
		XCTAssertEqual(view.subviews.count, 2)
		datasource.states = [BGMockStatePickerStateable()]
		view.reloadData()
		XCTAssertEqual(view.subviews.count, 1)
	}
}

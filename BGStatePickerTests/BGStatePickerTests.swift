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
	var datasource: BGMockStatePickerDatasource!

	override func setUp() {
		super.setUp()
		view = BGStatePickerView()
		datasource = BGMockStatePickerDatasource()
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
		view.datasource = datasource
		view.reloadData()
		XCTAssertEqual(view.subviews.count, 0)
	}

	func testPickerViewDataSourceWithOneState() {
		XCTAssertEqual(view.subviews.count, 0)
		view.datasource = datasource
		datasource.states = [BGSampleState.state()]
		XCTAssertEqual(view.subviews.count, 0)
		view.reloadData()
		XCTAssertEqual(view.subviews.count, 1)
	}

	func testPickerViewDataSourceWithOneStateAndChangeTheStatesAfterInit() {
		view.datasource = datasource
		datasource.states = [BGSampleState.state()]
		XCTAssertEqual(view.subviews.count, 0)
		view.reloadData()
		XCTAssertEqual(view.subviews.count, 1)
		datasource.states = [BGSampleState.state()]
		XCTAssertEqual(view.subviews.count, 1)
		view.reloadData()
		XCTAssertEqual(view.subviews.count, 1)
	}

	func testPickerViewDataSourceWithOneStateAndAddAStateAfterReload() {
		view.datasource = datasource
		datasource.states = [BGSampleState.state()]
		view.reloadData()
		XCTAssertEqual(view.subviews.count, 1)
		datasource.states = [BGSampleState.state(), BGSampleState.state()]
		view.reloadData()
		XCTAssertEqual(view.subviews.count, 2)
	}

	func testPickerViewDataSourceWithTwoStatesAndChangeTheStatesAfterInit() {
		view.datasource = datasource
		datasource.states = [BGSampleState.state(), BGSampleState.state()]
		view.reloadData()
		XCTAssertEqual(view.subviews.count, 2)
		datasource.states = [BGSampleState.state()]
		view.reloadData()
		XCTAssertEqual(view.subviews.count, 1)
	}

	func testPickerStatePicker() {
		view.datasource = datasource
		datasource.states = [BGSampleState.state(), BGSampleState.state()]
		view.reloadData()
		if let sub = view.subviews.first! as? BGStateView {
			view.didTapOnState(sub)
			if let selected = view.selectedValue {
				XCTAssertEqual(selected.stateText, datasource.states[0].stateText)
			} else {
				XCTFail()
			}
		} else {
			XCTFail()
		}
	}
}

//
//  ViewController.swift
//  BGStatePickerExample
//
//  Created by Benjamin Grima on 22/03/16.
//  Copyright © 2016 Benjamin Grima. All rights reserved.
//

import UIKit
import BGStatePicker

class ViewController: UIViewController {

	@IBOutlet weak var statePickerView: BGStatePickerView!
	@IBOutlet weak var agePickerStateView: BGStatePickerView!

	let statusStates: [BGStateable] = [StateOpen(), StateClosed()]
	let ageStates: [BGStateable] = [StateNew(), StateOld(), StateAncestral()]

	override func viewDidLoad() {
		super.viewDidLoad()
		statePickerView.datasource = self
		statePickerView.delegate = self

		agePickerStateView.datasource = self
		agePickerStateView.delegate = self

		statePickerView.reloadData()
		agePickerStateView.reloadData()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

extension ViewController: BGStatePickerDatasource {
	func numberOfState(pickerState: BGStatePickerView) -> Int {
		switch pickerState {
		case statePickerView:
			return statusStates.count
		case agePickerStateView:
			return ageStates.count
		default:
			return 0
		}
	}

	func stateForIndex(pickerState: BGStatePickerView, index: Int) -> BGStateable {
		switch pickerState {
		case statePickerView:
			return statusStates[index]
		case agePickerStateView:
			return ageStates[index]
		default:
			return statusStates[0]
		}
	}
}

extension ViewController: BGStatePickerDelegate {
	func didPickState(state: BGStateable) {
		print("You pick state " + state.stateText)
	}
}

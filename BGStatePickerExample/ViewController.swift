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
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
}

extension ViewController: BGStatePickerDatasource {

	func numberOfState(statePickerView: BGStatePickerView) -> Int {
		switch statePickerView {
		case self.statePickerView:
			return statusStates.count
		case agePickerStateView:
			return ageStates.count
		default:
			return 0
		}
	}
	func stateForIndex(statePickerView: BGStatePickerView, index: Int) -> BGStateable {
		switch statePickerView {
		case self.statePickerView:
			return statusStates[index]
		case agePickerStateView:
			return ageStates[index]
		default:
			return statusStates[0]
		}
	}
}

extension ViewController: BGStatePickerDelegate {

	func didPickState(statePickerView: BGStatePickerView, state: BGStateable) {
		print("You pick state " + state.stateText)
	}
}

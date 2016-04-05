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
		let sel = #selector(pickState(_:))
		statePickerView.addTarget(self, action: sel, forControlEvents: [.ValueChanged])
		agePickerStateView.datasource = self
		agePickerStateView.addTarget(self, action: sel, forControlEvents: [.ValueChanged])

		statePickerView.reloadData()
		agePickerStateView.reloadData()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	func pickState(sender: BGStatePickerView) {
		print("You pick state \(sender.selectedValue?.stateText)")
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

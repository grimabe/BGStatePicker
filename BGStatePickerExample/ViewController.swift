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
	let states: [BGStateable] = [StateOpen(), StateClosed()]

	override func viewDidLoad() {
		super.viewDidLoad()
		statePickerView.datasource = self
		statePickerView.delegate = self
		statePickerView.reloadData()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

extension ViewController: BGStatePickerDatasource {
	func numberOfState(pickerState: BGStatePickerView) -> Int {
		if pickerState == self.statePickerView {
			return states.count
		} else {
			return 0
		}
	}

	func stateForIndex(pickerState: BGStatePickerView, index: Int) -> BGStateable {
		if pickerState == self.statePickerView {
			return states[index]
		}
		return states[0]
	}
}

extension ViewController: BGStatePickerDelegate {
	func didPickState(state: BGStateable) {
		print("You pick state " + state.stateText)
	}
}

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
	@IBOutlet weak var statePickerView2: BGStatePickerView!
	@IBOutlet weak var agePickerStateView: BGStatePickerView!
	@IBOutlet weak var ageStatePickerView2: BGStatePickerView!

	let statusStates: [BGStateable] = [StateOpen(), StateClosed()]
	let ageStates: [BGStateable] = [StateNew(), StateOld(), StateAncestral()]

	override func viewDidLoad() {
		super.viewDidLoad()

		let selTap = #selector(foldPickers(_:))
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: selTap)
		view.addGestureRecognizer(tap)

		let sel = #selector(pickState(_:))

		statePickerView.datasource = self
		statePickerView.addTarget(self, action: sel, forControlEvents: [.ValueChanged])
		statePickerView.reloadData()

		statePickerView2.datasource = self
		statePickerView2.addTarget(self, action: sel, forControlEvents: [.ValueChanged])
		statePickerView2.reloadData()

		agePickerStateView.datasource = self
		agePickerStateView.addTarget(self, action: sel, forControlEvents: [.ValueChanged])
		agePickerStateView.reloadData()

		ageStatePickerView2.datasource = self
		ageStatePickerView2.addTarget(self, action: sel, forControlEvents: [.ValueChanged])
		ageStatePickerView2.reloadData()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	func pickState(sender: BGStatePickerView) {
		print("You pick state \(sender.selectedValue?.stateText)")
	}

	func foldPickers(sender: UIView) {
		statePickerView.close(true)
		statePickerView2.close(true)
		agePickerStateView.close(true)
		ageStatePickerView2.close(true)
	}
}

extension ViewController: BGStatePickerDatasource {

	func numberOfState(statePickerView: BGStatePickerView) -> Int {
		switch statePickerView {
		case self.statePickerView, statePickerView2:
			return statusStates.count
		case agePickerStateView, ageStatePickerView2:
			return ageStates.count
		default:
			return 0
		}
	}
	func stateForIndex(statePickerView: BGStatePickerView, index: Int) -> BGStateable {
		switch statePickerView {
		case self.statePickerView, statePickerView2:
			return statusStates[index]
		case agePickerStateView, ageStatePickerView2:
			return ageStates[index]
		default:
			return statusStates[0]
		}
	}
}

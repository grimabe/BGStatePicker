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

	var statusStates = [BGStateable]()
	var ageStates = [BGStateable]()

	override func viewDidLoad() {
		super.viewDidLoad()

		let openState = BGStateable()
		openState.stateText = "Open"

		let closedState = BGStateable()
		closedState.stateText = "Close"
		closedState.stateBackgroundColor = .red

		let newState = BGStateable()
		newState.stateText = "New"
		newState.stateBackgroundColor = .green
		newState.stateSize = CGSize(width: 80, height: 80)

		let oldState = BGStateable()
		oldState.stateText = "Old"
		oldState.stateBackgroundColor = .orange
		oldState.stateSize = CGSize(width: 80, height: 80)

		let ancestralState = BGStateable()
		ancestralState.stateText = "Ancestral"
		ancestralState.stateBackgroundColor = .brown
		ancestralState.stateSize = CGSize(width: 80, height: 80)

		statusStates = [openState, closedState]
		ageStates = [newState, oldState, ancestralState]

		let selTap = #selector(foldPickers(_:))
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: selTap)
		view.addGestureRecognizer(tap)

		let sel = #selector(pickState(_:))

		statePickerView.datasource = self
		statePickerView.addTarget(self, action: sel, for: [.valueChanged])
		statePickerView.reloadData()

		statePickerView2.datasource = self
		statePickerView2.addTarget(self, action: sel, for: [.valueChanged])
		statePickerView2.reloadData()

		agePickerStateView.datasource = self
		agePickerStateView.addTarget(self, action: sel, for: [.valueChanged])
		agePickerStateView.reloadData()

		ageStatePickerView2.datasource = self
		ageStatePickerView2.keepOrder = false
		ageStatePickerView2.addTarget(self, action: sel, for: [.valueChanged])
		ageStatePickerView2.reloadData()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	func pickState(_ sender: BGStatePickerView) {
		if let state = sender.selectedValue { // BGStateable
			print("You pick state \(state.stateText)")
		}
	}

	func foldPickers(_ sender: UIView) {
		statePickerView.close(true)
		statePickerView2.close(true)
		agePickerStateView.close(true)
		ageStatePickerView2.close(true)
	}
}

extension ViewController: BGStatePickerDatasource {

	func numberOfState(_ statePickerView: BGStatePickerView) -> Int {
		switch statePickerView {
		case self.statePickerView, statePickerView2:
			return statusStates.count
		case agePickerStateView, ageStatePickerView2:
			return ageStates.count
		default:
			return 0
		}
	}
	func stateForIndex(_ statePickerView: BGStatePickerView, index: Int) -> BGStateable {
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

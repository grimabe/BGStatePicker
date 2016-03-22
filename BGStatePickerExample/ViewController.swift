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
		statePickerView.reloadData()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

extension ViewController: BGStatePickerDatasource {
	func numberOfState() -> Int {
		return 2
	}
	func stateForIndex(index: Int) -> BGStateable {
		return states[index]
	}
}

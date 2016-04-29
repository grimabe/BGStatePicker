[![Build Status](https://travis-ci.org/grimabe/BGStatePicker.svg?branch=master)](https://travis-ci.org/grimabe/BGStatePicker)
[![Build Status](https://img.shields.io/cocoapods/v/BGStatePicker.svg)](http://cocoadocs.org/docsets/BGStatePicker/0.2.0/)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](http://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/grimabe/BGStatePicker/blob/master/LICENSE)
# BGStatePicker

BGStatePicker is a component that allows showing different states and selecting one.

<img src="resources/BGStatePicker.gif" alt="BGStatePicker demo" title="BGStatePicker demo" width="250px" />

## Usage

BGStatePicker implement is a UIControl that receive a datasource to show different states.

### Example code

```swift
import BGStatePicker

//....

let openState = BGStateable()
openState.stateText = "Open"
openState.stateBackgroundColor = .greenColor()

let closedState = BGStateable()
closedState.stateText = "Close"
closedState.stateBackgroundColor = .redColor()

let statusStates = [openState, closedState]

statePickerView.datasource = self
statePickerView.reloadData()

```

#### Datasource

```swift
extension ViewController: BGStatePickerDatasource {

	func numberOfState(statePickerView: BGStatePickerView) -> Int {
			return statusStates.count
	}
	func stateForIndex(statePickerView: BGStatePickerView, index: Int) -> BGStateable {
			return statusStates[index]
		}
	}
}
```
#### Get notified when the user pick a state

BGStatePicker inherits from UIControl and implements the **.ValueChanged** event.

```swift
//in viewDidLoad{
  //....

  statePickerView.addTarget(self, action: #selector(pickState(_:)), forControlEvents: [.ValueChanged])

  //...
}
...

func pickState(sender: BGStatePickerView) {
  if let state = sender.selectedValue { // BGStateable
    print("You pick state \(state.stateText)")
  }
}

```
## Installation

### Carthage
```ruby
github "grimabe/BGStatePicker" ~> 0.2.0
```

### CocoaPods
```ruby
pod "BGStatePicker", "~> 0.2.0"
```

## Author
Benjamin Grima  

## License
BGStatePicker is licensed under the [MIT License](http://opensource.org/licenses/mit-license.php).

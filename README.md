# SWIFT UI TESTS
Run XC UI Tests from JSON configuration files.

## Features
* Simplify XC UI test blocks
* Mix & match reusable configurations
* Check for UI elements with or w/o timeouts
* Replace textfield data

## Usage
To run a single test file:
```
        // Run test from a json file.
        // Result will be a tuple (success:Bool, errorMessage:String?)
        let runResult = execute(testFile: "filename_minus_json_suffix")

        // Assert against the results
        XCTAssert(runResult.success, runResult.errorMessage)

```

To run an aggregate of test files:
```
// Will aggregate launch args and run test specifications into a single
// run action. Will execute run actions in order assembled.
let result = execute(testFiles: ["demo_launch_args",
                                "demo_login",
                                "menu_items",
                                "settings_items"])
// Assert against the results
XCTAssert(runResult.success, runResult.errorMessage)

```

## JSON schema
The current testing schema requires 2 keys:
* launchArgs
* runActions

*launchArgs* Is a string array of launch arguments that can be used to configure a run.
*runActions* An array of dictionaries that will be converted to RunAction objects. Contains normalized data are used specify single UI test operations that are run in sequence.

Sample:
```
{
	"launchArgs":[
        "-DISABLE_TOUR",
        "-ENABLE_MOCK_DATA"
        ],
	"runActions":[
		{
			"action":"check",
			"actionTime":3.0,
			"actionNumber":0.0,
			"actionSecondaryNumber":0.0,
			"actionTargetName":null,
			"name":"Login",
			"type":"navigationBars",
		},
          {
          "action":"replace",
          "actionTime":3.0,
          "actionNumber":0.0,
          "actionSecondaryNumber":0.0,
          "actionTargetName":"stgHAXHIqa",
          "name":"Enter username",
          "type":"textFields",
          }
        ]
 }
```

## RunActions
| Key | Value Type | Description | Sample |
| --------------- | --------------- | --------------- | --------------- |
| action | string | The UI test action to take. Often dependent on the 'type' key. | "tap" |
| actionNumber  | double | General number that can be used to specify number of taps, duration of press, etc. | 1.0 |
| actionSecondaryNumber | double | General number that can be used to specify 2nd numeric arguments (ie number of fingers, delta Y, etc.) | 2.0 |
| actionTargetName  | Target string to use for a replace action or name of target element as part of a drag action. | "my_user_name" |
| actionTime | double | Time to execute an action. Can be 0 for instanteous actions like taps. | 0.0 |
| elements | | |
| name  | string | Name of the target element. Such as the title displayed for a view in a navigation bar.  | "Dashboard" |
| type  | string | Exact string representation of the target [XCUIElement.type](https://developer.apple.com/documentation/xctest/xcuielement.elementtype) to affect this action on. | "buttons" |


Supported XCUIElement types:

* buttons
* cells
* images (imageViews))
* navigationBars
* pickerWheels
* staticTexts
* tables
* textFields
* textViews
* toolBar.buttons
* windows


Available actions:

| Action value | Description | XCUIElement property/method | Notes |
| --------------- | --------------- | --------------- | --------------- |
| check | Verify that expected UI element is viewable. | .exists | Use 'actionTime' to set length of timeout. |
| tap | Tap element. | .tap() | |
| doubleTap  | Double tap element. | .doubleTap() | |
| twoFingerTap  | Two finger tap on element. | .twoFingerTap() | |
| tapWith  | Tap with specified number of taps and fingers. | .tap(withNumberOfTaps:numberOfTouches:| Use 'actionNumber' & 'actionSecondaryNumber' to set args. |
| press  | Press down on element with lenght of time.| .press(forDuration:)| Use 'actionNumber' set arg. |
| swipeUp | Swipe up from element. | .swipeUp() | |
| swipeDown | Swipe down from element. | .swipeDown() | |
| swipeLeft | Swipe left from element.| .swipeLeft() | |
| swipeRight | Swipe right from element. | .swipeRight() | |
| pause | Pauses UI test for time specified by `actionTime` value | - | |
| pinch | Pinch element. | .pinch(withScale:velocity:) | Use 'actionNumber' & 'actionSecondaryNumber' to set args. |
| rotate | Rotate element. | .rotate(: withVelocity:) | Use 'actionNumber' & 'actionSecondaryNumber' to set args. |
| replace  | Clears & replaces text. | - | Only textFields supported at this time. |


### Pause Action
`actionTime` and `type` values required.  Type can be any visible UI element, but `window`
recommended as it is always available. ActionTime is the number of seconds to pause.  This
block with a high actionTime value can be used at the end of a start up process to aide in
development by doing repeated actions for you (ie logging in then navigating to the part of
the app currently being worked on).
```
{
"action":"pause",
"actionTime":10.0,
"actionNumber":0,
"actionSecondaryNumber":0,
"actionTargetName":null,
"name":"",
"type":"windows"
}
```

### Table Cells
To target specific cells in a tableview, the identifier for the parent table needs to also be specified in the *actionTargetName* key. ie:
```
{
    "action":"tap",
    "actionTime":0,
    "actionNumber":0,
    "actionSecondaryNumber":0,
    "actionTargetName":"myTableId",
    "name":"cellNameId",
    "type":"cells"
}
```

## TODOs
* Lowercase action type strings to permit greater flexibility for handwritten JSON test files?
* Rename json key 'name' to 'identifier'?


## Change log

- 0.1
    * Sample test app added.
    * RunAction merge allows for merging of JSON files without requiring top-level keys
    * Targeting via element type index added.
    * Redundant exist check removed.
    * 'pause' action added.
    * Wait expectation replaced with XCTWaiter for test failure clarity.
    * Support for textViews added.
    * Extra check for missing elements added.
    * Action type 'staticTexts' added to conform to XCUIElement.type naming convention.
         'statics' still work.
    * Support for running multiple .json test files in one run.


//
//  JDUITestCase.swift
//  hfa
//
//  Created by Jason Koo on 11/15/17.
//  Copyright © 2017 jalakoo. All rights reserved.
//

import XCTest
import Foundation

extension XCTestCase {
    
    public func runUITestFrom(file filename: String) -> (success: Bool, errorMessage:String) {
        let testRun = uiTestRunFrom(filename: filename)
        return execute(testRun: testRun)
    }
    
    public func runUITestFrom(files filenames: [String]) -> (success: Bool, errorMessage: String) {
        guard let compositeRun = uiTestRunFrom(filenames: filenames) else {
            return (false, "No testruns found in files:\(filenames)")
        }
        return execute(testRun: compositeRun)
    }
    
    internal func uiTestRunFrom(filenames: [String]) -> UITestRun? {
        var compositeRun: UITestRun?
        for filename in filenames {
            let nextRun = uiTestRunFrom(filename: filename)
            compositeRun = UITestRun.merge(testRun: compositeRun,
                                             anotherTestRun: nextRun)
        }
        return compositeRun
    }
    
    internal func uiTestRunFrom(filename: String) -> UITestRun {
        let json = dictionaryFromBundleJSONFile(name: filename)
        let testRun = UITestRun(fromDictionary: json)
        return testRun
    }
    
    private func launchAppFrom(testRun: UITestRun) -> XCUIApplication! {
        let app = XCUIApplication()
        app.launchArguments += testRun.launchArgs
        app.launch()
        return app
    }
    
    private func execute(testRun: UITestRun) -> (success: Bool, errorMessage:String) {
        guard let app = launchAppFrom(testRun: testRun) else {
            return (false, "Problem launching app.")
        }
        guard let actions = testRun.runActions else {
            return (false, "No actions for test run.")
        }
        for action in actions {
            let result = execute(action,
                                 inApp: app)
            if let error = result.errorMessage {
                return (false, error)
            }
        }
        return (true, "")
    }
    
    private func execute(_ action: UITestAction,
                         inApp app: XCUIApplication) -> (success: Bool, errorMessage: String?) {
        
        guard let element = elementFrom(action,
                                        app: app) else {
                                            return (false, "Missing element: \(String(describing:action.name))")
        }
        
        if let app = element as? XCUIApplication {
            let action = UIApplicationTestAction.from(string:action.action)
            switch action {
            case .restart:
                app.terminate()
                app.activate()
            default:
                return (false, "Unknown command")
            }
            return (true, nil)
        }
        
        let elementAction = UIElementTestAction.from(string:action.action)
        
        switch elementAction {
        case .check:
            if let time = action.actionTime {
                if time > 0.0 {
                    // Use a wait expectation
                    let result = exists(element: element, afterTime: time)
                    if result != .completed {
                        let message = errorString(fromResult: result)
                        return (false, "Check action for Element:\(String(describing:element)):\(message)")
                    }
                    return (true, nil)
                }
            }
            return (element.exists, "Missing element from check action:\(String(describing:element))")
        case .tap:
            element.tap()
        case .doubleTap:
            element.doubleTap()
        case .twoFingerTap:
            element.twoFingerTap()
        case .tapWith:
            element.tap(withNumberOfTaps: Int(action.actionNumber),
                        numberOfTouches: Int(action.actionSecondaryNumber))
        case .press:
            element.press(forDuration: action.actionTime)
        case .pause:
            if let timeout = action.actionTime {
                let unfulfillableExpectation = expectation(description: "unfulfillable")
                let _ = XCTWaiter.wait(for: [unfulfillableExpectation], timeout: timeout)
                return (true, nil)
            }
            return (false, "No time assigned to the actionTime arg of a \"pause\" run action.")
        case .drag:
            // TODO:
            return (false, "Drag action not yet implemented")
        case .swipeUp:
            element.swipeUp()
        case .swipeDown:
            element.swipeDown()
        case .swipeLeft:
            element.swipeLeft()
        case .swipeRight:
            element.swipeRight()
        case .pinch:
            element.pinch(withScale: CGFloat(action.actionNumber),
                          velocity: CGFloat(action.actionSecondaryNumber))
        case .rotate:
            element.rotate(CGFloat(action.actionNumber),
                           withVelocity: CGFloat(action.actionSecondaryNumber))
        case .replace:
            if action.type == UITestType.textFields.rawValue ||
                action.type == UITestType.secureTextFields.rawValue {
                element.tap()
                clearTextField(element)
                element.typeText(action.actionTargetName)
            }
        default:
            // do nothing
            return (false, "Unknown command")
        }
        return (true, nil)
    }
    
    private func elementFrom(_ action: UITestAction,
                             app: XCUIApplication) -> XCUIElement? {
        
        let name = action.name!
        if name == "" {
            return self.elementByIndexFrom(action, app:app)
        }
        return self.elementByNameFrom(action, app:app)
    }
    
    private func elementByNameFrom(_ action: UITestAction,
                                   app: XCUIApplication) -> XCUIElement? {
        let name = action.name!
        let typeString = action.type!
        let type = UITestType.from(string:typeString)
        switch type {
        case .back:
            if app.buttons["back"].exists {
                return app.buttons["back"]
            }
            return app.navigationBars.buttons.element(boundBy: 0)
        case .buttons:
            return app.buttons[name]
        case .cells:
            if let target = action.actionTargetName {
                let table = app.tables[target]
                return table.cells.element(matching: .cell, identifier: name)
            }
            let table = app.tables.allElementsBoundByIndex[0]
            return table.cells.element(matching: .cell, identifier: name)
        case .images:
            return app.images[name]
        case .navigationBars:
            return app.navigationBars[name]
        case .pickerWheels:
            return app.pickerWheels[name]
        case .secureTextFields:
            return app.secureTextFields[name]
        case .statics:
            return app.staticTexts[name]
        case .staticTexts:
            return app.staticTexts[name]
        case .tables:
            return app.tables[name]
        case .textFields:
            return app.textFields[name]
        case .textViews:
            return app.textViews[name]
        case .toolBarButtons:
            return app.toolbars.buttons[name]
        case .windows:
            return app.windows[name]
        default:
            return nil
        }
    }
    
    private func elementByIndexFrom(_ action: UITestAction,
                                    app: XCUIApplication) -> XCUIElement? {
        
        let index = Int(action.actionNumber)
        let typeString = action.type!
        let type = UITestType.from(string:typeString)
        switch type {
        case .back:
            if app.buttons["back"].exists {
                return app.buttons["back"]
            }
            return app.navigationBars.buttons.allElementsBoundByIndex[index]
        case .buttons:
            return app.buttons.allElementsBoundByIndex[index]
        case .cells:
            // Parent table view marked by name
            if let target = action.actionTargetName {
                let table = app.tables[target]
                return table.cells.allElementsBoundByIndex[index]
            }
            // No parent table view name marked
            let table = app.tables.allElementsBoundByIndex[0]
            return table.cells.allElementsBoundByIndex[index]
        case .images:
            return app.images.allElementsBoundByIndex[index]
        case .navigationBars:
            return app.navigationBars.allElementsBoundByIndex[index]
        case .pickerWheels:
            return app.pickerWheels.allElementsBoundByIndex[index]
        case .secureTextFields:
            return app.secureTextFields.allElementsBoundByIndex[index]
        case .statics:
            return app.staticTexts.allElementsBoundByIndex[index]
        case .staticTexts:
            return app.staticTexts.allElementsBoundByIndex[index]
        case .tables:
            return app.tables.allElementsBoundByIndex[index]
        case .textFields:
            return app.textFields.allElementsBoundByIndex[index]
        case .textViews:
            return app.textViews.allElementsBoundByIndex[index]
        case .toolBarButtons:
            return app.toolbars.buttons.allElementsBoundByIndex[index]
        case .windows:
            return app.windows.allElementsBoundByIndex[index]
        default:
            return nil
        }
    }
    
    // MARK: Run Action Helpers
    
    private func clearTextField(_ textField: XCUIElement) {
        if let fieldValue = textField.value as? String {
            // If there's any content in the field, delete it
            var deleteString: String = ""
            for _ in fieldValue {
                deleteString += "\u{8}"
            }
            textField.typeText(deleteString)
        }
    }
    
    private func errorString(fromResult: XCTWaiter.Result) -> String {
        switch fromResult {
        case .completed:
            return "completed"
        case .timedOut:
            return "timedOut"
        case .incorrectOrder:
            return "incorrectOrder"
        case .invertedFulfillment:
            return "invertedFulfillment"
        case .interrupted:
            return "interrupted"
        }
    }
    
    private func exists(element: XCUIElement,
                        afterTime timeout: TimeInterval) -> XCTWaiter.Result {
        let startExpectation = expectationExistsFor(element)
        let result = XCTWaiter.wait(for: [startExpectation], timeout: timeout)
        return result
    }
    
    private func expectationExistsFor(_ element: XCUIElement) -> XCTestExpectation {
        let exists = NSPredicate(format: "exists == true")
        let result = self.expectation(for: exists,
                                      evaluatedWith: element,
                                      handler: nil)
        return result
    }
    
    private func replaceTextField(named name: String,
                                  withText text: String,
                                  inApp app: XCUIApplication) {
        let textField = app.textFields[name]
        textField.tap()
        clearTextField(textField)
        textField.typeText(text)
    }

}

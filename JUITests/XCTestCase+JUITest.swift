//
//  JDUITestCase.swift
//  hfa
//
//  Created by Jason Koo on 11/15/17.
//  Copyright © 2017 jalakoo. All rights reserved.
//

import XCTest
import Foundation

func clearTextField(_ textField: XCUIElement) {
    if let fieldValue = textField.value as? String {
        // If there's any content in the field, delete it
        var deleteString: String = ""
        for _ in fieldValue {
            deleteString += "\u{8}"
        }
        textField.typeText(deleteString)
    }
}

extension XCTestCase {
    
    func runJUITestFrom(file filename: String) -> (success: Bool, errorMessage:String) {
        let testRun = aTestRunFrom(filename: filename)
        return execute(testRun: testRun)
    }
    
    func runJUITestFrom(files filenames: [String]) -> (success: Bool, errorMessage: String) {
        guard let compositeRun = aTestRunFrom(filenames: filenames) else {
            return (false, "No testruns found in files:\(filenames)")
        }
        return execute(testRun: compositeRun)
    }
    
    func aTestRunFrom(filenames: [String]) -> JUITestRun? {
        
        var compositeRun: JUITestRun?
        for filename in filenames {
            let nextRun = aTestRunFrom(filename: filename)
            compositeRun = JUITestRun.merge(testRun: compositeRun,
                                             anotherTestRun: nextRun)
        }
        return compositeRun
    }
    
    func aTestRunFrom(filename: String) -> JUITestRun {
        let json = dictionaryFromJSONFile(name: filename)
        let testRun = JUITestRun(fromDictionary: json)
        return testRun
    }
    
    func dictionaryFromJSONFile(name: String) -> [String:Any] {
        
        let bundle = Bundle(for: type(of:self))
        
        guard let path = bundle.path(forResource: name, ofType: "json") else {
            assertionFailure("Target json file with name:\(name) not found.")
            return [:]
        }
        
        do {
            let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
            do {
                let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                guard let jsonDictionary = jsonResult as? [String:Any] else {
                    assertionFailure("Target json file with name:\(name) could not be converted to [String:Any].")
                    return [:]
                }
                return jsonDictionary
            } catch {
                // Could not convert JSON file to dictionary
                assertionFailure("Target json file with name:\(name) could not be converted to an NSDictionary. Check if file is valid JSON.")
                return [:]
            }
        } catch {
            // Could not open file at path as NSData
            assertionFailure("Target json file with name:\(name) could not be opened as NSData.")
            return [:]
        }
    }
    
    private func launchAppFrom(testRun: JUITestRun) -> XCUIApplication! {
        let app = XCUIApplication()
        app.launchArguments += testRun.launchArgs
        app.launch()
        return app
    }
    
    private func execute(testRun: JUITestRun) -> (success: Bool, errorMessage:String) {
        
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
    
    private func elementFrom(_ action: JUIRunAction,
                             app: XCUIApplication) -> XCUIElement? {
        
        let name = action.name!
        let type = JUITestType.from(string: action.type!)
        
        switch type {
        case .app:
            return app
        case .back:
            if app.buttons[JUITestType.back.rawValue].exists {
                return app.buttons[JUITestType.back.rawValue]
            }
            return app.navigationBars.buttons.element(boundBy: 0)
        case .buttons:
            return app.buttons[name]
        case .cells:
            var table: XCUIElement
            if let target = action.actionTargetName {
                table = app.tables[target]
            }
            else {
                table = app.tables.firstMatch
            }
            return table.cells.element(matching: .cell, identifier: name)
        case .images:
            return app.images[name]
        case .keyboards:
            return app.keyboards.buttons[name]
        case .navigationBars:
            return app.navigationBars[name]
        case .secureTextFields:
            return app.secureTextFields[name]
        case .statics:
            return app.staticTexts[name]
        case .tables:
            return app.tables[name]
        case .textFields:
            return app.textFields[name]
        case .alerts:
            return app.alerts[name]
        case .windows:
            return app.windows.element(boundBy: 0)
        default:
            return nil
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
    
    private func execute(_ action: JUIRunAction,
                         inApp app: XCUIApplication) -> (success: Bool, errorMessage: String?) {
        
        guard let element = elementFrom(action,
                                        app: app) else {
                return (false, "Missing element: \(String(describing:action.name))")
        }

        if let app = element as? XCUIApplication {
            let action = JUIApplicationTestAction.from(string:action.action)
            switch action {
            case .restart:
                app.terminate()
                app.activate()
            default:
                return (false, "Unknown command")
            }
            return (true, nil)
        }
        
        let elementAction = JUIElementTestAction.from(string:action.action)

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
            if action.type == JUITestType.textFields.rawValue ||
                action.type == JUITestType.secureTextFields.rawValue {
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
    
    func errorString(fromResult: XCTWaiter.Result) -> String {
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
}

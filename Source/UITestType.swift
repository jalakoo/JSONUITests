//
//  UITestType.swift
//  hfaUITests
//
//  Created by Jason Koo on 12/7/17.
//  Copyright © 2017 jalakoo. All rights reserved.
//

import Foundation

public enum UITestType: String {
    case unknown = "unknown"
    case alerts = "alerts"
    case app = "app"
    case back = "back"
    case buttons = "buttons"
    case cells = "cells"
    case images = "images"
    case keyboards = "keyboards"
    case navigationBars = "navigationBars"
    case pickerWheels = "pickerWheels"
    case statics = "statics"
    case staticTexts = "staticTexts"    // Same as statics
    case secureTextFields = "secureTextFields"
    case tables = "tables"
    case textFields = "textFields"
    case textViews = "textViews"
    case toolBarButtons = "toolBarButtons"
    case windows = "windows"
    
    public static func from(string: String) -> UITestType {
        if string == UITestType.alerts.rawValue { return .alerts }
        if string == UITestType.app.rawValue { return .app }
        if string == UITestType.back.rawValue { return .back }
        if string == UITestType.buttons.rawValue { return .buttons }
        if string == UITestType.cells.rawValue { return .cells }
        if string == UITestType.images.rawValue { return .images }
        if string == UITestType.keyboards.rawValue { return .keyboards }
        if string == UITestType.navigationBars.rawValue { return .navigationBars }
        if string == UITestType.pickerWheels.rawValue { return .pickerWheels }
        if string == UITestType.statics.rawValue { return .statics }
        if string == UITestType.staticTexts.rawValue { return .statics }
        if string == UITestType.secureTextFields.rawValue { return .secureTextFields }
        if string == UITestType.tables.rawValue { return .tables }
        if string == UITestType.textFields.rawValue { return .textFields }
        if string == UITestType.textViews.rawValue { return .textViews }
        if string == UITestType.toolBarButtons.rawValue { return .toolBarButtons }
        if string == UITestType.windows.rawValue { return .windows }
        return .unknown
    }
}

@objc open class UITestTypes: NSObject {
    @objc class func alerts() -> String { return UITestType.alerts.rawValue }
    @objc class func app() -> String { return UITestType.app.rawValue }
    @objc class func back() -> String { return UITestType.back.rawValue }
    @objc class func buttons() -> String { return UITestType.buttons.rawValue }
    @objc class func cells() -> String { return UITestType.cells.rawValue }
    @objc class func images() -> String { return UITestType.images.rawValue }
    @objc class func keyboards() -> String { return UITestType.keyboards.rawValue }
    @objc class func navigationBars() -> String { return UITestType.navigationBars.rawValue }
    @objc class func pickerWheels() -> String { return UITestType.pickerWheels.rawValue }
    @objc class func statics() -> String { return UITestType.statics.rawValue }
    @objc class func staticTexts() -> String { return UITestType.staticTexts.rawValue }
    @objc class func secureTextFields() -> String { return UITestType.secureTextFields.rawValue }
    @objc class func tables() -> String { return UITestType.tables.rawValue }
    @objc class func textFields() -> String { return UITestType.textFields.rawValue }
    @objc class func textViews() -> String { return UITestType.textViews.rawValue }
    @objc class func toolBarButtons() -> String { return UITestType.toolBarButtons.rawValue }
    @objc class func windows() -> String { return UITestType.windows.rawValue }
}

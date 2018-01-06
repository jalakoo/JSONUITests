//
//  JUITestType.swift
//  hfaUITests
//
//  Created by Jason Koo on 12/7/17.
//  Copyright © 2017 jalakoo. All rights reserved.
//

import Foundation

public enum JUITestType: String {
    case unknown = "unknown"
    case alerts = "alerts"
    case app = "app"
    case back = "back"
    case buttons = "buttons"
    case cells = "cells"
    case images = "images"
    case keyboards = "keyboards"
    case navigationBars = "navigationBars"
    case statics = "statics"
    case secureTextFields = "secureTextFields"
    case tables = "tables"
    case textFields = "textFields"
    case windows = "windows"
    
    public static func from(string: String) -> JUITestType {
        if string == JUITestType.alerts.rawValue { return .alerts }
        if string == JUITestType.app.rawValue { return .app }
        if string == JUITestType.back.rawValue { return .back }
        if string == JUITestType.buttons.rawValue { return .buttons }
        if string == JUITestType.cells.rawValue { return .cells }
        if string == JUITestType.images.rawValue { return .images }
        if string == JUITestType.keyboards.rawValue { return .keyboards }
        if string == JUITestType.navigationBars.rawValue { return .navigationBars }
        if string == JUITestType.statics.rawValue { return .statics }
        if string == JUITestType.secureTextFields.rawValue { return .secureTextFields }
        if string == JUITestType.tables.rawValue { return .tables }
        if string == JUITestType.textFields.rawValue { return .textFields }
        if string == JUITestType.windows.rawValue { return .windows }
        return .unknown
    }
}

@objc open class JUITestTypes: NSObject {
    @objc class func alerts() -> String { return JUITestType.alerts.rawValue }
    @objc class func app() -> String { return JUITestType.app.rawValue }
    @objc class func back() -> String { return JUITestType.back.rawValue }
    @objc class func buttons() -> String { return JUITestType.buttons.rawValue }
    @objc class func cells() -> String { return JUITestType.cells.rawValue }
    @objc class func images() -> String { return JUITestType.images.rawValue }
    @objc class func keyboards() -> String { return JUITestType.keyboards.rawValue }
    @objc class func navigationBars() -> String { return JUITestType.navigationBars.rawValue }
    @objc class func statics() -> String { return JUITestType.statics.rawValue }
    @objc class func secureTextFields() -> String { return JUITestType.secureTextFields.rawValue }
    @objc class func tables() -> String { return JUITestType.tables.rawValue }
    @objc class func textFields() -> String { return JUITestType.textFields.rawValue }
    @objc class func windows() -> String { return JUITestType.windows.rawValue }
}

//
//  JDUITestAction.swift
//
//  Created by Jason Koo on 12/29/17.
//  Copyright © 2017 jalakoo. All rights reserved.
//

import Foundation

public enum JUIElementTestAction: String {
    case unknown = "unknown"
    case check = "check"
    case tap = "tap"
    case doubleTap = "doubleTape"
    case twoFingerTap = "twoFingerTap"
    case tapWith = "tapWith"
    case press = "press"
    case drag = "drag"
    case swipeUp = "swipeUp"
    case swipeDown = "swipeDown"
    case swipeLeft = "swipeLeft"
    case swipeRight = "swipeRight"
    case pause = "pause"
    case pinch = "pinch"
    case rotate = "rotate"
    case replace = "replace"
    
    public static func from(string: String) -> JUIElementTestAction {
        if string == JUIElementTestAction.check.rawValue { return .check }
        if string == JUIElementTestAction.tap.rawValue { return .tap }
        if string == JUIElementTestAction.doubleTap.rawValue { return .doubleTap }
        if string == JUIElementTestAction.twoFingerTap.rawValue { return .twoFingerTap }
        if string == JUIElementTestAction.tapWith.rawValue { return .tapWith }
        if string == JUIElementTestAction.press.rawValue { return .press }
        if string == JUIElementTestAction.drag.rawValue { return .drag }
        if string == JUIElementTestAction.swipeUp.rawValue { return .swipeUp }
        if string == JUIElementTestAction.swipeDown.rawValue { return .swipeDown }
        if string == JUIElementTestAction.swipeLeft.rawValue { return .swipeLeft }
        if string == JUIElementTestAction.swipeRight.rawValue { return .swipeRight }
        if string == JUIElementTestAction.pause.rawValue { return .pause }
        if string == JUIElementTestAction.pinch.rawValue { return .pinch }
        if string == JUIElementTestAction.rotate.rawValue { return .rotate }
        if string == JUIElementTestAction.replace.rawValue { return .replace }

        return .unknown
    }
    
}

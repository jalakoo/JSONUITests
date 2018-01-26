//
//  JDUITestAction.swift
//
//  Created by Jason Koo on 12/29/17.
//  Copyright © 2017 jalakoo. All rights reserved.
//

import Foundation

public enum UIElementTestAction: String {
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
    
    public static func from(string: String) -> UIElementTestAction {
        if string == UIElementTestAction.check.rawValue { return .check }
        if string == UIElementTestAction.tap.rawValue { return .tap }
        if string == UIElementTestAction.doubleTap.rawValue { return .doubleTap }
        if string == UIElementTestAction.twoFingerTap.rawValue { return .twoFingerTap }
        if string == UIElementTestAction.tapWith.rawValue { return .tapWith }
        if string == UIElementTestAction.press.rawValue { return .press }
        if string == UIElementTestAction.drag.rawValue { return .drag }
        if string == UIElementTestAction.swipeUp.rawValue { return .swipeUp }
        if string == UIElementTestAction.swipeDown.rawValue { return .swipeDown }
        if string == UIElementTestAction.swipeLeft.rawValue { return .swipeLeft }
        if string == UIElementTestAction.swipeRight.rawValue { return .swipeRight }
        if string == UIElementTestAction.pause.rawValue { return .pause }
        if string == UIElementTestAction.pinch.rawValue { return .pinch }
        if string == UIElementTestAction.rotate.rawValue { return .rotate }
        if string == UIElementTestAction.replace.rawValue { return .replace }

        return .unknown
    }
    
}

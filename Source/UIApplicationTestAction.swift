//
//  UIApplicationTestAction.swift
//
//  Created by Jason Koo on 12/30/17.
//  Copyright © 2017 jalakoo. All rights reserved.
//

import Foundation

public enum UIApplicationTestAction: String {
    case unknown = "unknown"
    case restart = "restart"
    
    public static func from(string: String) -> UIApplicationTestAction {
        if string == UIApplicationTestAction.restart.rawValue { return .restart }
        return .unknown
    }
    
}

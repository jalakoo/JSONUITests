//
//  JUIApplicationTestAction.swift
//
//  Created by Jason Koo on 12/30/17.
//  Copyright © 2017 jalakoo. All rights reserved.
//

import Foundation

public enum JUIApplicationTestAction: String {
    case unknown = "unknown"
    case restart = "restart"
    
    public static func from(string: String) -> JUIApplicationTestAction {
        if string == JUIApplicationTestAction.restart.rawValue { return .restart }
        return .unknown
    }
    
}

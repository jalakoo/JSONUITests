//
//  JDUITestUtils.swift
//  hfa
//
//  Created by Jason Koo on 12/22/17.
//  Copyright © 2017 jalakoo. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    func dictionaryFromBundleJSONFile(name: String) -> [String:Any] {
        
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
                assertionFailure("Target json file with name:\(name) could not be converted to an NSDictionary.")
                return [:]
            }
        } catch {
            // Could not open file at path as NSData
            assertionFailure("Target json file with name:\(name) could not be opened as NSData.")
            return [:]
        }
    }
}

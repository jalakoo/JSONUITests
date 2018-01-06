//
//  JDUITesRun.swift
//  hfa
//
//  Created by Jason Koo on 11/15/17.
//  Copyright © 2017 jalakoo. All rights reserved.
//

import Foundation

class JUITestRun : NSObject, NSCoding{
    
    var launchArgs : [String]!
    var runActions : [JUIRunAction]!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        launchArgs = dictionary["launchArgs"] as? [String]
        runActions = [JUIRunAction]()
        if let runActionsArray = dictionary["runActions"] as? [[String:Any]]{
            for dic in runActionsArray{
                let value = JUIRunAction(fromDictionary: dic)
                runActions.append(value)
            }
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if launchArgs != nil{
            dictionary["launchArgs"] = launchArgs
        }
        if runActions != nil{
            var dictionaryElements = [[String:Any]]()
            for runActionsElement in runActions {
                dictionaryElements.append(runActionsElement.toDictionary())
            }
            dictionary["runActions"] = dictionaryElements
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        launchArgs = aDecoder.decodeObject(forKey: "launchArgs") as? [String]
        runActions = aDecoder.decodeObject(forKey :"runActions") as? [JUIRunAction]
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if launchArgs != nil{
            aCoder.encode(launchArgs, forKey: "launchArgs")
        }
        if runActions != nil{
            aCoder.encode(runActions, forKey: "runActions")
        }
        
    }
    
    @objc class func merge(testRun: JUITestRun?,
                           anotherTestRun: JUITestRun) -> JUITestRun {
        guard let resultRun = testRun else {
            return anotherTestRun
        }
        if resultRun.launchArgs == nil {
            resultRun.launchArgs = []
        }
        if let newLaunchArgs = anotherTestRun.launchArgs {
            resultRun.launchArgs.append(contentsOf: newLaunchArgs)
        }
        if resultRun.runActions == nil {
            resultRun.runActions = []
        }
        if let newRunActions = anotherTestRun.runActions {
            resultRun.runActions.append(contentsOf: newRunActions)
        }
        return resultRun
    }
    
}

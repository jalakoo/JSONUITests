//
//  JUIRunAction.swift
//  UIKitCatalog
//
//  Created by Jason Koo on 1/5/18.
//  Copyright © 2018 Apple. All rights reserved.
//

///
//    RunAction.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

enum JUIRunActionKey {
    static let action = "action"
    static let actionNumber = "actionNumber"
    static let actionSecondaryNumber = "actionSecondaryNumber"
    static let actionTargetName = "actionTargetName"
    static let actionTime = "actionTime"
    static let name = "identifier"
    static let type = "type"
}

class JUIRunAction : NSObject, NSCoding{
    
    var action : String!
    var actionNumber : Double!
    var actionSecondaryNumber : Double!
    var actionTargetName : String!
    var actionTime : Double!
    var name : String!
    var type : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        action = dictionary[JUIRunActionKey.action] as? String
        actionNumber = dictionary[JUIRunActionKey.actionNumber] as? Double
        actionSecondaryNumber = dictionary[JUIRunActionKey.actionSecondaryNumber] as? Double
        actionTargetName = dictionary[JUIRunActionKey.actionTargetName] as? String
        actionTime = dictionary[JUIRunActionKey.actionTime] as? Double
        name = dictionary[JUIRunActionKey.name] as? String
        type = dictionary[JUIRunActionKey.type] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if action != nil{
            dictionary[JUIRunActionKey.action] = action
        }
        if actionNumber != nil{
            dictionary[JUIRunActionKey.actionNumber] = actionNumber
        }
        if actionSecondaryNumber != nil{
            dictionary[JUIRunActionKey.actionSecondaryNumber] = actionSecondaryNumber
        }
        if actionTargetName != nil{
            dictionary[JUIRunActionKey.actionTargetName] = actionTargetName
        }
        if actionTime != nil{
            dictionary[JUIRunActionKey.actionTime] = actionTime
        }
        if name != nil{
            dictionary[JUIRunActionKey.name] = name
        }
        if type != nil{
            dictionary[JUIRunActionKey.type] = type
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        action = aDecoder.decodeObject(forKey: JUIRunActionKey.action) as? String
        actionNumber = aDecoder.decodeObject(forKey: JUIRunActionKey.actionNumber) as? Double
        actionSecondaryNumber = aDecoder.decodeObject(forKey: JUIRunActionKey.actionSecondaryNumber) as? Double
        actionTargetName = aDecoder.decodeObject(forKey: JUIRunActionKey.actionTargetName) as? String
        actionTime = aDecoder.decodeObject(forKey: JUIRunActionKey.actionTime) as? Double
        name = aDecoder.decodeObject(forKey: JUIRunActionKey.name) as? String
        type = aDecoder.decodeObject(forKey: JUIRunActionKey.type) as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if action != nil{
            aCoder.encode(action, forKey: JUIRunActionKey.action)
        }
        if actionNumber != nil{
            aCoder.encode(actionNumber, forKey: JUIRunActionKey.actionNumber)
        }
        if actionSecondaryNumber != nil{
            aCoder.encode(actionSecondaryNumber, forKey: JUIRunActionKey.actionSecondaryNumber)
        }
        if actionTargetName != nil{
            aCoder.encode(actionTargetName, forKey: JUIRunActionKey.actionTargetName)
        }
        if actionTime != nil{
            aCoder.encode(actionTime, forKey: JUIRunActionKey.actionTime)
        }
        if name != nil{
            aCoder.encode(name, forKey: JUIRunActionKey.name)
        }
        if type != nil{
            aCoder.encode(type, forKey: JUIRunActionKey.type)
        }
        
    }
    
}

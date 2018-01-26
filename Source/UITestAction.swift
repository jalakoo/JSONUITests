//
//  UITestAction.swift
//  UIKitCatalog
//
//  Created by Jason Koo on 1/5/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

enum UITestActionKey {
    static let action = "action"
    static let actionNumber = "actionNumber"
    static let actionSecondaryNumber = "actionSecondaryNumber"
    static let actionTargetName = "actionTargetName"
    static let actionTime = "actionTime"
    static let elements = "elements"
    static let name = "identifier"
    static let type = "type"
}

class UITestAction : NSObject, NSCoding{
    
    var action : String!
    var actionNumber : Double!
    var actionSecondaryNumber : Double!
    var actionTargetName : String!
    var actionTime : Double!
    var elements: [String]?
    var name : String!
    var type : String!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        action = dictionary[UITestActionKey.action] as? String
        actionNumber = dictionary[UITestActionKey.actionNumber] as? Double
        actionSecondaryNumber = dictionary[UITestActionKey.actionSecondaryNumber] as? Double
        actionTargetName = dictionary[UITestActionKey.actionTargetName] as? String
        actionTime = dictionary[UITestActionKey.actionTime] as? Double
        elements = dictionary[UITestActionKey.elements] as? [String]
        name = dictionary[UITestActionKey.name] as? String
        type = dictionary[UITestActionKey.type] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if action != nil{
            dictionary[UITestActionKey.action] = action
        }
        if actionNumber != nil{
            dictionary[UITestActionKey.actionNumber] = actionNumber
        }
        if actionSecondaryNumber != nil{
            dictionary[UITestActionKey.actionSecondaryNumber] = actionSecondaryNumber
        }
        if actionTargetName != nil{
            dictionary[UITestActionKey.actionTargetName] = actionTargetName
        }
        if actionTime != nil{
            dictionary[UITestActionKey.actionTime] = actionTime
        }
        if let e = elements {
            dictionary[UITestActionKey.elements] = e
        }
        if name != nil{
            dictionary[UITestActionKey.name] = name
        }
        if type != nil{
            dictionary[UITestActionKey.type] = type
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        action = aDecoder.decodeObject(forKey: UITestActionKey.action) as? String
        actionNumber = aDecoder.decodeObject(forKey: UITestActionKey.actionNumber) as? Double
        actionSecondaryNumber = aDecoder.decodeObject(forKey: UITestActionKey.actionSecondaryNumber) as? Double
        actionTargetName = aDecoder.decodeObject(forKey: UITestActionKey.actionTargetName) as? String
        actionTime = aDecoder.decodeObject(forKey: UITestActionKey.actionTime) as? Double
        elements = aDecoder.decodeObject(forKey: UITestActionKey.elements) as? [String]
        name = aDecoder.decodeObject(forKey: UITestActionKey.name) as? String
        type = aDecoder.decodeObject(forKey: UITestActionKey.type) as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if action != nil{
            aCoder.encode(action, forKey: UITestActionKey.action)
        }
        if actionNumber != nil{
            aCoder.encode(actionNumber, forKey: UITestActionKey.actionNumber)
        }
        if actionSecondaryNumber != nil{
            aCoder.encode(actionSecondaryNumber, forKey: UITestActionKey.actionSecondaryNumber)
        }
        if actionTargetName != nil{
            aCoder.encode(actionTargetName, forKey: UITestActionKey.actionTargetName)
        }
        if actionTime != nil{
            aCoder.encode(actionTime, forKey: UITestActionKey.actionTime)
        }
        if let e = elements {
            aCoder.encode(e, forKey: UITestActionKey.elements)
        }
        if name != nil{
            aCoder.encode(name, forKey: UITestActionKey.name)
        }
        if type != nil{
            aCoder.encode(type, forKey: UITestActionKey.type)
        }
        
    }
    
}

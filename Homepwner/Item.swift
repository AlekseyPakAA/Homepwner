//
//  Item.swift
//  Homepwner
//
//  Created by admin on 16.03.17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {
    
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    var dateCreted: Date
    var id = NSUUID().uuidString
    
    init(name: String, serialNumber:String?, valueInDollars:Int) {
        self.name = name
        self.serialNumber = serialNumber
        self.valueInDollars = valueInDollars
        self.dateCreted = Date()
    }
    
    convenience init(random: Bool = false) {
        if random {
            let adjectives = ["Fluffy", "Rusty", "Shiny"]
            let nouns = ["Bear", "Spok", "Mac"]
        
            var index = arc4random_uniform(UInt32(adjectives.count))
            let radjective = adjectives[Int(index)]
        
            index = arc4random_uniform(UInt32(nouns.count))
            let rnoun = nouns[Int(index)]
        
            let rname = "\(radjective) \(rnoun)"
            let rvalue = Int(arc4random_uniform(UInt32(99))) + 1
            let rserialNumber = NSUUID().uuidString.components(separatedBy: "-").first
            self.init(name: rname, serialNumber: rserialNumber, valueInDollars: rvalue)
        } else {
            self.init(name: "", serialNumber: nil, valueInDollars: 0)
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name          , forKey: "name")
        aCoder.encode(valueInDollars, forKey: "valueInDollars")
        aCoder.encode(serialNumber  , forKey: "serialNumber")
        aCoder.encode(dateCreted    , forKey: "dateCreted")
        aCoder.encode(id            , forKey: "id")
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        dateCreted = aDecoder.decodeObject(forKey: "dateCreted") as! Date
        id = aDecoder.decodeObject(forKey: "id") as! String
        serialNumber = aDecoder.decodeObject(forKey: "serialNumber") as! String?
        valueInDollars = aDecoder.decodeInteger(forKey: "valueInDollars")
        
        super.init()
    }
}

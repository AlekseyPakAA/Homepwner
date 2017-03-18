//
//  Item.swift
//  Homepwner
//
//  Created by admin on 16.03.17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class Item: NSObject {
    
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    let dateCreted: NSDate
    
    init(name: String, serialNumber:String?, valueInDollars:Int) {
        self.name = name
        self.serialNumber = serialNumber
        self.valueInDollars = valueInDollars
        self.dateCreted = NSDate()
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
            let rvalue = Int(arc4random_uniform(UInt32(100)))
            let rserialNumber = NSUUID().uuidString
        
            self.init(name: rname, serialNumber: rserialNumber, valueInDollars: rvalue)
        } else {
            self.init(name: "", serialNumber: nil, valueInDollars: 0)
        }
    }
}

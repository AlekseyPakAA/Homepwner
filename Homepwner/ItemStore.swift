//
//  ItemStore.swift
//  Homepwner
//
//  Created by admin on 16.03.17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class ItemStore {
    
    var items = [Item]()
    
    func createItem() -> Item {
        let item = Item(random: true)
        items.append(item)
        return item
    }
    
    func moveItem(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        let item = items[fromIndex]
        items.remove(at: fromIndex)
        items.insert(item, at: toIndex)
    }
    
}

//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by admin on 16.03.17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class ItemsViewController: UITableViewController {
    
    var itemsStore: ItemStore!
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsStore.items.count + 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell!
        
        if indexPath.row == itemsStore.items.count {
            cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellFooter", for: indexPath)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            
            let item = itemsStore.items[indexPath.row]
            cell.textLabel?.text = item.name;
            cell.detailTextLabel?.text = "$\(item.valueInDollars)";
        }
        
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == itemsStore.items.count {
            return 44
        } else {
            return 60
        }
    }
    
    override func viewDidLoad() {
        let paddingTop = UIApplication.shared.statusBarFrame.height;
        
        let inset = UIEdgeInsets(top: paddingTop, left: 0, bottom: 0, right: 0)
        
        tableView.contentInset = inset
        tableView.scrollIndicatorInsets = inset
    }
    
}

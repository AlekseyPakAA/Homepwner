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
   
    @IBAction func addItem (sender: UIButton) {
        let item = itemsStore.createItem();
        
        if let index = itemsStore.items.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func editingMode (sender: UIButton) {
        if isEditing {
            sender.setTitle("Edit", for: .normal)
            setEditing(false, animated: true)
        } else {
            sender.setTitle("Done", for: .normal)
            setEditing(true, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsStore.items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        let item = itemsStore.items[indexPath.row]
        cell.textLabel?.text = item.name;
        cell.detailTextLabel?.text = "$\(item.valueInDollars)";
        
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle  == .delete {
            let item = itemsStore.items[indexPath.row]
            
            let title = "Delete \(item.name)"
            let message = "Are you sure you want to delete this item?"
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: {_ in
                self.itemsStore.items.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            alertController.addAction(deleteAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        let paddingTop = UIApplication.shared.statusBarFrame.height;
        
        let inset = UIEdgeInsets(top: paddingTop, left: 0, bottom: 0, right: 0)
        
        tableView.contentInset = inset
        tableView.scrollIndicatorInsets = inset
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        itemsStore.moveItem(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }
    
}

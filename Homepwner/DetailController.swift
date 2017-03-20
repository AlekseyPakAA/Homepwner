//
//  DetailController.swift
//  Homepwner
//
//  Created by admin on 20.03.17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class DetailController: UIViewController {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
   
    var item: Item!
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialField.text = item.serialNumber
        
        valueField.text = numberFormatter.string(from: NSNumber.init(value: item.valueInDollars))
        dateLabel.text  = dateFormatter.string(from: item.dateCreted)
    }
}

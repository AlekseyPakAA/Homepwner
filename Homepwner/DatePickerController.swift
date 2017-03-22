//
//  DatePickerController.swift
//  Homepwner
//
//  Created by admin on 22.03.17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class DatePickerController: UIViewController {
    
    var item: Item!
    @IBOutlet var datePicker: UIDatePicker!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.title = "Change date"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        datePicker.date = item.dateCreted
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        item.dateCreted = datePicker.date
    }
}

	//
//  MYTextLabel.swift
//  Homepwner
//
//  Created by admin on 22.03.17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class MYTextField: UITextField {
    
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        
        self.borderStyle = .roundedRect
        
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
    
        self.borderStyle = .none
        
        return true
    }
    
}

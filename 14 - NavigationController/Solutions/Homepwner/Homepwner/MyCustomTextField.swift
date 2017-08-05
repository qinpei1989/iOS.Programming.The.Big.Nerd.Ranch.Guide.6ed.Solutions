//
//  MyCustomTextField.swift
//  Homepwner
//
//  Created by Pei Qin on 08/05/2017.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

/*
 * Silver Challenge: A Custom UITextField
 */

import UIKit

class MyCustomTextField: UITextField {

    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        
        self.borderStyle = .bezel
        self.layer.borderWidth = 2.0
        
        return true
    }

    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        
        self.borderStyle = .roundedRect
        self.layer.borderWidth = 0.0
        
        return true
    }
}

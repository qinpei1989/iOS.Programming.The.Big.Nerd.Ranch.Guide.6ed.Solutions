//
//  DateViewController.swift
//  Homepwner
//
//  Created by Pei Qin on 08/05/2017.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

/*
 * Gold Challenge: Pushing More View Controllers
 */

import UIKit

class DateViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var item: Item! {
        didSet {
            navigationItem.title = dateFormatter.string(from: item.dateCreated)
        }
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        datePicker.date = item.dateCreated
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        item.dateCreated = datePicker.date
    }

}

//
//  Copyright © 2015 Big Nerd Ranch
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.adjustsFontForContentSizeCategory = true
        serialNumberLabel.adjustsFontForContentSizeCategory = true
        valueLabel.adjustsFontForContentSizeCategory = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateValueLabelTextColor()
    }
    
    func updateValueLabelTextColor() {
        if let labelText = valueLabel.text {
            let startIndex = labelText.index(labelText.startIndex, offsetBy: 1)
            if let dollar = Double(labelText.substring(from: startIndex)) {
                if dollar < 50 {
                    valueLabel.textColor = UIColor.green
                } else {
                    valueLabel.textColor = UIColor.red
                }
            }
        }
    }
}

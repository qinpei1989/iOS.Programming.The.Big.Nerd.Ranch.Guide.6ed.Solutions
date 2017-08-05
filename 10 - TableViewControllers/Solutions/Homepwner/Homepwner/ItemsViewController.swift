//
//  Copyright © 2015 Big Nerd Ranch
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the height of the status bar
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "Apple"))
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return itemStore.expensiveItems.count
        } else {
            return itemStore.cheapItems.count + 1
        }
    }
    
    /*
     * Silver Challenge: Constant Rows
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an instance of UITableViewCell, with default appearance
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.backgroundColor = UIColor.clear
        
        /* The last row of the last section should display "No more items!" */
        if indexPath.section == 1 && indexPath.row == itemStore.cheapItems.count {
            cell.textLabel?.text = "No more items!"
            cell.detailTextLabel?.text = ""
        } else {
            let item: Item
            
            if indexPath.section == 0 {
                item = itemStore.expensiveItems[indexPath.row]
            } else {
                item = itemStore.cheapItems[indexPath.row]
            }
            
            cell.textLabel?.text = item.name
            cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
            cell.detailTextLabel?.text = "$\(item.valueInDollars)"
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 20)
        }
        
        return cell
    }
    
    /*
     * Bronze Challenge: Sections
     */
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    /*
     * Gold Challenge: Customizing the Table
     *
     * If tableView(_:titleForHeaderInSection:) is used, headers will block the background image
     */
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        let textLabel = UILabel(frame: CGRect(x: 20, y: 0, width: tableView.frame.width - 50, height: 30))
        
        if section == 0 {
            textLabel.text = "> $50"
        } else {
            textLabel.text = "<= $50"
        }
        
        headerView.addSubview(textLabel)
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == itemStore.cheapItems.count {
            return 44
        } else {
            return 60
        }
    }
}

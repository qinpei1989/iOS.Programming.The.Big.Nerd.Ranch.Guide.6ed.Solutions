//
//  Copyright © 2015 Big Nerd Ranch
//


/*
 * Bronze Challenge: Sections
 */
import Foundation

class ItemStore {
    /* Split the original allItems array into two according to valueInDollars value */
    var expensiveItems: [Item] = []
    var cheapItems: [Item] = []
    
    init() {
        for _ in 0..<5 {
            createItem()
        }
    }
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        
        if newItem.valueInDollars > 50 {
            expensiveItems.append(newItem)
        } else {
            cheapItems.append(newItem)
        }

        return newItem
    }
    
}

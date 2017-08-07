//
//  Copyright © 2015 Big Nerd Ranch
//

import UIKit

class PhotoInfoViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var photo: Photo! {
        didSet {
            navigationItem.title = photo.title
        }
    }
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         * Bronze Challenge: Photo View Count
         *
         * Update view count only when image is successfully downloaded
         */
        store.fetchImage(for: photo, completion: { (result) -> Void in
            switch result {
            case let .success(image):
                self.photo.viewCount += 1
                self.store.saveContext()
                OperationQueue.main.addOperation {
                    self.imageView.image = image
                    self.label.text = "View Count: \(self.photo.viewCount)"
                }
            case let .failure(error):
                print("Error fetching image for photo: \(error)")
            }
        })
    }
}

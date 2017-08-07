//
//  Copyright © 2015 Big Nerd Ranch
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchPhotos(for: FlickrAPI.interestingPhotosURL)
    }
    
    func updateImageView(for photo: Photo) {
        self.store.fetchImage(for: photo) {
            (imageResult) -> Void in
            switch imageResult {
            case let .success(image):
                OperationQueue.main.addOperation {
                    self.imageView.image = image
                }
            case let .failure(error):
                print("Error downloading image: \(error)")
            }
        }
    }
    
    func fetchPhotos(for url: URL) {
        store.fetchPhotos(photosURL: url) {
            (photosResult) in
            
            switch photosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) photos.")
                if let firstPhoto = photos.first {
                    self.updateImageView(for: firstPhoto)
                }
            case let .failure(error):
                print("Error fetching recent photos: \(error)")
            }

        }
    }
    
    @IBAction func photoTypeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            fetchPhotos(for: FlickrAPI.interestingPhotosURL)
        default:
            fetchPhotos(for: FlickrAPI.recentPhotosURL)
        }
    }
}

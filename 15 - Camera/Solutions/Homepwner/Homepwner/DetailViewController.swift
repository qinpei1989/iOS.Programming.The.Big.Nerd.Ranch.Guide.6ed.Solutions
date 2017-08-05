//
//  Copyright © 2015 Big Nerd Ranch
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var deleteImageButton: UIButton!
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    var imageStore: ImageStore!
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    /*
     * Bronze Challenge: Editing an Image
     *
     * 1. imagePicker.allowsEditing = true
     * 2. info[UIImagePickerControllerEditedImage] is a UIImage that user can edit
     */
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        
        let imagePicker = UIImagePickerController()
        
        // If the device has a camera, take a picture, otherwise,
        // just pick from photo library
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        // Place image picker on the screen
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String: Any]) {
            
            // Get picked image from info dictionary
            let image = info[UIImagePickerControllerEditedImage] as! UIImage
            
            // Store the image in the ImageStore for the item's key
            imageStore.setImage(image, forKey: item.itemKey)
            
            // Put that image onto the screen in our image view
            imageView.image = image
            
            // Take image picker off the screen -
            // you must call this dismiss method
            dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
        deleteImageButton.alpha = 0.0
        
        // Get the item key
        let key = item.itemKey
        
        // If there is an associated image with the item ...
        if let imageToDisplay = imageStore.image(forKey: key) {
            // ... display it on the image view
            imageView.image = imageToDisplay
            deleteImageButton.alpha = 1.0
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Clear first responder
        view.endEditing(true)
        
        // "Save" changes to item
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        
        if let valueText = valueField.text,
            let value = numberFormatter.number(from: valueText) {
                item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /*
     * Silver Challenge: Removing an Image
     *
     * Add a new button, then set its alpha to 1.0 when an image is picked and set it to 0.0
     * when there's no image
     */
    @IBAction func deleteImageButtonTapped(_ sender: UIButton) {
        let title = "Delete this image?"
        let message = "Are you sure you want to delete this image?"
        
        let ac = UIAlertController(title: title,
                                   message: message,
                                   preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: "Delete",
                                         style: .destructive,
                                         handler: { (action) -> Void in
                                            self.imageView.image = nil
                                            self.deleteImageButton.alpha = 0.0
        })
        ac.addAction(deleteAction)
        present(ac, animated: true, completion: nil)
    }
}

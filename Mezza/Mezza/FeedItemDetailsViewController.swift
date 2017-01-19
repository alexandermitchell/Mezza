//
//  FeedItemDetailsViewController.swift
//  Mezza
//
//  Created by Paul Jurczyk on 1/18/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit

class FeedItemDetailsViewController: UIViewController {
    
    // MARK: Image Outlets --------------------------------------------------
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var imageView1: UIImageView!
    
    @IBOutlet weak var imageView2: UIImageView!
    
    @IBOutlet weak var imageView3: UIImageView!
    
    @IBOutlet weak var imageView4: UIImageView!
    
    @IBOutlet weak var imageView5: UIImageView!
    
    // MARK: IBActions -----------------------------------------------------
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToMain", sender: self)
    }
    
    // MARK: IBACtions -> Image Taps
    
    
    
    // MARK: Local variables ------------------------------------------------
    
    var selectedItem: Product?
    
    
    func putImagesInArray(closure: @escaping ([UIImage])->()) {
        var imagesArray = [UIImage]()
        let imageURLsArray = selectedItem!.images
        var newImage = UIImage()
        let dispatchGroup = DispatchGroup()
        for imageURL in imageURLsArray {
            dispatchGroup.enter()
            DataModel.shared.fetchImage(stringURL: imageURL, completionHandler: { image in
                newImage = image!
               imagesArray.append(newImage)
                dispatchGroup.leave()
            })
            
        }
        dispatchGroup.notify(queue: .main) {
            closure(imagesArray)
        }
    }
    
    func setImageViews(array: [UIImage]) {
        let imagesCount = array.count
        
        if imagesCount > 0 {
            mainImageView.image = array[0]
            imageView1.image = array[0]
        }
        if imagesCount > 1 { imageView2.image = array[1] }
        if imagesCount > 2 { imageView3.image = array[2] }
        if imagesCount > 3 { imageView4.image = array[3] }
        if imagesCount > 4 { imageView5.image = array[4] }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        putImagesInArray { imagesArray in
            self.setImageViews(array: imagesArray)

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "goToCheckout") {
            let checkoutVC = segue.destination as! ProductCheckoutViewController
            checkoutVC.checkoutItem = selectedItem
        }
    }
    
}

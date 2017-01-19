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
    
    // MARK: Local variables ------------------------------------------------
    
    var selectedItem: Product?
    var imagesArray = [UIImage]()
    
    func putImagesInArray() {
        let imageURLsArray = selectedItem!.images
        var newImage = UIImage()
        for imageURL in imageURLsArray {
            
            DataModel.shared.fetchImage(stringURL: imageURL, completionHandler: { image in
                newImage = image!
            })
            self.imagesArray.append(newImage)
        }
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        putImagesInArray()
        let imagesCount = imagesArray.count
        let lastImageInArray = imagesCount - 1
        imageView1.image = imagesArray[0]
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

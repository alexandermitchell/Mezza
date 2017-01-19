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
//            self.imageView1.image = imagesArray[0]
//            self.mainImageView.image = imagesArray[0]
//            self.imageView2.image = imagesArray[1]
//            self.imageView3.image = imagesArray[2]
//            self.imageView4.image = imagesArray[3]
//            self.imageView5.image = imagesArray[4]
        }
        
        
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

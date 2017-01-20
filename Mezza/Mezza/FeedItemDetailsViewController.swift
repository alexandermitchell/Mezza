//
//  FeedItemDetailsViewController.swift
//  Mezza
//
//  Created by Paul Jurczyk on 1/18/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit

class FeedItemDetailsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: Image Outlets --------------------------------------------------
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var imageView1: UIImageView!
    
    @IBOutlet weak var imageView2: UIImageView!
    
    @IBOutlet weak var imageView3: UIImageView!
    
    @IBOutlet weak var imageView4: UIImageView!
    
    @IBOutlet weak var imageView5: UIImageView!
    
    // MARK: Remaining Outlets ---------------------------------------------
    
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    @IBOutlet weak var itemSizesLabel: UILabel!
    // MARK: IBActions -----------------------------------------------------
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToMain", sender: self)
    }
    
    // MARK: IBACtions -> Image Taps
    
    
    
    // MARK: Local variables ------------------------------------------------
    
    var selectedItem: Product?
    var currentSeller: User?
    var sizeUIPicker: UIPickerView?
    var sizesArray = [String]()
    
    // MARK: UIPicker Funcs ---------------------------------------------------------------
    
    // data method to return the numbe of columns in the picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // data method to return the number of rows shown in the picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sizesArray.count
    }
    // delegate method to return the value shown in the picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sizesArray[row]
    }
    
    // delegate method called when the row was selected.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        itemSizesLabel.text = sizesArray[row]
    }
    
    
    func showSizePicker() {
        // set up picker view
        
        sizeUIPicker = UIPickerView()
        sizeUIPicker?.frame = CGRect(x: 0, y: self.view.layer.bounds.width, width: self.view.layer.bounds.height, height: 280.0)
        sizeUIPicker?.delegate = self
        sizeUIPicker?.dataSource = self
        self.view.addSubview(sizeUIPicker!)
    }
    
    // put all the product sizes into an array
    
    func createSizesArray() {
        let sizesDict = selectedItem?.sizes
        for size in sizesDict! {
            let sizeString = size.name
            sizesArray.append(sizeString)
        }
    }
    
    // MARK: VC Funcs ---------------------------------------------------------------------
    
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
    
    func changeMainImage1() {
        mainImageView.image = imageView1.image
    }
    func changeMainImage2() {
       mainImageView.image = imageView2.image
    }
    func changeMainImage3() {
        mainImageView.image = imageView3.image
    }
    func changeMainImage4() {
        mainImageView.image = imageView4.image
    }
    func changeMainImage5() {
        mainImageView.image = imageView5.image
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSizesArray()
        // fetch the current seller
        let sellerUID = selectedItem!.sellerUID
        DataModel.shared.fetchUser(UID: sellerUID) { seller in
            self.artistNameLabel.text = seller.name
        }
        
        
        // setting up tap gesture recognizer for size label
        
        itemSizesLabel.isUserInteractionEnabled = true
        itemSizesLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showSizePicker)))
        
        // setting up tap gesture recognizers for images
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(changeMainImage1))
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(changeMainImage2))
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(changeMainImage3))
        let tapGestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(changeMainImage4))
        let tapGestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(changeMainImage5))
        imageView1.isUserInteractionEnabled = true
        imageView2.isUserInteractionEnabled = true
        imageView3.isUserInteractionEnabled = true
        imageView4.isUserInteractionEnabled = true
        imageView5.isUserInteractionEnabled = true
        imageView1.addGestureRecognizer(tapGestureRecognizer1)
        imageView2.addGestureRecognizer(tapGestureRecognizer2)
        imageView3.addGestureRecognizer(tapGestureRecognizer3)
        imageView4.addGestureRecognizer(tapGestureRecognizer4)
        imageView5.addGestureRecognizer(tapGestureRecognizer5)
        putImagesInArray { imagesArray in
            self.setImageViews(array: imagesArray)
        // set rest of page info
            self.productTitleLabel.text = self.selectedItem?.title
            
        }
    }
    
    @IBAction func proceedToCheckout(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToCheckout", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "goToCheckout") {
            
            let checkoutVC = segue.destination as! ProductCheckoutViewController
            checkoutVC.checkoutItem = selectedItem
            
        }
    }
    
}

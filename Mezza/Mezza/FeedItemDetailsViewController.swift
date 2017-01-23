//
//  FeedItemDetailsViewController.swift
//  Mezza
//
//  Created by Paul Jurczyk on 1/18/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//
import UIKit
protocol PopUpDelegate: class {
    func sizeSelected(size: String)
}
class FeedItemDetailsViewController: UIViewController, PopUpDelegate {
    
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
    
    @IBOutlet weak var itemDescriptionTextView: UITextView!
   
    @IBOutlet weak var editButton: UIButton!
    
    // MARK: IBActions -----------------------------------------------------
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToMain", sender: self)
    }
    @IBAction func editButtonClicked(_ sender: UIButton) {
        
        performSegue(withIdentifier: "editItemSegue", sender: self)
    }
    
    // PopUp Protocol Func -------------------------------------------------
    
    func sizeSelected(size: String) {
        itemSizesLabel.text = size
        selectedSize = size
        let sizesArray = selectedItem?.sizes
        for sizeProperty in sizesArray! {
            let newSize = sizeProperty
            if newSize.name == size {
                let thisPrice = newSize.price
                selectedPrice = thisPrice
                itemPriceLabel.text = "$\(thisPrice)"
            }
        }
    }
    
    // MARK: Local variables ------------------------------------------------
    
    var selectedItem: Product?
    var currentSeller: User?
    var sizesArray = [String]()
    var selectedSize: String?
    var selectedPrice: String?
    
    
    
    func showSizePickerPopUp() {
        // set up popup
        
        let popOverVC = UIStoryboard(name: "HomeFeedStoryboard", bundle: nil).instantiateViewController(withIdentifier:"SizePopUpID") as! SizePopUpViewController
        popOverVC.delegate = self
        popOverVC.sizesArray = sizesArray
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
        
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
    
    @IBAction func unwindToDetail(segue: UIStoryboardSegue) {
        
    }
    
    func putImagesInArray(closure: @escaping ([UIImage])->()) {
        var imagesArray = [UIImage]()
        let imageURLsArray = selectedItem!.images
        var newImage = UIImage()
        let dispatchGroup = DispatchGroup()
        for imageURL in imageURLsArray {
            if !(imageURL == "") {
                dispatchGroup.enter()
                DataModel.shared.fetchImage(stringURL: imageURL, completionHandler: { image in
                    newImage = image!
                    imagesArray.append(newImage)
                    dispatchGroup.leave()
                })
            }
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
        if DataModel.shared.loggedInUser?.type.rawValue == "buyer" {
            editButton.isHidden = true
        }
        
        // designing the size dropdown
        let newColor = UIColor.lightGray.cgColor
        itemSizesLabel.layer.borderColor = newColor
        itemSizesLabel.layer.borderWidth = 2
        
        createSizesArray()
        // fetch the current seller
        let sellerUID = selectedItem!.sellerUID
        DataModel.shared.fetchUser(UID: sellerUID) { seller in
            self.artistNameLabel.text = seller.name
        }
        
        
        // setting up tap gesture recognizer for size label
        
        itemSizesLabel.isUserInteractionEnabled = true
        itemSizesLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showSizePickerPopUp)))
        
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
            self.itemDescriptionTextView.text = self.selectedItem?.description
        }
    }
    
    @IBAction func proceedToCheckout(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToCheckout", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "goToCheckout") {
            
            let checkoutVC = segue.destination as! ProductCheckoutViewController
            checkoutVC.checkoutItem = selectedItem
            checkoutVC.checkoutItemSize = selectedSize
            checkoutVC.checkoutItemPrice = selectedPrice
            
        }

            if (segue.identifier == "editItemSegue") {
                let detailsViewController = segue.destination as! ProductUploadViewController
                detailsViewController.selectedProduct = selectedItem
            }
        
        
    }
    
}

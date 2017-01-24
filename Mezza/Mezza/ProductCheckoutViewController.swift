//
//  ProductCheckoutViewController.swift
//  Mezza
//
//  Created by Alex Mitchell on 2017-01-19.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit

class ProductCheckoutViewController: UIViewController {
    
    // MARK: IBOutlets --------------------------------------------------
    
    @IBOutlet weak var imageOutlet: UIImageView!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var titleOutlet: UILabel!
 
    @IBOutlet weak var sizeLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var orderBtn: UIButton!
    
    @IBOutlet weak var tintView: UIView!
    
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    
    
    
    
    // MARK: Local Variables --------------------------------------------------
    
    var checkoutItem: Product?
    var seller: User?
    var checkoutItemSize: String?
    var checkoutItemPrice: String?
    var currentDate = Date()
    var checkoutImage = UIImage()
    
    
    
    // MARK: IBActions -----------------------------------------------------
    
    @IBAction func cancelOrder(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToDetail", sender: self)
    }
    
    @IBAction func makeOrder(_ sender: UIButton) {
        
        DataModel.shared.createOrder(buyerUID: (DataModel.shared.loggedInUser?.uid)!, price: checkoutItemPrice!, productUID: (checkoutItem?.uid)!, seller: (seller?.uid)!, size: checkoutItemSize!, status: "pending", timestamp: String(currentDate.timeIntervalSince1970))
        
        showPopUp()
   
    }
    
    // MARK: Functions -----------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let exampleColor = UIColor(r: 0, g: 46, b: 53)
        tintView.backgroundColor = exampleColor.withAlphaComponent(0.9)
        
        orderBtn.layer.cornerRadius = 25
        
        DataModel.shared.cartItem = checkoutItem
        
        // MARK: Fetch User and Product Image
        
//        DataModel.shared.fetchUser(UID: checkoutItem!.sellerUID) { (user) in
//            self.seller = user
//            self.artistLabel.text = user.name
//        }
//
//        DataModel.shared.fetchImage(stringURL: checkoutItem!.images[0]) { (image) in
//            self.imageOutlet.image = image
//            self.frontImageView.image = image
//        }
        
        
        // MARK: Outlet text and style
        
        self.titleOutlet.text = checkoutItem?.title
        self.priceLabel.text = checkoutItemPrice
        self.sizeLabel.text = checkoutItemSize
        self.orderBtn.layer.cornerRadius = 10
        self.orderBtn.setTitle("Pay \(checkoutItemPrice!)", for: .normal)
        self.artistLabel.text = seller?.name
        self.frontImageView.image = checkoutImage
        self.imageOutlet.image = checkoutImage
        
    }
    
    func showPopUp(){
        
        let successVC = UIStoryboard(name: "ProductCheckout", bundle: nil).instantiateViewController(withIdentifier: "CheckoutSuccess") as! CheckoutSuccessViewController
        successVC.seller = self.checkoutItem?.sellerUID
        self.addChildViewController(successVC)
        successVC.view.frame = self.view.frame
        self.view.addSubview(successVC.view)
        successVC.didMove(toParentViewController: self)
    }
    
}

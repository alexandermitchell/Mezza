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
 
    
    
    
    // MARK: Local Variables --------------------------------------------------
    
    var checkoutItem: Product?
    var seller: User?
    
    // MARK: IBActions -----------------------------------------------------
    
    @IBAction func makeOrder(_ sender: UIButton) {
        
//        DataModel.shared.createOrder(buyerUID: DataModel.shared.loggedInUser, productUID: (checkoutItem?.uid)!, seller: (seller?.uid)!, size: checkoutItem?.sizes[0], status: "pending", timestamp: "date")
        
        
    }
    // MARK: Functions -----------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataModel.shared.fetchUser(UID: checkoutItem!.sellerUID) { (user) in
            self.seller = user
            
        }
        
    }
    
    
    
    
    

}

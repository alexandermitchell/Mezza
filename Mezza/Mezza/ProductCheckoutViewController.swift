//
//  ProductCheckoutViewController.swift
//  Mezza
//
//  Created by Alex Mitchell on 2017-01-19.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit

class ProductCheckoutViewController: UIViewController {
    
    // MARK: Image Outlets --------------------------------------------------
    
    // MARK: Local Variables --------------------------------------------------
    
    var checkoutItem: Product?
    var seller: User?
    
    // MARK: IBActions -----------------------------------------------------
    
    // MARK: Functions -----------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataModel.shared.fetchUser(UID: checkoutItem!.sellerUID) { (user) in
            
        }
        
    }
    
    
    
    
    

}

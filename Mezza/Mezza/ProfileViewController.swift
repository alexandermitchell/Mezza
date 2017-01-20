//
//  SellerProfileViewController.swift
//  Mezza
//
//  Created by Aman Singh on 1/20/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit
import Firebase

class SellerProfileViewController: UIViewController {
    
    @IBAction func SettingsButton(_ sender: Any) {
        
        
    }
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var sellerName: UILabel!
    @IBOutlet weak var sellerLocation: UILabel!
    @IBOutlet weak var sellerDescription: UITextView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        updateSellerProfile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateSellerProfile() {
        let loggedInUser = DataModel.shared.loggedInUser

        
        loggedInUser?.name = sellerName.text!
        loggedInUser?.location = sellerLocation.text!
        loggedInUser?.bio = sellerDescription.text
        
        var seller: User?
        
        DataModel.shared.fetchImage(stringURL: (seller?.avatar)!) { (image) in
            self.profileImage.image = image
        }
    }
    

}

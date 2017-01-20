//
//  SellerProfileViewController.swift
//  Mezza
//
//  Created by Aman Singh on 1/20/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    @IBAction func editButton(_ sender: Any) {
        
    }
    
    @IBAction func signOutButton(_ sender: Any) {
        do {
            try FIRAuth.auth()?.signOut()
            performSegue(withIdentifier: "toLogin", sender: nil)
        } catch let logoutError {
            print(logoutError)
        }
    }
    
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileLocation: UILabel!
    @IBOutlet weak var profileDescription: UITextView!
    
    
    

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

        
        loggedInUser?.name = profileName.text!
        loggedInUser?.location = profileLocation.text!
        loggedInUser?.bio = profileDescription.text
        
        var seller: User?
        
        DataModel.shared.fetchImage(stringURL: (seller?.avatar)!) { (image) in
            self.profileImage.image = image
        }
    }
    

}

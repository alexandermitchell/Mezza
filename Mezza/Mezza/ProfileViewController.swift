//
//  SellerProfileViewController.swift
//  Mezza
//
//  Created by Aman Singh on 1/20/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit
import Firebase


//    ProfileEditViewController.delegate = self

protocol updateImage: class {
    func updateImage (imageURL: String)
    
}


class ProfileViewController: UIViewController, updateImage {
    
    // Edit Button has a Segua
    @IBAction func editButton(_ sender: Any) {
        
        performSegue(withIdentifier: "toEdit", sender: nil)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEdit" {
            let editVC = segue.destination as! ProfileEditViewController
            editVC.delegate = self
            
        }
    }
    // Sign Out Button
    @IBAction func signOutButton(_ sender: Any) {
        do {
            try FIRAuth.auth()?.signOut()
            performSegue(withIdentifier: "toLogin", sender: nil)
        } catch let logoutError {
            print(logoutError)
        }
    }
    
    
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileLocation: UILabel!
    @IBOutlet weak var profileDescription: UITextView!
    
    override func viewDidAppear(_ animated: Bool) {
        profileName.text = DataModel.shared.loggedInUser?.name
        profileLocation.text = DataModel.shared.loggedInUser?.location
        profileDescription.text = DataModel.shared.loggedInUser?.bio
    
        setProfile()
    }
    
    func updateImage(imageURL: String) {
        
        DataModel.shared.fetchImage(stringURL: (imageURL)) { (image) in
            
            self.profileImage.image = image
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signOutButton.layer.cornerRadius = 5
        editButton.layer.cornerRadius = 5
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        
  
        
        setProfile()
    }

    func setProfile() {
        
        let loggedInUser = DataModel.shared.loggedInUser
        
            profileName.text = loggedInUser?.name
            profileLocation.text = loggedInUser?.location
            profileDescription.text = loggedInUser?.bio
        
        let images = loggedInUser?.avatar
        if images != "" {
        DataModel.shared.fetchImage(stringURL: (images!)) { (image) in
            
            self.profileImage.image = image
            
            }
        }
    }
    

}

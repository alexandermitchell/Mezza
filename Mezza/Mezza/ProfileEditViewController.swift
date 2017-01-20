//
//  ProfileEditViewController.swift
//  Mezza
//
//  Created by Aman Singh on 1/20/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit
import Firebase


class ProfileEditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var nameLocation: UITextField!
    @IBOutlet weak var textField: UITextView!
    
    @IBAction func completeProfile(_ sender: Any) {
        
         let userPath = DataModel.shared.loggedInUser
        
        let ref = FIRDatabase.database().reference(withPath: "users/uid")
        let values = ["name": nameField.text, "location": nameLocation.text, "bio": textField] as [String: Any]
        ref.updateChildValues(values)
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImage)))

    }

    func handleSelectProfileImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    



}

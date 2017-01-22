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
    
    @IBAction func cancelButton(_ sender: Any) {
        
    }
    
    
    @IBAction func completeProfile(_ sender: Any) {
        
        if nameField.text == "" {
            alert(message: "Please enter a name", title: "Invalid Name")
        }
        
        if nameLocation.text == "" {
            alert(message: "Please enter a location", title: "Invalid Location")
        }
        else {
            
        let userPath = DataModel.shared.loggedInUser
            
            //Updates name location and bio in Firebase
            let ref = FIRDatabase.database().reference(withPath: "users/uid")
            let values = ["name": nameField.text, "location": nameLocation.text, "bio": textField] as [String: Any]
            ref.updateChildValues(values)
            
                
            //Updates the image
            guard let imageUploaded = profileImageView.image else {
                return
            }
            
            var data = Data()
            data = UIImageJPEGRepresentation(imageUploaded, 0.1)!
            
            let storageRef = FIRStorage.storage().reference()
            let imageUID = NSUUID().uuidString
            let imageRef = storageRef.child(imageUID)
            
            imageRef.put(data, metadata: nil).observe(.success, handler: { (snapshot) in
                let imageURL = snapshot.metadata?.downloadURL()?.absoluteString
                
                let avatarRef = ref.child("avatar")
                avatarRef.setValue(imageURL)
            })
            
            
            
            
            
            
            dismiss(animated: true, completion: nil)
        }
        
        
        
        
        
        
        
        
        
        guard let imageUploaded = profileImageView.image else {
            return
        }
        
        var imageData = Data()
        imageData = UIImageJPEGRepresentation(imageUploaded, 0.1)!
        
        let storageRef = FIRStorage.storage().reference()
        let imageUID = NSUUID().uuidString
        let imageRef = storageRef.child(imageUID)
        //
        
        imageRef.put(imageData, metadata: nil).observe(.success) { (snapshot) in
            let imageURL = snapshot.metadata?.downloadURL()?.absoluteString

            
            let ref = FIRDatabase.database().reference(withPath: "users/uid")
            let avatarRef = ref.child("avatar")
            avatarRef.setValue(imageURL)
            
        }

        
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            profileImageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    //Alert Function
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    

    
}

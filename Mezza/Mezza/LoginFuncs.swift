//
//  LoginFuncs.swift
//  Mezza
//
//  Created by Aman Singh on 1/17/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//
import UIKit
import Foundation

extension LoginVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    //MARK: Register Function
    func handleRegister() {
        // guards are great for forms
        guard let email = emailTextField.text,let password = passwordTextField.text, let name = nameTextField.text
            else{
                print("Form is not valid")
                return
        }
//        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
//            
//            if error != nil {
//                print(error!)
//                return
//            }
//            
//            guard let uid = user?.uid else {
//                return
//            }
//            let imageName = NSUUID().uuidString
//            let storageRef = FIRStorage.storage().reference().child("profile_images").child("\(imageName).jpg")
//            
//            //compresses the image.
//            if let profileImage = self.profileImageView.image, let uploadData = UIImageJPEGRepresentation(self.profileImageView.image!, 0.1) {
//                
//                storageRef.put(uploadData, metadata: nil, completion: { (metaData, error) in
//                    if error != nil {
//                        print(error!)
//                        return
//                    }
//                    if let profileImageUrl = metaData?.downloadURL()?.absoluteString {
//                        let values = ["name": name, "email": email, "profileImageUrl": profileImageUrl]
//                        
//                        self.registerUserIntoDatabaseWithUID(uid: uid, values: values)
//                    }
//                })
//            }
//        })
    }
    
    private func registerUserIntoDatabaseWithUID(uid: String, values: [String: Any]) {
        
        // New user should be successfully authenticated
//        let ref = FIRDatabase.database().reference(fromURL: "https://chatapp-da192.firebaseio.com/")
//        let usersReference = ref.child("users").child(uid)
        
//        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
//            if err != nil{
//                print(err!)
//                return
//            }
//            
//            //            self.messagesController?.fetchUserAndSetupNavBarTitle()
//            //            self.messagesController?.navigationItem.title = values["names"] as? String
//            let user = User()
//            user.setValuesForKeys(values)
//            self.messagesController?.setupNavBarWithUser(user: user)
//            
//            self.dismiss(animated: true, completion: nil)
//        })
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
}

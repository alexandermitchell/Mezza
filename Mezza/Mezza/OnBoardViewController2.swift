//
//  OnBoardViewController2.swift
//  Mezza
//
//  Created by Edward Han on 1/17/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class OnBoardViewController2: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    var imagePicked = false
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    @IBOutlet weak var uploadPhotoLabel: UILabel!
    
    
    @IBAction func goNext(_ sender: Any) {
        
        if imagePicked == false {
            alert(message: "please upload a photo")
        }
        
        guard let imageUploaded = profileImageView.image else {
            alert(message: "please upload a photo")
            return
        }
        
        var data = Data()
        data = UIImageJPEGRepresentation(imageUploaded, 0.1)!
        
//        let metaData = FIRStorageMetadata()
//        metaData.contentType = "image/jpg"
        
        let storageRef = FIRStorage.storage().reference()
        let imageUID = NSUUID().uuidString
        let imageRef = storageRef.child(imageUID)
//
        
        imageRef.put(data, metadata: nil).observe(.success) { (snapshot) in
            let imageURL = snapshot.metadata?.downloadURL()?.absoluteString
            
            let user = DataModel.shared.loggedInUser
            let ref  = FIRDatabase.database().reference(withPath: "users/\(user?.uid)")
            
//            let ref = FIRDatabase.database().reference(withPath: "users/uid")
            let avatarRef = ref.child("avatar")
            avatarRef.setValue(imageURL)
            
            
            DataModel.shared.loggedInUser?.avatar = imageURL!
        }
        
        

        performSegue(withIdentifier: "toOnBoardVC3", sender: nil)
    
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
//
//        var pictureUploaded = false
        

//        view.backgroundColor = UIColor.red
        

        
        profileImageView.isUserInteractionEnabled = true
    
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImage)))
        
        // Do any additional setup after loading the view.
    }

    
    
    
    
    func handleSelectProfileImage() {
        
        print("tapped")
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
            uploadPhotoLabel.isHidden = true
            imagePicked = true
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

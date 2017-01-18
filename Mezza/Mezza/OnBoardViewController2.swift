//
//  OnBoardViewController2.swift
//  Mezza
//
//  Created by Edward Han on 1/17/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit

class OnBoardViewController2: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    @IBOutlet weak var uploadPhotoLabel: UILabel!
    
    
    @IBAction func goNext(_ sender: Any) {
        
        performSegue(withIdentifier: "toOnBoardVC3", sender: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        var pictureUploaded = false
        

        view.backgroundColor = UIColor.red


            
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

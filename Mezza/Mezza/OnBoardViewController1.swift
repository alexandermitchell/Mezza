//
//  OnBoardViewController1.swift
//  Mezza
//
//  Created by Edward Han on 1/17/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class OnBoardViewController1: UIViewController {
    
    
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var locationField: UITextField!
    
    
    @IBAction func goNext(_ sender: Any) {
        
                if nameField.text == "" && locationField.text != "" {
        
                    alert(message: "please enter a valid name", title: "invalid name")
                }
        
                if locationField.text == "" && nameField.text == "'" {
        
                    alert(message: "please enter a valid text", title: "invalid location")
                }
        
                if locationField.text == "" && nameField.text == "" {
        
                    alert(message: "please enter a valid name and location")
                }
        
        
                else {
        
                    let userPath = DataModel.shared.loggedInUser
                    let ref  = FIRDatabase.database().reference(withPath: "users/\(userPath)")
                    
                    let nameRef = ref.child("name")
                    nameRef.setValue(nameField.text)
                    
                    let locationRef = ref.child("location")
                    locationRef.setValue(locationField.text)
                  
                    performSegue(withIdentifier: "toOnBoardVC2", sender: nil)
                    
                }
        
        
        
    }
    

    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = UIColor.red
        // Do any additional setup after loading the view.
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

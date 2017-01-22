//
//  OnBoardViewController3.swift
//  Mezza
//
//  Created by Edward Han on 1/17/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit
import Firebase

class OnBoardViewController3: UIViewController {
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    @IBOutlet weak var textField: UITextView!
    
    @IBAction func complete(_ sender: Any) {
        
        
        if textField.text == "" {
            
            alert(message: "please enter some information about yourself so buyers can learn more about you")
        }
        
        else {
           
            let user = DataModel.shared.loggedInUser
            let ref  = FIRDatabase.database().reference(withPath: "users/\(user?.uid)")
            
//            let ref = FIRDatabase.database().reference(withPath: "users/uid")
            
            
            DataModel.shared.loggedInUser?.bio = textField.text
            
            let bioRef = ref.child("bio")
            bioRef.setValue(textField.text)
            performSegue(withIdentifier: "toProfile", sender: nil)
            
            
            
        }
        
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

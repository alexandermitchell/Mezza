//
//  ProfileEditViewController.swift
//  Mezza
//
//  Created by Aman Singh on 1/20/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit
import Firebase


class ProfileEditViewController: UIViewController {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var nameLocation: UITextField!
    @IBOutlet weak var textField: UITextView!
    
    @IBAction func completeProfile(_ sender: Any) {
        
         let userPath = DataModel.shared.loggedInUser
        
         let re
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }



}

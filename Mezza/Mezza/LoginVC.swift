//
//  LoginVC.swift
//  Mezza
//
//  Created by Aman Singh on 1/17/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//
/*
 1. need to set up alerts if password isn't correct.
 2. need to set up segua based on seller or buyer 
 3. 
 
 */



import Foundation
import UIKit
import Firebase

class LoginVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 247, g: 0, b: 37)
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(loginRegisterSegmentedControl)
        view.addSubview(vendorBuyerSegmentedControl)
    
        
        setupInputsContainter()
        setupLoginRegisterButton()
        setupLoginRegisterSegmentedControl()
        setupVendorBuyerSegmentedControl()

    }

    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    
    //MARK: Register Button
    let loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 40, g: 54, b: 85)
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        
        
        return button
    }()
    

    //MARK: Seperates functionality between Login Vs. Register
    func handleLoginRegister() {
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            handleRegister()
        }
    }
    
    //MARK: Login Function
    func handleLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text
            else {
                UIAlertAction(title: "Sorry, your password is not valid", style: .default, handler: nil)
                print("Form is not valid")
                return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                UIAlertAction(title: "Sorry, this user is already signed in", style: .default, handler: nil)
                print(error!)
            }

            print("123123")

        })
    }
    
    
    //MARK: Register Function
    func handleRegister() {
        
        guard let email = emailTextField.text,let password = passwordTextField.text, let name = nameTextField.text
            else{
                print("Form is not valid")
                return
        }
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
            
            var type = String()
            
            if error != nil {
                print(error!)
                return
            }
            
            guard let uid = user?.uid else {
                return
            }
            
            if self.vendorBuyerSegmentedControl.selectedSegmentIndex == 0 {
                type = "seller"
            } else {
                type = "buyer"
            }
            
            let ref = FIRDatabase.database().reference(fromURL: "https://mezza-f928a.firebaseio.com/")
            
            let usersReference = ref.child("users").child(uid)
            
            let typeRef = usersReference.child("type")
            typeRef.setValue(type)
            
            let emailRef = usersReference.child("email")
            emailRef.setValue(email)
            
            let nameRef = usersReference.child("name")
            nameRef.setValue(name)
            
            self.dismiss(animated: true, completion: nil)
        })
    }

    
    //MARK: Name Text Field
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    
    //MARK: Seperating line between name and email
    let nameSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    //MARK: Email Text Field
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email Address"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = .emailAddress
        tf.autocapitalizationType = .none
        return tf
    }()
    
    //MARK: Seperating line between email and password
    let emailSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: Password Text Field
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
    }()
    
    //MARK: UI - Vendor & Buyer Toggle
    let vendorBuyerSegmentedControl: UISegmentedControl = {
        let vbSC = UISegmentedControl(items: ["Seller", "Buyer"])
        vbSC.translatesAutoresizingMaskIntoConstraints = false
        vbSC.tintColor = UIColor.white
        vbSC.selectedSegmentIndex = 1
        vbSC.addTarget(self, action: #selector(handleVendorBuyerRegister), for: .valueChanged)
        return vbSC
    }()

    func handleVendorBuyerRegister() {
    
    }
    

    //MARK: UI - Login & Register Toggle
    let loginRegisterSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.white
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return sc
    }()
    
    // Changes the buttom from login to register depending on what is selected.
    func handleLoginRegisterChange() {
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: UIControlState())
        
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            vendorBuyerSegmentedControl.isHidden = true
        } else {
            vendorBuyerSegmentedControl.isHidden = false
        }
        
        
        // Change height of input container view
        inputsContainerViewHeightAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150
        
        // Change height of nameTextField
        nameTextFieldHeightAnchor?.isActive = false
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3)
        nameTextField.isHidden = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? true : false
        nameTextFieldHeightAnchor?.isActive = true
        
        
        emailTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        passwordTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
    }
    
    
    //MARK: Function - Login & Register Toggle
    func setupLoginRegisterSegmentedControl() {
        // need X, Y, Width, Height constraint
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -60).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
    
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    var loginRegisterSegmentedControlHeightAnchor: NSLayoutConstraint?
    
    // MARK: Constraints for all views.
    func setupInputsContainter() {
        // need X, Y, Width, Height constraint
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        
        inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
        inputsContainerViewHeightAnchor?.isActive = true
        
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameSeperatorView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeperatorView)
        inputsContainerView.addSubview(passwordTextField)
        
        // need X, Y, Width, Height constraint
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        
        
        // need X, Y, Width, Height constraint
        nameSeperatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeperatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeperatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        // need X, Y, Width, Height constraint
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        
        // need X, Y, Width, Height constraint
        emailSeperatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeperatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeperatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // need X, Y, Width, Height constraint
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
        
        
        
    }
    
    // MARK: Function - Vendor & Buyer Toggle
    func setupVendorBuyerSegmentedControl() {
        // X, Y, Width, Height
        vendorBuyerSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vendorBuyerSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 45).isActive = true
        vendorBuyerSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1).isActive = true
        vendorBuyerSegmentedControl.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
    
    func setupLoginRegisterButton() {
        // need X, Y, Width, Height constraint
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 60).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }

}

//Extention makes it easier to write colors.
extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
}

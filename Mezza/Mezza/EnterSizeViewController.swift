//
//  EnterSizeViewController.swift
//  Mezza
//
//  Created by Edward Han on 1/20/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit

class EnterSizeViewController: UIViewController {
    
    
    var passedSize: Product.Size?
    var selectedIndex: Int?
    
    weak var delegate: EnterSizePopUpDelegate?
    
    @IBOutlet weak var width: UITextField!
    
    
    @IBOutlet weak var height: UITextField!
    
    
    @IBOutlet weak var inCmSwitch: UISegmentedControl!
    
    
    @IBOutlet weak var price: UITextField!
    
    @IBOutlet weak var quantity: UITextField!
    
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        
          self.view.removeFromSuperview()
        
    }
    
  
    @IBAction func save(_ sender: Any) {
        
        if width.text == nil || height.text == nil || price.text == nil || quantity.text == nil {
               alert(message: "please fill out all the fields")
                return
        }
        
    
        else {
            let priceText = price.text
            let letters = NSCharacterSet.letters
            
            if priceText?.lowercased().rangeOfCharacter(from: letters) != nil {
                alert(message: "invalid price")
                return
            }
            
            let quantityText = quantity.text
            
            if quantityText?.rangeOfCharacter(from: letters) != nil || (quantityText?.contains("."))! {
                alert(message: "invalid quantity")
                return
            }
                
            let widthText = width.text
            let heightText = height.text
            
            
            if widthText?.lowercased().rangeOfCharacter(from: letters) != nil || heightText?.lowercased().rangeOfCharacter(from: letters) != nil {
                
                alert(message: "invalid size dimensions")
            }
                
                
            
            else {
                print("-------------\n ---------\n ")
                
                let floatPrice = Float(priceText!)
                let priceString = String(format: "%.2F", floatPrice!)
                let quantityInt = Int(quantityText!)
                
                let widthText = width.text!
                let heightText = height.text!
                
                var unit = String()
                if inCmSwitch.selectedSegmentIndex == 0 {
                    unit = "in"
                }
                if inCmSwitch.selectedSegmentIndex == 1 {
                    unit = "cm"
                }
                
                

                let sizeString = "\(widthText) x \(heightText) \(unit)"
                
                let enterSize = Product.Size(price: priceString, quantity: quantityInt!, name: sizeString)
                
                print(enterSize.name)
                
                
                if selectedIndex == nil {
                     delegate?.addSize(addedSize: enterSize)
                }
                
                if selectedIndex != nil {
                    delegate?.replaceSize(editedSize: enterSize, index: selectedIndex!)
                }
                
               
                
                self.view.removeFromSuperview()
                
            }

            
            
        }

        
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()

  
        
        if let selectedSize = passedSize {
            
            price.text = String(selectedSize.price)
            quantity.text = String(selectedSize.quantity)
            
            let sizeString = selectedSize.name
            
            let sizeArray = sizeString.characters.split{$0 == " "}.map(String.init)
            
            
            width.text = sizeArray[0]
            height.text = sizeArray[2]
            
            if sizeArray[2] == "cm" {
                inCmSwitch.selectedSegmentIndex = 1
            }
            if sizeArray[2] == "in" {
                inCmSwitch.selectedSegmentIndex = 0
            }
            
        }

        
        
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

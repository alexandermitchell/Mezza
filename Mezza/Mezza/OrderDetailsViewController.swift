//
//  OrderDetailsViewController.swift
//  Mezza
//
//  Created by Paul Jurczyk on 1/20/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit
import Firebase

class OrderDetailsViewController: UIViewController {
    
    // MARK: Local Variables ---------------------------------------------------
    
    var currentOrder: Order?
    let userType = DataModel.shared.loggedInUser?.type.rawValue
    // MARK: IBOutlets ----------------------
    
    @IBOutlet weak var orderStatusLabel: UILabel!
    
    @IBOutlet weak var updateOrderStatusButton: UIButton!
    // MARK: IBActions -----------------------
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToOrderFeed", sender: self)
    }
    
    
    @IBAction func updateStatusButtonPressed(_ sender: UIButton) {
        showPopUp()
//        updateOrderStatus(userType: userType!)
//        updateOrderStatusButton.isHidden = true
    }
    
    // MARK: Funcs ------------------------
    
    func updateOrderStatus(userType: String) {
        let orderUID = currentOrder!.uid
        let ordersRef = FIRDatabase.database().reference(withPath: "orders/\(orderUID)")
        //ordersRef.removeValue()
        
        if userType == "seller" {
            ordersRef.updateChildValues([AnyHashable("status") : "sent"])
            self.orderStatusLabel.text = "sent"
        } else {
            ordersRef.updateChildValues([AnyHashable("status") : "cancelled"])
            self.orderStatusLabel.text = "cancelled"
        }
    }
    
    func changeButtonText() {
        
        if userType == "buyer" {
            updateOrderStatusButton.setTitle("Cancel Order", for: .normal)
        } else {
            updateOrderStatusButton.setTitle("Mark As Shipped", for: .normal)
        }
        
    }
    
    func showPopUp() {
        // set up popup
        
        let popOverVC = UIStoryboard(name: "BuyerOrderFeed", bundle: nil).instantiateViewController(withIdentifier:"OrderStatusPopUp") as! OrderStatusPopUpViewController
        //popOverVC.delegate = self
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
        
    }
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeButtonText()
        if currentOrder?.status.rawValue != "pending" {
            updateOrderStatusButton.isHidden = true
        }
        orderStatusLabel.text = currentOrder?.status.rawValue
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

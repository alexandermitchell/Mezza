//
//  OrderStatusPopUpViewController.swift
//  Mezza
//
//  Created by Paul Jurczyk on 1/22/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit
import Firebase

class OrderStatusPopUpViewController: UIViewController {
    
    
    weak var delegate: OrderStatusPopUpDelegate?
    var userType = DataModel.shared.loggedInUser?.type.rawValue
    var currentOrder: Order?
    
    // MARK: IBOutlets -------------------
    
    @IBOutlet weak var popUpTextView: UITextView!
    
    // MARK: IBActions -------------------
    
    @IBAction func yesButtonClicked(_ sender: UIButton) {
        if userType == "buyer" {
       currentOrder?.status = .cancelled
        } else {
            currentOrder?.status = .sent
        }
        delegate?.updateOrderStatus(currentOrder: currentOrder!)
        updateOrderStatus(userType: userType!)
        self.view.removeFromSuperview()
    }
    
    @IBAction func noButtonClicked(_ sender: UIButton) {
        
        self.view.removeFromSuperview()
    }
    
    func updateOrderStatus(userType: String) {
        let orderUID = currentOrder!.uid
        let ordersRef = FIRDatabase.database().reference(withPath: "orders/\(orderUID)")
        
        if userType == "seller" {
            ordersRef.updateChildValues([AnyHashable("status") : "sent"])
            //self.orderStatusLabel.text = "sent"
        } else {
            ordersRef.updateChildValues([AnyHashable("status") : "cancelled"])
            //self.orderStatusLabel.text = "cancelled"
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.8)

        if userType == "buyer" {
           popUpTextView.text = "Are You Sure You Want To Cancel Your Order? This Action Cannot Be Undone."
        } else {
            popUpTextView.text = "Are You Sure You Want Mark This Item As Shipped? This Action Cannot Be Undone."
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

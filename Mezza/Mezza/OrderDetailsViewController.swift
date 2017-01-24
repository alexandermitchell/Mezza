//
//  OrderDetailsViewController.swift
//  Mezza
//
//  Created by Paul Jurczyk on 1/20/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit
import Firebase

protocol OrderStatusPopUpDelegate: class {
    func updateOrderStatus(currentOrder: Order)
}

class OrderDetailsViewController: UIViewController, OrderStatusPopUpDelegate {
    
    // MARK: Local Variables ---------------------------------------------------
    
    var currentOrder: Order?
    var currentProduct: Product?
    let userType = DataModel.shared.loggedInUser?.type.rawValue
    
    // MARK: IBOutlets ----------------------
    
    @IBOutlet weak var orderStatusLabel: UILabel!
    
    @IBOutlet weak var updateOrderStatusButton: UIButton!
    
    @IBOutlet weak var orderImageView: UIImageView!
    
    @IBOutlet weak var buyerSellerNameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var buyerSellerLabel: UILabel!
    
    
    
    
    // MARK: IBActions -----------------------
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToOrderFeed", sender: self)
        
    }
    
    
    @IBAction func updateStatusButtonPressed(_ sender: UIButton) {
        showPopUp()
        
    }
    
    
    
    
    
    // MARK: Funcs ------------------------
    
    
    
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
        popOverVC.currentOrder = currentOrder
        popOverVC.delegate = self
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
        
    }
    
    // PopUp Protocol Funcs
    func updateOrderStatus(currentOrder: Order) {
        self.currentOrder = currentOrder
        orderStatusLabel.text = currentOrder.status.rawValue
        updateOrderStatusButton.isHidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        priceLabel.text = "$\(currentOrder!.price)"
        if userType == "buyer" {
            buyerSellerLabel.text = "Seller:"
            let sellerUID = currentOrder?.sellerUID
            DataModel.shared.fetchUser(UID: sellerUID!, completionHandler: { user in
                self.buyerSellerNameLabel.text = user.name
            })
        } else {
            buyerSellerLabel.text = "Buyer:"
            let buyerUID = currentOrder?.buyerUID
            DataModel.shared.fetchUser(UID: buyerUID!, completionHandler: { user in
                self.buyerSellerNameLabel.text = user.name
            })
        }
        DataModel.shared.fetchProduct(UID: (currentOrder?.product)!) { product in
            let imageURL = product.images[0]
            DataModel.shared.fetchImage(stringURL: imageURL, completionHandler: { image in
                self.orderImageView.image = image
            })
        }
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

//
//  OrderDetailsViewController.swift
//  Mezza
//
//  Created by Paul Jurczyk on 1/20/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit

class OrderDetailsViewController: UIViewController {
    
    // MARK: Local Variables ---------------------------------------------------
    
    var currentOrder: Order?
    
    // MARK: IBOutlets ----------------------
    
    @IBOutlet weak var orderStatusLabel: UILabel!
    
    @IBOutlet weak var updateOrderStatusButton: UIButton!
    // MARK: IBActions -----------------------
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToOrderFeed", sender: self)
    }
    
    func changeButtonText() {
        let userType = DataModel.shared.loggedInUser?.type
        if userType?.rawValue == "buyer" {
            updateOrderStatusButton.setTitle("Cancel Order", for: .normal)
        } else {
            updateOrderStatusButton.setTitle("Mark As Shipped", for: .normal)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeButtonText()
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

//
//  OrderDetailsViewController.swift
//  Mezza
//
//  Created by Paul Jurczyk on 1/20/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit

class OrderDetailsViewController: UIViewController {
    
    @IBOutlet weak var orderStatusSegmeneted: UISegmentedControl!
    
    
    func setCurrentOrderStatus() {
        
        orderStatusSegmeneted.setTitle("Pending", forSegmentAt: 0)
        orderStatusSegmeneted.setTitle("Sent", forSegmentAt: 1)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

       setCurrentOrderStatus()
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

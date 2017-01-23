//
//  OrderStatusPopUpViewController.swift
//  Mezza
//
//  Created by Paul Jurczyk on 1/22/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit

class OrderStatusPopUpViewController: UIViewController {
    
    
    weak var delegate: OrderStatusPopUpDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.8)

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

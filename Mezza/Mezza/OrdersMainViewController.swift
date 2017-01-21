//
//  OrdersMainViewController.swift
//  Mezza
//
//  Created by Paul Jurczyk on 1/20/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit

class OrdersMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Local Variables ------------
    var ordersArray = [Order]()
    let loggedInUserType = DataModel.shared.loggedInUser?.type.rawValue
    let loggedInUID = DataModel.shared.loggedInUser?.uid
    // MARK: IBOutlets -----------------
    
    @IBOutlet weak var ordersTableView: UITableView!
    
    func fetchBuyerOrders() {
        
        
        
    }
    
    
    
    
    
    
    
    
    
    // MARK: Tableview Funcs ---------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ordersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ordersTableView.dequeueReusableCell(withIdentifier: "OrderCell") as! OrdersTableViewCell
        
        
        return cell
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

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

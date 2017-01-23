//
//  OrdersMainViewController.swift
//  Mezza
//
//  Created by Paul Jurczyk on 1/20/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit
import Firebase

class OrdersMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Local Variables ------------
    var pendingOrdersArray = [Order]()
    var pastOrdersArray = [Order]()
    let loggedInUserType = DataModel.shared.loggedInUser?.type.rawValue
    let loggedInUID = DataModel.shared.loggedInUser?.uid
    var selectedOrder: Order?
    // MARK: IBOutlets -----------------
    
    
    @IBOutlet weak var ordersTableView: UITableView!
    
    @IBOutlet weak var ordersSegmentedControl: UISegmentedControl!
    
    // unwind segue -> back button on order detail page
    @IBAction func unwindToOrderFeed(segue: UIStoryboardSegue) {
        
    }
    
    // MARK: FB Funcs ------------------------
    
    func fetchBuyerOrders(completionHandler: @escaping ()->()) {
        let ordersRef = FIRDatabase.database().reference().child("orders")
        ordersRef.queryOrdered(byChild: "buyer").queryEqual(toValue: loggedInUID).observe(.value, with: { snapshot in
            var tempPendingArray = [Order]()
            var tempPastArray = [Order]()
            for child in snapshot.children {
                let order = Order(snapshot: child as! FIRDataSnapshot)
                
                if order.status.rawValue == "pending" {
                    
                    tempPendingArray.append(order)
                } else {
                    tempPastArray.append(order)
                }
            }
            self.pendingOrdersArray = tempPendingArray
            self.pastOrdersArray = tempPastArray
            completionHandler()
        })
        
    }
    
    func fetchSellerOrders(completionHandler: @escaping ()->()) {
        let ordersRef = FIRDatabase.database().reference().child("orders")
        ordersRef.queryOrdered(byChild: "seller").queryEqual(toValue: loggedInUID).observe(.value, with: { snapshot in
            var tempPendingArray = [Order]()
            var tempPastArray = [Order]()
            for child in snapshot.children {
                let order = Order(snapshot: child as! FIRDataSnapshot)
                if order.status.rawValue == "pending" {
                    tempPendingArray.append(order)
                } else {
                    tempPastArray.append(order)
                }
            }
            self.pendingOrdersArray = tempPendingArray
            self.pastOrdersArray = tempPastArray
            completionHandler()
        })
        
    }
    
    
    
    
    
    
    // MARK: Tableview Funcs ---------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var cellCount = Int()
        if ordersSegmentedControl.selectedSegmentIndex == 0 {
            cellCount = pendingOrdersArray.count
        } else {
            cellCount = pastOrdersArray.count
        }
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ordersTableView.dequeueReusableCell(withIdentifier: "OrderCell") as! OrdersTableViewCell
        if ordersSegmentedControl.selectedSegmentIndex == 0 {
            cell.orderStatusLabel.text = pendingOrdersArray[indexPath.row].status.rawValue
            let productUID = pendingOrdersArray[indexPath.row].product
            
            DataModel.shared.fetchProduct(UID: productUID, completionHandler: { product in
                cell.itemNameLabel.text = product.title
                let imageURL = product.images[0]
                DataModel.shared.fetchImage(stringURL: imageURL, completionHandler: { image in
                    cell.orderImageView.image = image
                })
                
            })
            
            
            
        } else {
            cell.orderStatusLabel.text = pastOrdersArray[indexPath.row].status.rawValue
            cell.itemNameLabel.text = pastOrdersArray[indexPath.row].product
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if ordersSegmentedControl.selectedSegmentIndex == 0 {
            selectedOrder = pendingOrdersArray[indexPath.row]
        } else {
            selectedOrder = pastOrdersArray[indexPath.row]
        }
        performSegue(withIdentifier: "showOrderDetail", sender: self)
    }
    
    func segmentedControlReloadTableView() {
        ordersTableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "showOrderDetail") {
            let detailsViewController = segue.destination as! OrderDetailsViewController
            detailsViewController.currentOrder = selectedOrder
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if loggedInUserType == "buyer" {
            fetchBuyerOrders(completionHandler: {
                self.ordersTableView.reloadData()
            })
        }
        // didn't use an else because we have unregistered users as well
        if loggedInUserType == "seller" {
            fetchSellerOrders(completionHandler: {
                self.ordersTableView.reloadData()
            })
        }
        ordersSegmentedControl.addTarget(self, action: #selector(segmentedControlReloadTableView), for: .valueChanged)
        
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

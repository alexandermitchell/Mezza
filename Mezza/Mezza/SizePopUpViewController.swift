//
//  SizePopUpViewController.swift
//  Mezza
//
//  Created by Paul Jurczyk on 1/20/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit

class SizePopUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: Local Variables
    
    var sizeUIPicker: UIPickerView?
    var sizesArray = [String]()
    var selectedSize: String?
    
    weak var delegate: PopUpDelegate?
    
    // MARK: IBOutlets --------
    
    @IBOutlet weak var popUpView: UIView!
    
    
    @IBAction func dismissPopUp(_ sender: UIButton) {
        let itemDetailVC = UIStoryboard(name: "HomeFeedStoryboard", bundle: nil).instantiateViewController(withIdentifier:"itemDetailsID") as! FeedItemDetailsViewController
        itemDetailVC.selectedSize = selectedSize
        if let selectedSize = selectedSize {
            delegate?.sizeSelected(size: selectedSize)
        }
        sizeUIPicker?.isHidden = true
        self.view.removeFromSuperview()
        
    }
    
    // MARK: UIPicker Funcs ---------------------------------------------------------------
    
    // data method to return the numbe of columns in the picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // data method to return the number of rows shown in the picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sizesArray.count
    }
    // delegate method to return the value shown in the picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sizesArray[row]
    }
    
    // delegate method called when the row was selected.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedSize = sizesArray[row]
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
self.view.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.8)
        // set up picker view
        sizeUIPicker = UIPickerView()
        sizeUIPicker?.frame = CGRect(x: 0, y: -50, width: self.popUpView.layer.bounds.width, height: self.popUpView.layer.bounds.height - 30)
        sizeUIPicker?.delegate = self
        sizeUIPicker?.dataSource = self
        self.popUpView.addSubview(sizeUIPicker!)
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

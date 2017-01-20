//
//  ProductUploadViewController.swift
//  Mezza
//
//  Created by Edward Han on 1/19/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit

class ProductUploadViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    var editingMode = false
    var selectedProduct: Product?
    
    
    var openImageViewIndex: Int = 0
//    {
//        if let product = selectedProduct {
//            return product.images.count
//        }
//        else {
//            return 0
//        }
//    }
    
    
    var selectedImageIndex: Int = 0
    
    
    
    
    
    
    @IBOutlet weak var titleField: UITextField!
    
    
    @IBOutlet weak var artistField: UITextField!
    
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    
    var imageViewArray: [UIImageView]?

    
    
    @IBOutlet weak var descriptonField: UITextView!
    
    @IBOutlet weak var sizePriceQuantTableView: UITableView!
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let _ = selectedProduct else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sizeCell") as! SizeCellTableViewCell
            return cell
            
        }
        
        let sizeArray = selectedProduct?.sizes
        let cell = tableView.dequeueReusableCell(withIdentifier: "sizeCell") as! SizeCellTableViewCell
        cell.priceLabel.text = String(describing: sizeArray?[indexPath.row].price)
        cell.quantityLabel.text = String(describing: sizeArray?[indexPath.row].quantity)
        cell.sizeLabel.text = sizeArray?[indexPath.row].name
        
        return cell
        
        }

    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let product = selectedProduct {
            return product.sizes.count
        }
        else {
            return 1
        }
        
       
    }
    
    
    
    
    @IBAction func addPhoto(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            imageViewArray?[openImageViewIndex].image = selectedImage
            openImageViewIndex += 1

        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

   
       imageViewArray = [mainImageView, imageView1, imageView2, imageView3, imageView4]
        
        if let product = selectedProduct {
            openImageViewIndex = product.images.count
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

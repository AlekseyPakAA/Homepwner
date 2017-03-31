//
//  DetailController.swift
//  Homepwner
//
//  Created by admin on 20.03.17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class DetailController: UIViewController , UITextFieldDelegate,
                        UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateButton: UIButton!
    @IBOutlet var imageView: UIImageView!
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    
    var imageStore: ImageStore!

    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialField.text = item.serialNumber
        
        valueField.text = numberFormatter.string(from: NSNumber.init(value: item.valueInDollars))
        dateButton.setTitle(dateFormatter.string(from: item.dateCreted), for: .normal)
        
        if let image = imageStore.get(imageFor: item.id) {
            imageView.image = image
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        
        item.name = nameField.text ?? ""
        item.serialNumber = serialField.text
        
        
        if let valueText = valueField.text
            , let value = numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDatePicker" {
            let detailViewController = segue.destination as! DatePickerController
            detailViewController.item = item
        }
    }
    
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            let crosshair = UIButton(type: .contactAdd)
            crosshair.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            crosshair.translatesAutoresizingMaskIntoConstraints = false
            imagePicker.cameraOverlayView?.addSubview(crosshair)
            imagePicker.cameraOverlayView?.isUserInteractionEnabled = false
            crosshair.centerXAnchor.constraint(equalTo: (imagePicker.cameraOverlayView?.centerXAnchor)!).isActive = true
            crosshair.centerYAnchor.constraint(equalTo: (imagePicker.cameraOverlayView?.centerYAnchor)!).isActive = true
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        imageView.image = image
        
        imageStore.set(image: image, for: item.id)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func imageLongPressed(_ sender: UILongPressGestureRecognizer) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Clear", style: .destructive, handler: {_ in
            self.imageStore.delete(imageFor: self.item.id)
            self.imageView.image = nil
        })
        alertController.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

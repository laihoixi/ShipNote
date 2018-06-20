//
//  AddPhotoViewController.swift
//  ShipNote
//
//  Created by User03 on 2018/6/20.
//  Copyright © 2018年 User03. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    @IBOutlet weak var photoTitle: UITextField!
    @IBOutlet weak var photoContent: UITextView!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBAction func textFieldEditing(_ sender: UITextField) {
        let datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(AddPhotoViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func selectPhoto(_ sender: Any) {
        print("pressed selectPhoto!")
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        show(controller, sender: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        photo.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: Any) {
        if photo.image == nil {
            let alertController = UIAlertController(
                title: "Warning",
                message: "Please Chosen a Photo",
                preferredStyle: .alert
            )
            let okAction = UIAlertAction(
                title: "Confirm",
                style: .default,
                handler: {
                    (action: UIAlertAction!) -> Void in
            })
            alertController.addAction(okAction)
            self.present(
                alertController,
                animated: true,
                completion: nil
            )
            return
        }
        else if photoContent.text?.characters.count == 0 {
            let alertController = UIAlertController(
                title: "Warning",
                message: "Content cannot be empty",
                preferredStyle: .alert
            )
            let okAction = UIAlertAction(
                title: "confirm",
                style: .default,
                handler: {
                    (action: UIAlertAction!) -> Void in
            })
            alertController.addAction(okAction)
            self.present(
                alertController,
                animated: true,
                completion: nil
            )
            return
        }
        else if dateTextField.text?.characters.count == 0 {
            let alertController = UIAlertController(
                title: "Warning",
                message: "Content cannot be empty",
                preferredStyle: .alert
            )
            let okAction = UIAlertAction(
                title: "confirm",
                style: .default,
                handler: {
                    (action: UIAlertAction!) -> Void in
            })
            alertController.addAction(okAction)
            self.present(
                alertController,
                animated: true,
                completion: nil
            )
            return
        }
        else if photoTitle.text?.characters.count == 0 {
            photoTitle.text = photoContent.text.components(separatedBy: "\n") [0]
        }
        
        var fileManager = FileManager.default
        var docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        var docUrl = docUrls.first
        
        var url = docUrl?.appendingPathComponent("photoTitles.txt")
        var titles = NSArray(contentsOf: url!)
        var titlesArray = [String]();
        if titles != nil {
            for title in titles! {
                titlesArray.append(title as! String);
            }
        }
        titlesArray.insert(photoTitle.text!, at: 0)
        (titlesArray as NSArray).write(to: url!, atomically: true)
        
        url = docUrl?.appendingPathComponent("photoContents.txt")
        var contents = NSArray(contentsOf: url!)
        var contentsArray = [String]()
        if contents != nil {
            for content in contents! {
                contentsArray.append(content as! String)
            }
        }
        contentsArray.insert(photoContent.text!, at: 0)
        (contentsArray as NSArray).write(to: url!, atomically: true)
        
        url = docUrl?.appendingPathComponent("photoDates.txt")
        var dates = NSArray(contentsOf: url!)
        var datesArray = [String]()
        if dates != nil {
            for date in dates! {
                datesArray.append(date as! String)
            }
        }
        datesArray.insert(dateTextField.text!, at: 0)
        (datesArray as NSArray).write(to: url!, atomically: true)
        
        url = docUrl?.appendingPathComponent("photoNames.txt")
        var names = NSArray(contentsOf: url!)
        var namesArray = [String]()
        if names != nil {
            for name in names! {
                namesArray.append(name as! String)
            }
        }
        let number = Date().timeIntervalSinceReferenceDate
        namesArray.insert("\(number)", at: 0)
        (namesArray as NSArray).write(to: url!, atomically: true)
        
        /*read file to check*/
        url = docUrl?.appendingPathComponent("photoTitles.txt")
        titles = NSArray(contentsOf: url!)
        for title in titles! {
            print("\(title)")
        }
        
        url = docUrl?.appendingPathComponent("photoContents.txt")
        contents = NSArray(contentsOf: url!)
        for content in contents! {
            print("\(content)")
        }
        
        let data = UIImageJPEGRepresentation(photo.image!, 0.8)
        url = docUrl?.appendingPathComponent(namesArray[0])
        try? data?.write(to: url!)
        
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoContent.layer.borderColor =  UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).cgColor
        
        photoContent.layer.cornerRadius = 10.0;
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

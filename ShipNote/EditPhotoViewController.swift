//
//  EditPhotoViewController.swift
//  ShipNote
//
//  Created by User03 on 2018/6/20.
//  Copyright © 2018年 User03. All rights reserved.
//

import UIKit

class EditPhotoViewController: UIViewController {
    
    var photoIndex:Int = 0
    var titlesArray = [String]()
    var contentsArray = [String]()
    var namesArray = [String]()
    var datesArray = [String]()
    
    @IBOutlet weak var photoTitle: UITextField!
    @IBOutlet weak var photoContent: UITextView!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBAction func textFieldEditing(_ sender: UITextField) {
        let datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(EditPhotoViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func done(_ sender: Any) {
        if photoContent.text?.characters.count == 0 {
            let alertController = UIAlertController(
                title: "Warning",
                message: "Content cannot be empty",
                preferredStyle: .alert
            )
            let okAction = UIAlertAction(
                title: "confirm?",
                style: .default,
                handler: {
                    (action: UIAlertAction!) -> Void in
                    print("confirm")
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
                title: "confirm?",
                style: .default,
                handler: {
                    (action: UIAlertAction!) -> Void in
                    print("confirm")
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
        
        titlesArray[photoIndex] = photoTitle.text!
        contentsArray[photoIndex] = photoContent.text
        datesArray[photoIndex] = dateTextField.text!
        
        var fileManager = FileManager.default
        var docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        var docUrl = docUrls.first
        
        var url = docUrl?.appendingPathComponent("photoTitles.txt")
        var titles = NSArray(contentsOf: url!)
        (titlesArray as NSArray).write(to: url!, atomically: true)
        
        url = docUrl?.appendingPathComponent("photoContents.txt")
        var contents = NSArray(contentsOf: url!)
        (contentsArray as NSArray).write(to: url!, atomically: true)
        
        url = docUrl?.appendingPathComponent("photoDates.txt")
        var dates = NSArray(contentsOf: url!)
        (datesArray as NSArray).write(to: url!, atomically: true)
        
        url = docUrl?.appendingPathComponent("photoNames.txt")
        var names = NSArray(contentsOf: url!)
        (namesArray as NSArray).write(to: url!, atomically: true)
        
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoContent.layer.borderColor =  UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        photoContent.layer.cornerRadius = 10;
        
        var fileManager = FileManager.default
        var docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        var docUrl = docUrls.first
        
        var url = docUrl?.appendingPathComponent("photoTitles.txt")
        var titles = NSArray(contentsOf: url!)
        if titles != nil {
            for title in titles! {
                titlesArray.append(title as! String)
            }
        }
        
        url = docUrl?.appendingPathComponent("photoContents.txt")
        var contents = NSArray(contentsOf: url!)
        if contents != nil {
            for content in contents! {
                contentsArray.append(content as! String)
            }
        }
        
        url = docUrl?.appendingPathComponent("photoDates.txt")
        var dates = NSArray(contentsOf: url!)
        if dates != nil {
            for date in dates! {
                datesArray.append(date as! String)
            }
        }
        
        url = docUrl?.appendingPathComponent("photoNames.txt")
        var names = NSArray(contentsOf: url!)
        if names != nil {
            for name in names! {
                namesArray.append(name as! String)
            }
        }
        
        url = docUrl?.appendingPathComponent(namesArray[photoIndex])
        photo?.image = UIImage(contentsOfFile: url!.path)
        
        
        print(photoIndex)
        
        photoTitle.text = titlesArray[photoIndex]
        photoContent.text = contentsArray[photoIndex]
        dateTextField.text = datesArray[photoIndex]
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


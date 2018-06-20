//
//  PhotoTableViewController.swift
//  ShipNote
//
//  Created by User03 on 2018/6/20.
//  Copyright © 2018年 User03. All rights reserved.
//

import UIKit

class PhotoTableViewController: UITableViewController {
    
    var titlesArray = [String]()
    var contentsArray = [String]()
    var namesArray = [String]()
    var datesArray = [String]()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.destination is PhotoDetailViewController {
            let controller = segue.destination as? PhotoDetailViewController
            let indexPath = tableView.indexPathForSelectedRow
            controller?.photoIndex = indexPath!.row
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        print("delete photo...")
        print(indexPath.row)
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
        titlesArray.remove(at: indexPath.row)
        (titlesArray as NSArray).write(to: url!, atomically: true)
        
        url = docUrl?.appendingPathComponent("photoContents.txt")
        var contents = NSArray(contentsOf: url!)
        var contentsArray = [String]()
        if contents != nil {
            for content in contents! {
                contentsArray.append(content as! String)
            }
        }
        contentsArray.remove(at: indexPath.row)
        (contentsArray as NSArray).write(to: url!, atomically: true)
        
        url = docUrl?.appendingPathComponent("photoDates.txt")
        var dates = NSArray(contentsOf: url!)
        var datesArray = [String]()
        if dates != nil {
            for date in dates! {
                datesArray.append(date as! String)
            }
        }
        datesArray.remove(at: indexPath.row)
        (datesArray as NSArray).write(to: url!, atomically: true)
        
        url = docUrl?.appendingPathComponent("photoNames.txt")
        var names = NSArray(contentsOf: url!)
        var namesArray = [String]()
        if names != nil {
            for name in names! {
                namesArray.append(name as! String)
            }
        }
        namesArray.remove(at: indexPath.row)
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
        
        self.viewDidAppear(true)
        //self.tableView.deleteRows(at:[indexPath], with: UITableViewRowAnimation.fade)
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("in photo did appear")
        
        titlesArray.removeAll()
        contentsArray.removeAll()
        namesArray.removeAll()
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
        
        /*print file*/
        for title in titlesArray {
            print(title)
        }
        for content in contentsArray {
            print(content)
        }
        for name in namesArray {
            print(name)
        }
        
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titlesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier:  "PhotoCell", for: indexPath) as! PhotoTableViewCell
        
        // Configure the cell...
        cell.photoTitle?.text = titlesArray[indexPath.row] as? String
        
        var fileManager = FileManager.default
        var docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        var docUrl = docUrls.first
        var url = docUrl?.appendingPathComponent(namesArray[indexPath.row])
        cell.photo?.image = UIImage(contentsOfFile: url!.path)
        
        return cell
    }
}

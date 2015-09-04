//
//  ViewController.swift
//  RemoveTableCell
//
//  Created by John Lima on 9/3/15.
//  Copyright © 2015 John Lima. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK:
    // MARK: properties
    @IBOutlet var table: UITableView!
    
    var tableData: NSMutableArray = NSMutableArray()
    var isTableEditing: Bool = false
    
    // MARK:
    // MARK: view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        getData()
        setView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:
    // MARK: actions
    func getData() {
        
        for var i=0; i < 20; i++ {
            tableData.addObject("row \(i+1)")
        }
        
        print("array: \(tableData)")
        
    }
    
    func setView() {
        
        if isTableEditing == true {
            createDoneButton()
        }else {
            createEditButton()
        }
        
        let background = UIView(frame: CGRectZero)
        table.tableFooterView = background
        table.backgroundColor = UIColor.whiteColor()
        
    }
    
    // buttons
    func createEditButton() {
        let editButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: "edit")
        navigationItem.rightBarButtonItems = [editButton]
    }
    
    func createDoneButton() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "done")
        navigationItem.rightBarButtonItems = [doneButton]
    }
    
    // actions
    func edit() {
        table.editing = true
        isTableEditing = true
        setView()
    }
    
    func done() {
        table.editing = false
        isTableEditing = false
        setView()
    }
    
    // MARK:
    // MARK: table view datasource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = tableData.objectAtIndex(indexPath.row) as? String
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            table.beginUpdates()
            tableData.removeObjectAtIndex(indexPath.row)
            table.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            table.endUpdates()
            print("table data: \(tableData)")
        }
        
    }
    
    // MARK:
    // MARK: table view delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        table.deselectRowAtIndexPath(indexPath, animated: true)
    }


}


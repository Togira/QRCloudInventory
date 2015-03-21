//
//  FolderSelectionTableViewController.swift
//  CloudInventory
//
//  Created by Bliss Chapman on 3/12/15.
//  Copyright (c) 2015 Bliss Chapman. All rights reserved.
//

import UIKit
import CoreData

class FolderSelectionTableViewController: ItemPageViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet var tableView: UITableView!
    var folders = [AnyObject]()
    
    //Values to preserve itemPageView attributes
//    var tempItemTitle: String?
//    var tempExistingItem: ItemCoreDataModel?
//    var tempNewItem: ItemCoreDataModel?
//    var tempItemSubtitle: ItemCoreDataModel?
//    var tempItemNotes: String?
//    var tempItemImage: UIImage?
//    var tempItemQRCodeNSData: NSData?
//    var tempFolderName: String?
    
    override func viewDidLoad() {
        //super.viewDidLoad()
        
//        tableView.clearsSelectionOnViewWillAppear = true
        reloadInfo()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadInfo", name: "Folder Created", object: nil)
    }
    
    func reloadInfo() {
        reloadData()
        self.tableView.reloadData()
    }
    
    func reloadData() {
        println("reload data called")
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext!
        let folderFrequency = NSFetchRequest(entityName: "Folder")
        
        var err: NSError?
        folders = context.executeFetchRequest(folderFrequency, error: &err)!
        
        if err != nil {
            println("Error = \(err?.description)")
        }
        
        if folders.count > 0 {
            var item = folders[0].name
        }
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folders.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        if let folder = self.folders[indexPath.row] as? FolderCoreDataModel {
            cell.textLabel?.text = folder.name
            if folder.name == folderName {
                cell.accessoryType = .Checkmark
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        folderName = ";lsadfja;ls"
        
        println("Name of the folder selected = \(folders[indexPath.row].name).  folderName now equals \(folderName)")
        //saveFolderName(folders[indexPath.row].name)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
//    func saveFolderName(folderName: String) {
//        let myAppDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        let myContext: NSManagedObjectContext = myAppDelegate.managedObjectContext!
//        let myEntity = NSEntityDescription.entityForName("InventoryItem", inManagedObjectContext: myContext)
//        let frequency = NSFetchRequest(entityName: "InventoryItem")
//        
//        if existingItem != nil { //updating existing item
//            println("The folder name to be saved: \(folderName)")
//            existingItem?.folder = folderName
//            println("The folder name that was saved: \(folderName)")
//        } else if existingItem == nil { //creating new item
//            newItem = ItemCoreDataModel(entity: myEntity!, insertIntoManagedObjectContext: myContext)
//            newItem?.folder = folderName
//        }
//        myContext.save(nil)
//    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //popover delegate
    override func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("about to segue with identifier \(segue.identifier)")
        if let identifier = segue.identifier {
            switch identifier {
            case "FolderCreation":
                if let vc = segue.destinationViewController as? FolderCreationViewController {
                    if let ppc = vc.popoverPresentationController {
                        ppc.delegate = self
                    }
                }
                
            default: break
            }
        }
    }
    
}
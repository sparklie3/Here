//
//  MasterViewController.swift
//  Here
//
//  Created by Test on 11/9/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

import UIKit


class MasterViewController: UITableViewController {
    
    @IBOutlet var rightButton: UIBarButtonItem!
    var dictMessg:NSDictionary!
    var arrayFinalNames: NSMutableArray!
    var objectID: NSMutableArray!
//    var numberNames: NSMutableArray! = NSMutableArray()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dictMessg = NSUserDefaults.standardUserDefaults().objectForKey("message") as NSDictionary
        println(dictMessg)
        let a = NSUserDefaults.standardUserDefaults().objectForKey("name") as NSMutableArray
        objectID = NSUserDefaults.standardUserDefaults().objectForKey("objectID") as NSMutableArray
        arrayFinalNames = NSMutableArray(array: a)
        objectID = NSMutableArray(array: objectID)
        NSUserDefaults.standardUserDefaults().removeObjectForKey("name")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("objectID")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("message")
        //println(arrayFinalNames)
        //println(arrayFinalNames.count)
        //arrayFinalNames.removeAllObjects()
        //println(objectID[0])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = dictMessg.valueForKey(toString(arrayFinalNames[indexPath.row])) as String
            (segue.destinationViewController as DetailViewController).detailItem = object
            }
        }
    }
    


    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 10
        //let v = dictMessg["fromID"] as String
        return arrayFinalNames.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        cell.textLabel.text = arrayFinalNames[indexPath.row] as? String
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            arrayFinalNames.removeObjectAtIndex(indexPath.row)
            var query = PFQuery(className: "NewMessage")
            query.whereKey("userID", equalTo: "Shaw")
            var a = objectID[indexPath.row] as String
            objectID.removeObjectAtIndex(indexPath.row)
            //println(a)
            query.getObjectInBackgroundWithId(a) {
                (object: PFObject!, error:NSError!) -> Void in
                if error != nil {
                    println("something equals nil")
                }
                else {
                    println(object)
                    object.deleteInBackgroundWithTarget(nil, selector: nil)
                }
            }
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}


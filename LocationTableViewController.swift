//
//  LocationTableViewController.swift
//  Here
//
//  Created by Test on 11/16/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

import UIKit



class LocationTableViewController: UITableViewController/*LoginViewControllerDelegate*/ {

    var contactName: String!
    var message: String!
    var emailDic: NSMutableDictionary!
    
    var major: Int!
    var minor: Int!
    
/*
    func LoginVC(controller: LoginViewController, text: String) {
        <#code#>
    }*/
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //println(contactName)
        //println(message)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }


    @IBAction func sendMessage(sender: AnyObject) {
        
        var saveMessage = PFObject(className:"NewMessage")
        if NSUserDefaults.standardUserDefaults().objectForKey("userID") == nil {
            saveMessage["fromID"] = "Mystery User"        }
        else{
            saveMessage["fromID"] = NSUserDefaults.standardUserDefaults().objectForKey("userID") as String
        }
        saveMessage["message"] = message
        saveMessage["userID"] = contactName
        saveMessage["uuid"] = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
        saveMessage["major"] = 65535
        saveMessage["minor"] = 0
        saveMessage["phone"] = 0000000000
        saveMessage["email"] = emailDic.valueForKey(contactName)
        saveMessage.saveInBackgroundWithTarget(nil, selector: nil)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell

        cell.textLabel.text = "Cornell Studio"

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ContactsViewController.swift
//  Here
//
//  Created by Test on 11/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

import UIKit
import AddressBook

class ContactsViewController: UITableViewController {


    var messageInfo: String!  // passing in the message from MVC
    
    //var emailAddress: String!
    //let lastName: String!
    //var emailDic:String!
    
    var finalArrayName: NSMutableArray! = ["Shaw","Geng","Paul","Faiyam","Claire","Rachel","Gokul"]
    
    //var emailAddress: [String?] = []
    var finalDictionaryEmail: NSMutableDictionary! = ["Shaw":"shaw.s.li@gmail.com","Geng":"gt286@cornell.edu","Paul":"pwl46@cornell.edu","Faiyam":"fhr25@cornell.edu","Claire":"cll42@cornell.edu","Rachel":"rw488@cornell.edu","Gokul":"gs585@cornell.edu"]
   
    //var finalDictionaryPhone: NSMutableDictionary! = [:]
    //var contact: [String:String] = [:]
    
    var contactList: NSArray = []
    var contactName: String!
    var emailAdd: String!
    //var phoneAdd: Int
    

    func getContactNames()
    {
        var error: Unmanaged<CFError>?
        var addressbook: ABAddressBookRef = ABAddressBookCreateWithOptions(nil, &error).takeRetainedValue()
        
        contactList = ABAddressBookCopyArrayOfAllPeople(addressbook).takeRetainedValue()
        //println(contactList) //Everything in contactList is just in PRecord format, not actual string or data
        
        for record:ABRecordRef in contactList {
            var contactPerson: ABRecordRef = record
            
            contactName = ABRecordCopyCompositeName(contactPerson)?.takeRetainedValue() as String?
            println(contactName)
            var emailArray: ABMultiValueRef = ABRecordCopyValue(contactPerson, kABPersonEmailProperty).takeRetainedValue()
            //var phoneArray: ABMultiValueRef = ABRecordCopyValue(contactPerson, kABPersonPhoneProperty).takeRetainedValue()
            if contactName != nil {
                println(contactName)
                for (var j = 0; j < ABMultiValueGetCount(emailArray); j++)
                {
                    emailAdd = ABMultiValueCopyValueAtIndex(emailArray, j)?.takeRetainedValue() as String?
                    println(emailAdd)
                    finalDictionaryEmail.setValue(emailAdd, forKey: contactName)
                    finalArrayName.addObject(contactName)
                }
                
            }


           
            
        }
        println(finalArrayName)
        println(finalDictionaryEmail)
    }
    
    var adbk : ABAddressBookRef = {
        var error:Unmanaged<CFError>?
        return ABAddressBookCreateWithOptions(nil, &error).takeRetainedValue() as ABAddressBookRef}()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        switch ABAddressBookGetAuthorizationStatus(){
            case .Authorized:
                println("already authorized")
               self.getContactNames()
            case .Denied, .NotDetermined, .Restricted:
                ABAddressBookRequestAccessWithCompletion(adbk) {granted, error in
                if !granted {
                    var alert = UIAlertController(title: "Uh-oh", message: "You have to give permission for contacts to show.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else {
                    self.getContactNames()
                }
            }
        }
        
        */
        
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return finalArrayName.count
        //return 7
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        cell.textLabel.text = finalArrayName[indexPath.row] as? String
        //cell.detailTextLabel.text = "hello"
        println(finalDictionaryEmail)
        return cell
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPlaces" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = finalArrayName[indexPath.row] as String
                (segue.destinationViewController as LocationTableViewController).contactName = object
                (segue.destinationViewController as LocationTableViewController).message = messageInfo
                (segue.destinationViewController as LocationTableViewController).emailDic = finalDictionaryEmail
                //(segue.destinationViewController as LocationTableViewController).phoneDic = finalDictionaryPhone
            }
        }
    }

}

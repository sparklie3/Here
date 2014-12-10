//
//  MessageViewController.swift
//  Here
//
//  Created by Test on 11/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

import UIKit
import AddressBook

class MessageViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet var messageField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        messageField.delegate = self
        messageField.becomeFirstResponder()
        
        /*
        switch ABAddressBookGetAuthorizationStatus(){
        case .Authorized:
            println("already authorized")
        case .Denied, .NotDetermined, .Restricted:
            var adbk : ABAddressBookRef = {
                var error:Unmanaged<CFError>?
                return ABAddressBookCreateWithOptions(nil, &error).takeRetainedValue() as ABAddressBookRef}()
            ABAddressBookRequestAccessWithCompletion(adbk) {granted, error in
                if !granted {
                    var alert = UIAlertController(title: "Uh-oh", message: "You have to give permission for contacts to show.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }

        }*/

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showContacts" {
                let object = messageField.text as String
                (segue.destinationViewController as ContactsViewController).messageInfo = object
            
        }
    }

}

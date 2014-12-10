//
//  TableView.swift
//  Here
//
//  Created by Test on 11/16/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

import UIKit
import AddressBook

class TableView: UITableView {

    var email:String!
    var contact: [String:String] = [:]
    var adbk : ABAddressBookRef = {
        var error:Unmanaged<CFError>?
        return ABAddressBookCreateWithOptions(nil, &error).takeRetainedValue() as ABAddressBookRef}()
    
    
    
    
    func readAllPeopleInAddressBook(addressBook: ABAddressBookRef){
        let allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue() as NSArray
        
        for person: ABRecordRef in allPeople{
            let firstName = ABRecordCopyValue(person,kABPersonFirstNameProperty).takeRetainedValue() as String
            let lastName = ABRecordCopyValue(person, kABPersonLastNameProperty).takeRetainedValue() as String
            let fullName = firstName + " " + lastName
            let emails: ABMultiValueRef = ABRecordCopyValue(person, kABPersonEmailProperty).takeRetainedValue()
            
            for counter in 0..<ABMultiValueGetCount(emails){
                let email = ABMultiValueCopyValueAtIndex(emails, counter).takeRetainedValue() as String
                
            }
            println(fullName)
            
            
        }
    }
    
    func determineStatusx () -> Bool {
        switch ABAddressBookGetAuthorizationStatus(){
        case .Authorized:
            println("already authorized")
            readAllPeopleInAddressBook(adbk)
        case .Denied:
            println("denied acces")
        case .NotDetermined:
            println("not determine")
        case .Restricted:
            println("Access is Restricted")
        }
        return true
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

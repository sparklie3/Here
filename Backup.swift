//
//  Backup.swift
//  Here
//
//  Created by Test on 11/10/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

import Foundation


//From LoginVC

//class LoginViewController: UIViewController, ESTBeaconManagerDelegate {

//let beaconManager : ESTBeaconManager = ESTBeaconManager()
//let region : ESTBeaconRegion = ESTBeaconRegion(proximityUUID: uuid, identifier: "Estimote Region")

//the reason the above code is commented out is because I can't get the EST to work, which is why I imported CoreLocation

/*    override func viewDidLoad() {
super.viewDidLoad()
NSLog("view did load")
/*CLLocationManager().requestAlwaysAuthorization()

switch CLLocationManager.authorizationStatus() {
case .Authorized, .AuthorizedWhenInUse:
println("Authorized")
case .NotDetermined:
println("ND")
case .Restricted:
println("Restricted")
case .Denied:
println("Denied")
}*/

ESTBeaconManager().requestAlwaysAuthorization()
switch ESTBeaconManager.authorizationStatus(){
case .Authorized, .AuthorizedWhenInUse:
println("ESTAuthorized")
case .NotDetermined:
println("ESTND")
case .Restricted:
println("ESTRestricted")
case .Denied:
println("ESTDenied")
}


beaconManager.delegate = self




}


override func viewDidDisappear(animated: Bool) {
NSLog("view did disappear")
//beaconManager.stopMonitoringForRegion(region)
}
override func didReceiveMemoryWarning() {
super.didReceiveMemoryWarning()
// Dispose of any resources that can be recreated.
}

func startMonitoring(manager: ESTBeaconManager!, didStartMonitoringForRegion region: ESTBeaconRegion!) {
beaconManager.startMonitoringForRegion(region)
beaconManager.startRangingBeaconsInRegion(region)
println("starting monitor ")

}

func discoverBeacons(manager: ESTBeaconManager!, didDiscoverBeacons beacons: [ESTBeacon]!, inRegion region: ESTBeaconRegion!) {
println("found beacon")

}


func beaconManagermanager: ESTBeaconManager!,didRangeBeacons beacons:[AnyObject]!,inRegion:ESTBeaconRegion!){
// println("I've found \(didRangeBeacons.count) beacons in range")
if let beaconsArray = beacons as? [ESTBeacon] {
for var i = 0; i < beaconsArray.count; ++i {
let beacon = beaconsArray[i]

switch i {
case 0:
accuracy1.text = String(format: "%.2f", beacon.description)
case 1:
accuracy2.text = String(format: "%.2f", beacon.major)
case 2:
accuracy3.text = String(format: "%.2f", beacon.minor)
default:
println("default")
}
}

}
}
func failDiscover(manager: ESTBeaconManager!, didFailDiscoveryInRegion region: ESTBeaconRegion!) {
println("failed in region")
}

func failMonitor(manager: ESTBeaconManager!, monitoringDidFailForRegion region: ESTBeaconRegion!, withError error: NSError!) {
println("failed in monitorinf for region")
}
func syaHello(){
print("Say Hello")
}

@IBAction func checkMessage(sender: AnyObject) {
println("RunRun")
//startMonitoring(beaconManager, didStartMonitoringForRegion: region)
//foundBeacon(beaconManager, [AnyObject], region)
}



// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
// Get the new view controller using segue.destinationViewController.
// Pass the selected object to the new view controller.
}


override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
let secondVC = segue.destinationViewController as MainUINavController
secondVC.name = "Will"
secondVC.message = "message"
//println(secondVC.name)

}
*/

/*query.getFirstObjectInBackgroundWithBlock{(objects: PFObject!, error: NSError!) -> Void in
if error == nil {
println("\(objects)")
manager.stopRangingBeaconsInRegion(region)
manager.stopMonitoringForRegion(region)
let from = objects["fromID"] as String
let message = objects["message"] as String
//let mVC = MasterViewController()
//println(from)
//mVC.name = "hello"
//mVC.message = message
//I don't know how to pass the data from one view controller to the next so I am using storage on the device
NSUserDefaults.standardUserDefaults().setObject(from, forKey: "name")
NSUserDefaults.standardUserDefaults().setObject(message, forKey: "message")
NSUserDefaults.standardUserDefaults().synchronize()

}
else {
println("error")
}

}*/

/*
if let beaconsArray = beacons as? [CLBeacon] {
for var i = 0; i < beaconsArray.count; ++i {
let beacon = beaconsArray[i]

switch i {
case 0:
//let number1 = accuracy1?.text?.toInt()
accuracy1?.text? = "\(beacon.major)"
case 1:
accuracy2?.text? = "\(beacon.minor)"
case 2:
accuracy3.text = String(format: "%.2f", beacon.accuracy)
default:
println("what does this mean")
}
}
}*/


//BACKUP From MasterVC

//var name:String!
//var message:String!


// Do any additional setup after loading the view, typically from a nib.
//  let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertName:")
//self.navigationItem.leftBarButtonItem = addButton

//println(arrayNames)
//        println(toString(arrayNames[0]))

//for var i = 0; i < arrayNames.count-1; ++i {
//println(arrayNames[0].userId)

//var name:String! = NSUserDefaults.standardUserDefaults().stringForKey("name")
//var message:String! = NSUserDefaults.standardUserDefaults().stringForKey("message")
//numberNames = [name,message]
//println(numberNames.count)
//println(numberNames[0])

/*
func insertName(sender: AnyObject) {
numberNames.insertObject(bigNames, atIndex: 0)
let indexPath = NSIndexPath(forRow: 0, inSection: 0)
self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
}*/


//let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

/*let names = [
NSUserDefaults.standardUserDefaults().stringForKey("name"),
NSUserDefaults.standardUserDefaults().stringForKey("message")
]*/
/*
for name in names {
//                cell.textLabel.text = name
println("hello \(name)")
}
*/
//        let start = 0
//        println(numberNames[0])


//let object = numberNames[indexPath.row] as NSMutableArray


//        cell.textLabel.text = toString(numberNames[0])
/*
for person: ABRecordRef in allPeople{
    let a = ABRecordCopyValue(person,kABPersonFirstNameProperty)?.takeRetainedValue() as String?
    let b = ABRecordCopyValue(person,kABPersonLastNameProperty)?.takeRetainedValue() as String?
    let c: ABMultiValueRef? = ABRecordCopyValue(person, kABPersonEmailProperty)?.takeRetainedValue() as ABMultiValueRef?
    
    if a != nil {
        firstName = ABRecordCopyValue(person,kABPersonFirstNameProperty).takeRetainedValue() as String
        println(firstName)
        //firstName = ""
        
    } else {
        firstName = ""
        println(firstName)
    }
    
    if b != nil{
        lastName = ABRecordCopyValue(person,kABPersonLastNameProperty).takeRetainedValue() as String
        println(lastName)
    }
    else {
        lastName = ""
        println(lastName)
    }
    
    if c != nil{
        
        var emails: ABMultiValueRef = ABRecordCopyValue(person, kABPersonEmailProperty).takeRetainedValue()
        /*
        if (ABMultiValueGetCount(emails) > 0) {
        let index = 0 as CFIndex
        emailAddress.append(ABMultiValueCopyValueAtIndex(emails, index).takeRetainedValue()? as String)
        
        println(emailAddress)
        } else {
        println("No email address")
        }
        
        */
        for counter in 0..<ABMultiValueGetCount(emails){
            email = ABMultiValueCopyValueAtIndex(emails, counter).takeRetainedValue() as String
        }
        
        println(email)
    }
        
    else {
        email = ""
        println(email)
    }
    /*
    if d != nil{
    var phones: ABMultiValueRef = ABRecordCopyValue(person, kABPersonPhoneProperty).takeRetainedValue()
    
    for counter in 0..<ABMultiValueGetCount(phones){
    phone = ABMultiValueCopyValueAtIndex(phones, counter).takeRetainedValue() as String
    
    }}
    else {
    phone = "0000000000"
    }
    */
    
    let fullName: String! = (firstName + " " + lastName)
    finalArrayName.addObject(fullName)
    finalDictionaryEmail.setObject(email, forKey: fullName)
    //finalDictionaryPhone.setObject(phone, forKey: fullName)
    //println(fullName)
    //println(finalDictionaryEmail)
}
}

func readAllPeopleInAddressBook(addressBook: ABAddressBookRef){
    let allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue() as NSArray
    var firstName: String!
    var lastName: String!
    var email: String!
    var phone: String!

*/

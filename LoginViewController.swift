//
//  LoginViewController.swift
//  Here
//
//  Created by Test on 11/9/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

let uuid = NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")

class LoginViewController: UIViewController, CLLocationManagerDelegate, CBCentralManagerDelegate  {
    
    @IBOutlet weak var detailViewController: DetailViewController!
    @IBOutlet var passWord: UITextField!
    @IBOutlet var userName: UITextField!
    @IBOutlet var loginInfo: UILabel!
    @IBOutlet var beaconInfo: UILabel!
    @IBOutlet var label3: UILabel!
    
    var cManager: CBCentralManager!
    var lastProximity: CLProximity?
    
    let manager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: uuid, identifier: "Estimote Region")
    var beaconSuccess: String!
    var beaconMajor: Int!
    
   
    @IBAction func loginButton(sender: AnyObject) {
        
        
        var user_name = self.userName.text as String
        
        if user_name == "Email" || user_name == ""{
            self.loginInfo.text = "You didn't type an email"
        } else if user_name.rangeOfString("@") == nil{
            self.loginInfo.text = "Not a valid email"
        }
        else {
            println("Successful Login")
            NSUserDefaults.standardUserDefaults().setObject(user_name, forKey: "userID")
            NSUserDefaults.standardUserDefaults().synchronize()
        
            var user_nameArray = user_name.componentsSeparatedByString("@")
            var username = user_nameArray[0]
            PFUser.logInWithUsernameInBackground(username, password: passWord.text){
                (user:PFUser!, error:NSError!) -> Void in
                if error == nil {
                    var query = PFQuery(className: "NewMessage")
                    query.whereKey("email", equalTo: self.userName.text)
                    query.whereKey("major", equalTo: self.beaconMajor)
                    //query.whereKey("major", equalTo: 65535)
                    //This beacon major must be replaced with what's found
                    println(self.userName.text)
                    query.findObjectsInBackgroundWithBlock{(objects: [AnyObject]!,error:NSError!) -> Void in
                        //println(objects)
                        //println(error)
                        var arrayNames: [String] = []
                        var objectID: [String] = []
                        var dictionaryName: [String:String] = [:]
                        if error == nil {
                            for object in objects{
                                arrayNames.append((object["fromID"] as String))
                                objectID.append(object.objectId as String)
                                dictionaryName.updateValue(object["message"] as String, forKey: object["fromID"] as String)
                                dictionaryName.updateValue(object.objectId as String, forKey: object["message"] as String)
                            }
                            println(arrayNames)
                            println(dictionaryName)
                            println(objectID)
                            //NSUserDefaults.resetStandardUserDefaults()

                            
                            NSUserDefaults.standardUserDefaults().setObject(arrayNames, forKey: "name")
                            NSUserDefaults.standardUserDefaults().setObject(objectID, forKey: "objectID")
                            NSUserDefaults.standardUserDefaults().setObject(dictionaryName, forKey: "message")
                            NSUserDefaults.standardUserDefaults().synchronize()
                            //self.detailViewController.test = "hello"
                            let navVC = UIStoryboard(name:"Main", bundle:nil).instantiateViewControllerWithIdentifier("mainNav") as UINavigationController
                            //the above code, I have to first assign a constant from the storyboard named "Main" 		and then initiate the view
                            self.presentViewController(navVC, animated: true, completion: nil)
                            //I then present the view
                        } else {
                            //println("error login")
                            self.loginInfo.text = "Something went wrong at Parse"
                        }
                    }
                } else {
                    self.loginInfo.text = "Wrong username and password."
                }
            }
        }
    }
    
    @IBAction func registerButton(sender: AnyObject) {
        var user = PFUser()
        var user_name = self.userName.text as String
        if user_name == "Email" || user_name == "" {
            self.loginInfo.text = "You didn't type an email"
        } else if user_name.rangeOfString("@") == nil{
            self.loginInfo.text = "Not a valid email"
        }
        else {
            var user_nameArray = user_name.componentsSeparatedByString("@")
            user.username = user_nameArray[0]
            user.password = passWord.text
            user.email = userName.text
            user.signUpInBackgroundWithBlock{(succeed: Bool!, error:NSError!) -> Void in
                if error == nil {
                    var query = PFQuery(className: "NewMessage")
                    query.whereKey("email", equalTo: self.userName.text)
                    //query.whereKey("major", equalTo: self.beaconMajor)
                    //This beacon major must be replaced with what's found
                    println(self.userName.text)
                    query.findObjectsInBackgroundWithBlock{(objects: [AnyObject]!,error:NSError!) -> Void in
                        //println(objects)
                        //println(error)
                        var arrayNames: [String] = []
                        var objectID: [String] = []
                        var dictionaryName: [String:String] = [:]
                        if error == nil {
                            for object in objects{
                                arrayNames.append((object["fromID"] as String))
                                objectID.append(object.objectId as String)
                                dictionaryName.updateValue(object["message"] as String, forKey: object["fromID"] as String)
                                dictionaryName.updateValue(object.objectId as String, forKey: object["message"] as String)
                            }
                            println(arrayNames)
                            println(dictionaryName)
                            println(objectID)
                            //NSUserDefaults.resetStandardUserDefaults()
                            
                            
                            NSUserDefaults.standardUserDefaults().setObject(arrayNames, forKey: "name")
                            NSUserDefaults.standardUserDefaults().setObject(objectID, forKey: "objectID")
                            NSUserDefaults.standardUserDefaults().setObject(dictionaryName, forKey: "message")
                            NSUserDefaults.standardUserDefaults().synchronize()
                            //self.detailViewController.test = "hello"
                            let navVC = UIStoryboard(name:"Main", bundle:nil).instantiateViewControllerWithIdentifier("mainNav") as UINavigationController
                            //the above code, I have to first assign a constant from the storyboard named "Main" 		and then initiate the view
                            self.presentViewController(navVC, animated: true, completion: nil)
                            //I then present the view
                        }
                            else {
                                self.loginInfo.text = "Something went wrong with the registration."
                                //println(error)
                        }
                    }
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //println("view did load")
        if NSUserDefaults.standardUserDefaults().objectForKey("userID") == nil {
            println("No defaul username")
        }
        else{
            userName.text = NSUserDefaults.standardUserDefaults().objectForKey("userID") as String
        }

        manager.delegate = self
        //region.notifyOnEntry = true
        //region.notifyOnExit = true
        //region.notifyEntryStateOnDisplay = true
        
        switch CLLocationManager.authorizationStatus() {
        case .Authorized, .AuthorizedWhenInUse:
            println("Authorized")
            manager.startMonitoringForRegion(region)
            manager.startRangingBeaconsInRegion(region)
        case .NotDetermined, .Restricted, .Denied:
            println("Not determined, Restricted, or Denied")
            if manager.respondsToSelector(Selector("requestWhenInUseAuthorization"))
            {
                manager.requestAlwaysAuthorization()
            }
            manager.startMonitoringForRegion(region)
            manager.startRangingBeaconsInRegion(region)
        
        
            cManager = CBCentralManager(delegate: self, queue: nil)
        
        }

    }
    
    override func viewDidDisappear(animated: Bool) {
        println("view did disappear")
        manager.stopMonitoringForRegion(region)
        manager.stopRangingBeaconsInRegion(region)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func centralManagerDidUpdateState(central: CBCentralManager!){
        switch cManager.state {
        case .PoweredOff:
            println("off")
            //var alert = UIAlertController(title: "Uh-oh", message: "You don't have bluetooth on so the app can't work", preferredStyle: UIAlertControllerStyle.Alert)
            //alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            //self.presentViewController(alert, animated: true, completion: nil)
        case .Unknown:
            println("unknown")
        case .Resetting:
            println("resetting")
        case .Unsupported:
            println("unsupported")
            //var alert = UIAlertController(title: "No Support", message: "You don't support bluetooth  so the app can't work", preferredStyle: UIAlertControllerStyle.Alert)
            //alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            //self.presentViewController(alert, animated: true, completion: nil)
        case .Unauthorized:
            println("no authorization")
        case .PoweredOn:
            println("on power")
    
        }
    }
    
    /*func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch CLLocationManager.authorizationStatus() {
        case .Authorized, .AuthorizedWhenInUse:
            println("CL Authorization status is now - Authorized")
            manager.startMonitoringForRegion(region)
            manager.startRangingBeaconsInRegion(region)
        case .NotDetermined:
            println("CL Authorization status is now - Not determined")
        case .Restricted, .Denied:
            println("CL Authorization status is now - Restricted")
        }
    }*/
    
    
    func locationManager(manager: CLLocationManager!, didStartMonitoringForRegion region: CLRegion!) {
        println("Did start monitoring for region")
        //println(region)
        self.label3.text = "You've started monitoring for region"
        //println(region)
        
    }
    /*
    func locationManager(manager: CLLocationManager!, didDetermineState state: CLRegionState, forRegion region: CLRegion!) {
        println(state)
        println(region)
        
        
    }
    
    func locationManager(manager: CLLocationManager!, monitoringDidFailForRegion region: CLRegion!, withError error: NSError!) {
        println(error)
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        println("I've exited the region")
        self.beaconInfo.text = "exited region"
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        println("Did enter region!")
        self.beaconInfo.text = "You've entered a region."
        
        if region.identifier == "Estimote Region" {
            var query = PFQuery(className: "NewMessage")
            query.whereKey("userID", equalTo: userName.text)
            query.findObjectsInBackgroundWithBlock{(objects: [AnyObject]!,error:NSError!) ->
                Void in
                //print(objects)
                var arrayNames: [String] = []
                var objectID: [String] = []
                var dictionaryName: [String:String] = [:]
                if error == nil {
                    for object in objects{
                        arrayNames.append((object["fromID"] as String))
                        objectID.append(object.objectId as String)
                        dictionaryName.updateValue(object["message"] as String, forKey: object["fromID"] as String)
                        dictionaryName.updateValue(object.objectId as String, forKey: object["message"] as String)
                    }
                    println(dictionaryName)
                    println(objectID)
                    NSUserDefaults.standardUserDefaults().setObject(arrayNames, forKey: "name")
                    NSUserDefaults.standardUserDefaults().setObject(objectID, forKey: "objectID")
                    NSUserDefaults.standardUserDefaults().setObject(dictionaryName, forKey: "message")
                    NSUserDefaults.standardUserDefaults().synchronize()
                }
                else {
                    println(error)
                }
                
            }
        }
    }
    */
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        println("didRangeBeacaons")
        
        if let beaconsArray = beacons as? [CLBeacon] {
            for var i = 0; i < beaconsArray.count; ++i {
                let beacon = beaconsArray[i]
                self.beaconInfo.text = ("Major # \(toString(beacon.major))")
                beaconMajor = toString(beacon.major).toInt()
            }
        }
    }
}

//
//  AppDelegate.swift
//  Here
//
//  Created by Test on 11/9/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain


class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
    
    var window: UIWindow?
    //var lastProximity: CLProximity?
    var manager: CLLocationManager?
    var userName: String!
    var beaconMajor: Int!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        Parse.setApplicationId("g9e3igfoMZ8ELbwyvuXFYeX9zzuQFcMmjWIR5aSe", clientKey:"vWPnGiu59HuTrsF7AHV7HXORcPpXlgA1QoMbJg5o")
        
        // need to replace with Will's Ystm7t6FNw3HxqPoHGY1a3OmiYhRiexwjXv1DCwL clientKey zSZJx66ibdPsuG5ptDHIiAj3tgLan4qWihR5lacW
        
        let uuid = NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")
        let identifier = "Estimote Beacon"
        let region: CLBeaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: identifier)
        
        manager = CLLocationManager()
        if (manager!.respondsToSelector("requestAlwaysAuthorization")) {
            manager!.requestAlwaysAuthorization()
        
        }
        manager!.delegate = self
        manager!.pausesLocationUpdatesAutomatically = false
        
        manager!.startMonitoringForRegion(region)
        manager!.startRangingBeaconsInRegion(region)
        manager!.startUpdatingLocation()
        
        
        if application.respondsToSelector("registerUserNotificationSettings:") {
            application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes:  UIUserNotificationType.Alert | UIUserNotificationType.Sound, categories: nil))
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}

extension AppDelegate: CLLocationManagerDelegate {
    func sendLocalNotificationWithMessage(message: String!) {
        let notification: UILocalNotification = UILocalNotification()
        notification.alertBody = message
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        println("didrangebeacon")

        if let beaconsArray = beacons as? [CLBeacon] {
            for var i = 0; i < beaconsArray.count; ++i {
                let beacon = beaconsArray[i]
                //self.beaconInfo.text = ("Major # \(toString(beacon.major))")
                beaconMajor = toString(beacon.major).toInt()
            }
        }

        
        if NSUserDefaults.standardUserDefaults().objectForKey("userID") == nil {
            userName = ""
        }
        else{
            userName = NSUserDefaults.standardUserDefaults().objectForKey("userID") as String
        }

        
        var message: String = ""
        var query = PFQuery(className: "NewMessage")
        query.whereKey("userID", equalTo: userName)
        query.whereKey("major", equalTo: self.beaconMajor)
        //println(userName)
        query.findObjectsInBackgroundWithBlock{(objects: [AnyObject]!,error:NSError!) ->
            Void in
            if error == nil {
                println("success")
                message = "You have a message"
                for (var a = 0; a < 5; a++) {
                    self.sendLocalNotificationWithMessage(message)
                }
                manager.stopRangingBeaconsInRegion(region)
            }else {
                println("error")
                return
            }
        }

        
        
    }
}



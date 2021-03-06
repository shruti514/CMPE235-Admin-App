//
//  AppDelegate.swift
//  CMPE235-SmartStreet
//
//  Created by Shrutee Gangras on 2/25/16.
//  Copyright © 2016 Shrutee Gangras. All rights reserved.
//

import UIKit
import GoogleMaps
import Parse
import FBSDKCoreKit
import FBSDKLoginKit
import ParseFacebookUtilsV4


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    //var directionsAPI: GoogleDirections!
    //let ref = Firebase(url: "https://sweltering-inferno-8277.firebaseio.com/")
    let facebookLogin = FBSDKLoginManager()
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("AIzaSyBUf-BSDFWvv35UDrVyAXWWr7UzezPbxQw")
     //   directionsAPI = GoogleDirections(apiKey: "AIzaSyBob-IeBDk1h-1lPGC2Gw_u6pjEkRz59t8")
        
        Parse.enableLocalDatastore()
        
        // Initialize Parse.
        Parse.setApplicationId("exH6mq5Enw1gxPPYP4aN6e1mYrhkyVm7oKeoG057", clientKey:"H3S5MJsy3nxskKMoHqY0CQZ7SHODFS49bSAjGjtj")
        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
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
        FBSDKAppEvents.activateApp()
        
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, openURL url: NSURL,
                     sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance()
            .application(application, openURL: url,
                         sourceApplication: sourceApplication, annotation: annotation)
    }
    
    override init() {
        super.init()
        // Firebase.defaultConfig().persistenceEnabled = true
    }
    
    
    
}


//
//  AppDelegate.swift
//  VKHackathon
//
//  Created by Mikhail Lutskiy on 09/11/2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit
import OneSignal
import NMAKit
import RealmSwift

let realm = try! Realm()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let kHelloMapAppID = "fwDWDINdcDi9PzFeiUGr"
        let kHelloMapAppCode = "no2BYFddc6ZZ6o3puOyG1Q"
        let kHelloMapLicenseKey = "BRW6LrIp65YzRdw7sGTmrT6SaPmRA5n1pYdL5Ou8f2kNfm/Su2AVSoznMUupj311ku94LfQhjLvoL+Xquq7LrDr91NnMMLw2hX5rThKMHvGR3UyJH9X/hLK/uub8ER+I5Te2efBjQDnlNZiGl4ZlxZ9NTYIFFwbsOVdBOAi1ouibO1X7d2oIgTbveT5lCaMhcrwk8L1OGv7c2qHTU5GY2sNcuIO7hBOxG8D6hN0ibrsCmFL78voLboJBQwynVKN4AekR5/8wvCHKHdA6QZsN0cvflYmDFnWPfq2Suuxssn/mGAt3cxdApU2zTcS3xPgjyEM2zdXEpnBhNxNlcOD8Wh61hcYY+0DyvZ67Lbv2jvylW8iPeJRTp+MgozsXX95Qkzn13du5ZZyZmC4bHZ99MBu61XvC6XP+/9+rxRHpmdyFHYIEUZEzriOXO5Z6MfR8MgNs4n+2Bj3vlopy+mIuEdvcVvRXW5dguyK2KIAmKBdG1F23IDegghnWtMKXpefzo8L32/vSVTVCyib7qr1Rj1H5IxpDG0aXW8DV1sn70fCCBX6Z5PlrvvS/Xut7q2O1yJ9D6ggSjTZwpQyt8Vg+dS+iVbdmxxuQtSL95UU5APWR+erqkdBg2Lma3lEvb0sAb7LNgoBAe4tQEjaRmpppEJdo8jxgue5DFx95mQIbdeI="
        
        let error =  NMAApplicationContext.setAppId(kHelloMapAppID,
                                                    appCode: kHelloMapAppCode,
                                                    licenseKey: kHelloMapLicenseKey)
        assert(error == NMAApplicationContextError.none)
        
        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]
        
        // Replace 'YOUR_APP_ID' with your OneSignal App ID.
        OneSignal.initWithLaunchOptions(launchOptions,
                                        appId: "fde22b87-44a3-44af-8020-d8c5f8e4ca42",
                                        handleNotificationAction: nil,
                                        settings: onesignalInitSettings)
        
        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;
        
        // Recommend moving the below line to prompt for push after informing the user about
        //   how your app will use them.
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
        })
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


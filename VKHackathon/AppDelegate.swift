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
        Migration.applyMigration()

        let kHelloMapAppID = "fwDWDINdcDi9PzFeiUGr"
        let kHelloMapAppCode = "no2BYFddc6ZZ6o3puOyG1Q"
        let kHelloMapLicenseKey = "BRW6LrIp65YzRdw7sGTmrT6SaPmRA5n1pYdL5Ou8f2kNfm/Su2AVSoznMUupj311ku94LfQhjLvoL+Xquq7LrDr91NnMMLw2hX5rThKMHvGR3UyJH9X/hLK/uub8ER+I5Te2efBjQDnlNZiGl4ZlxZ9NTYIFFwbsOVdBOAi1ouibO1X7d2oIgTbveT5lCaMhcrwk8L1OGv7c2qHTU5GY2sNcuIO7hBOxG8D6hN0ibrsCmFL78voLboJBQwynVKN4AekR5/8wvCHKHdA6QZsN0cvflYmDFnWPfq2Suuxssn/mGAt3cxdApU2zTcS3xPgjyEM2zdXEpnBhNxNlcOD8Wh61hcYY+0DyvZ67Lbv2jvylW8iPeJRTp+MgozsXX95Qkzn13du5ZZyZmC4bHZ99MBu61XvC6XP+/9+rxRHpmdyFHYIEUZEzriOXO5Z6MfR8MgNs4n+2Bj3vlopy+mIuEdvcVvRXW5dguyK2KIAmKBdG1F23IDegghnWtMKXpefzo8L32/vSVTVCyib7qr1Rj1H5IxpDG0aXW8DV1sn70fCCBX6Z5PlrvvS/Xut7q2O1yJ9D6ggSjTZwpQyt8Vg+dS+iVbdmxxuQtSL95UU5APWR+erqkdBg2Lma3lEvb0sAb7LNgoBAe4tQEjaRmpppEJdo8jxgue5DFx95mQIbdeI="
        
        let error =  NMAApplicationContext.setAppId(kHelloMapAppID,
                                                    appCode: kHelloMapAppCode,
                                                    licenseKey: kHelloMapLicenseKey)
        assert(error == NMAApplicationContextError.none)
        
        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]
        
        let notificationOpenedBlock: OSHandleNotificationActionBlock = { result in
            NotificationTrackerSingleton.shared.isTrackLocation = false
            NotificationTrackerSingleton.shared.sendingToServer()
                let window = self.window
            let rootViewController = window!.rootViewController as? UITabBarController
            print("go")
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "MapVC") as! MapVC
            (rootViewController!.selectedViewController as! UINavigationController).pushViewController(vc, animated: true)
            vc.openBank()
        }
        
        // Replace 'YOUR_APP_ID' with your OneSignal App ID.
        OneSignal.initWithLaunchOptions(launchOptions,
                                        appId: "fde22b87-44a3-44af-8020-d8c5f8e4ca42",
                                        handleNotificationAction: notificationOpenedBlock,
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
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        guard
            userActivity.interaction?.intent is FindAtmIntent,
            let window = window,
            let rootViewController = window.rootViewController as? UITabBarController
            else {
                print("error")
                return false
        }
        print("go")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MapVC") as! MapVC
        (rootViewController.selectedViewController as! UINavigationController).pushViewController(vc, animated: true)
        vc.openBank()
        return true
    }

}

extension UIColor {
    
    /// This convenience for UIColor extended init for easy using rgb
    ///
    /// - Parameters:
    ///   - red: red int
    ///   - green: green int
    ///   - blue: blue int
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    /// This convenience for UIColor extended init for easy using rgb
    ///
    /// - Parameter rgb: hex color
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    /// This convenience for UIColor extended init for easy using rgba
    ///
    /// - Parameters:
    ///   - red: red int
    ///   - green: green int
    ///   - blue: blue int
    ///   - alpha: alpha cgfloat
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        assert(alpha >= 0.0 && alpha <= 1.0, "Invalid alpha component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    convenience init(rgb: Int, alpha: CGFloat) {
        self.init(red: (rgb >> 16) & 0xFF, green: (rgb >> 8) & 0xFF, blue: rgb & 0xFF, alpha: alpha)
    }
    
    static let VKOurColor = UIColor(rgb: 0x172437)
}

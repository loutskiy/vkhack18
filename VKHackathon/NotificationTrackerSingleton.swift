//
//  NotificationTrackerSingleton.swift
//  VKHackathon
//
//  Created by Mikhail Lutskiy on 10/11/2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire

class NotificationTrackerSingleton: NSObject, CLLocationManagerDelegate {
    
    static let shared = NotificationTrackerSingleton.init()
    
    override init() {
        super.init()
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    let locationManager = CLLocationManager()
    
    var isTrackLocation = false
    
    var isTrackMerchant = false
    
    var currency = UserDefaults.standard.value(forKey: "currency")
    
    var bank = ""
    
//    var timer = Timer()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func sendingToServer() {
        Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { (timer) in
            if self.isTrackLocation {
                let params: Parameters = [
                    "bank": self.bank,
                    "currency": self.currency ?? "USD",
                    "latitude": self.locationManager.location?.coordinate.latitude ?? 0.0,
                    "longitude": self.locationManager.location?.coordinate.longitude ?? 0.0
                ]
                print(params)
                Alamofire.request(URL(string: "http://ss.bigbadbird.ru/api/ATMNearby")!, method: .post, parameters: params, encoding: JSONEncoding.default).response { (response) in
                    print(response)
                    //sleep(5)
                }
            } else {
                timer.invalidate()
            }
        }
        
    }
    

}

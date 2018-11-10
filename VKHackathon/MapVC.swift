//
//  MapVC.swift
//  VKHackathon
//
//  Created by Mikhail Lutskiy on 10/11/2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit
import NMAKit

class MapVC: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: NMAMapView!
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        mapView.positionIndicator.isVisible = true
        mapView.zoomLevel = 13.2
        mapView.set(geoCenter: NMAGeoCoordinates(latitude: 55.716542, longitude: 37.553947), animation: .linear)
        mapView.copyrightLogoPosition = NMALayoutPosition.bottomCenter
        
        if NMAPositioningManager.sharedInstance().startPositioning() {
//            NotificationCenter.default.addObserver(self, selector: #selector(positionDidUpdate), name: .NMAPositioningManagerDidUpdatePosition, object: NMAPositioningManager.shared())
            
        }        // Do any additional setup after loading the view.
        getAllLocations()
    }
    
    func getAllLocations () {
        ServerManager.getAllLocations { (dots) in
            for dot in dots {
                let pin = NMAMapMarker(geoCoordinates: NMAGeoCoordinates(latitude: dot.latitude!, longitude: dot.longitude!), icon: NMAImage(uiImage: #imageLiteral(resourceName: "shopping-cart-2"))!)
                self.mapView.add(mapObject: pin)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

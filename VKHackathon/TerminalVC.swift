//
//  TerminalVC.swift
//  VKHackathon
//
//  Created by Mikhail Lutskiy on 10/11/2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import SDWebImage

class TerminalVC: UITableViewController, CLLocationManagerDelegate {
    
    var location: LocationModel!
    let locationManager = CLLocationManager()

    @IBOutlet weak var atmImage: UIImageView!
    @IBOutlet weak var mapImageView: UIImageView!
    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var workTimeLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = location.IsMerchant! ? "Наличные с покупкой" : "Банкомат"
        navigationController?.navigationBar.tintColor = .VKOurColor
        let close = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissView))
        navigationItem.leftBarButtonItem = close
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        if location.IsMerchant! {
            atmImage.image = #imageLiteral(resourceName: "card-machine")
        } else {
            atmImage.image = #imageLiteral(resourceName: "atm")
        }
        
        bankNameLabel.text = Banks.banks[location.name!]?.name
        addressLabel.text = location.address
        workTimeLabel.text = location.work_time
        currencyLabel.text = location.currency
        
        mapImageView.sd_setImage(with: URL(string: "https://image.maps.api.here.com/mia/1.6/mapview?c=\(location.latitude!)%2C\(location.longitude!)&z=14&app_id=PIIS8aPnSq4cCgV5alOQ&app_code=HogN5Tpa55dcny-X6-eYDQ"), completed: nil)
        print("https://image.maps.api.here.com/mia/1.6/mapview?c=\(location.latitude)%2C\(location.longitude)&z=14&app_id=PIIS8aPnSq4cCgV5alOQ&app_code=HogN5Tpa55dcny-X6-eYDQ")
    }
    
    
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func routeAction(_ sender: Any) {
        let source = MKMapItem(placemark: MKPlacemark(coordinate: locationManager.location?.coordinate ?? CLLocationCoordinate2D()))
        source.name = "Моя геопозиция"
        
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: location.latitude ?? 0.0, longitude: location.longitude ?? 0.0)))
        destination.name = Banks.banks[location.name!]?.name
        
        MKMapItem.openMaps(with: [source, destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}

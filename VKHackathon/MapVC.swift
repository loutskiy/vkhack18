//
//  MapVC.swift
//  VKHackathon
//
//  Created by Mikhail Lutskiy on 10/11/2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit
import NMAKit

class MapVC: UIViewController, CLLocationManagerDelegate, NMAMapViewDelegate, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var bankSegment: UISegmentedControl!
    @IBOutlet weak var mapView: NMAMapView!
    let locationManager = CLLocationManager()
    var isNeedFilter = false
    var bankName = ""
    var currency = ""
    var pins = [CustomMarker]()

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
        mapView.delegate = self
        mapView.zoomLevel = 13.2
        mapView.set(geoCenter: NMAGeoCoordinates(latitude: 59.94177171979458, longitude: 30.315999984741207), animation: .linear)
        mapView.copyrightLogoPosition = NMALayoutPosition.bottomCenter
        
        if NMAPositioningManager.sharedInstance().startPositioning() {
//            NotificationCenter.default.addObserver(self, selector: #selector(positionDidUpdate), name: .NMAPositioningManagerDidUpdatePosition, object: NMAPositioningManager.shared())
            
        }        // Do any additional setup after loading the view.
        getAllLocations()
    }
    
    func getAllLocations () {
        if isNeedFilter {
            ServerManager.getFilterLocations(currency: currency, bank: bankName, success: { (dots) in
                self.mapView.remove(mapObjects: self.pins)
                self.pins = [CustomMarker]()
                
                for dot in dots {
                    switch self.bankSegment.selectedSegmentIndex {
                    case 0:
                        let pin = CustomMarker(geoCoordinates: NMAGeoCoordinates(latitude: dot.latitude!, longitude: dot.longitude!), icon: NMAImage(uiImage: dot.IsMerchant ?? false ? #imageLiteral(resourceName: "shopping-cart-2") : #imageLiteral(resourceName: "dollar-bill-through-cash-machine-"))!)
                        pin.locationModel = dot
                        self.pins.append(pin)
                    case 1:
                        if !(dot.IsMerchant!) {
                            let pin = CustomMarker(geoCoordinates: NMAGeoCoordinates(latitude: dot.latitude!, longitude: dot.longitude!), icon: NMAImage(uiImage: dot.IsMerchant ?? false ? #imageLiteral(resourceName: "shopping-cart-2") : #imageLiteral(resourceName: "dollar-bill-through-cash-machine-"))!)
                            pin.locationModel = dot
                            self.pins.append(pin)
                        }
                    case 2:
                        if (dot.IsMerchant!) {
                            let pin = CustomMarker(geoCoordinates: NMAGeoCoordinates(latitude: dot.latitude!, longitude: dot.longitude!), icon: NMAImage(uiImage: dot.IsMerchant ?? false ? #imageLiteral(resourceName: "shopping-cart-2") : #imageLiteral(resourceName: "dollar-bill-through-cash-machine-"))!)
                            pin.locationModel = dot
                            self.pins.append(pin)
                        }
                    default:
                        break
                    }
                }
                self.mapView.add(mapObjects: self.pins)
            })
        } else {
            ServerManager.getAllLocations { (dots) in
                self.mapView.remove(mapObjects: self.pins)
                self.pins = [CustomMarker]()
                
                for dot in dots {
                    switch self.bankSegment.selectedSegmentIndex {
                    case 0:
                        let pin = CustomMarker(geoCoordinates: NMAGeoCoordinates(latitude: dot.latitude!, longitude: dot.longitude!), icon: NMAImage(uiImage: dot.IsMerchant ?? false ? #imageLiteral(resourceName: "shopping-cart-2") : #imageLiteral(resourceName: "dollar-bill-through-cash-machine-"))!)
                        pin.locationModel = dot
                        self.pins.append(pin)
                    case 1:
                        if !(dot.IsMerchant!) {
                            let pin = CustomMarker(geoCoordinates: NMAGeoCoordinates(latitude: dot.latitude!, longitude: dot.longitude!), icon: NMAImage(uiImage: dot.IsMerchant ?? false ? #imageLiteral(resourceName: "shopping-cart-2") : #imageLiteral(resourceName: "dollar-bill-through-cash-machine-"))!)
                            pin.locationModel = dot
                            self.pins.append(pin)
                        }
                    case 2:
                        if (dot.IsMerchant!) {
                            let pin = CustomMarker(geoCoordinates: NMAGeoCoordinates(latitude: dot.latitude!, longitude: dot.longitude!), icon: NMAImage(uiImage: dot.IsMerchant ?? false ? #imageLiteral(resourceName: "shopping-cart-2") : #imageLiteral(resourceName: "dollar-bill-through-cash-machine-"))!)
                            pin.locationModel = dot
                            self.pins.append(pin)
                        }
                    default:
                        break
                    }
                }
                self.mapView.add(mapObjects: self.pins)
            }
        }
    }
    
    func mapView(_ mapView: NMAMapView, didSelect objects: [NMAViewObject]) {
        let marker = objects.first as! CustomMarker
        print(marker)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TerminalVC") as! TerminalVC
        vc.location = marker.locationModel
//        vc.user = data[indexPath.row]
        //        vc.doneCount = user.doneCount
        //        vc.rating = user.rating
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .popover
        //print(self.view.frame.size.width)
        //print(self.view.frame.size.height)
        nav.preferredContentSize = CGSize(width: self.view.frame.size.width - 20, height: self.view.frame.size.height - 50)
        
        let ppc = nav.popoverPresentationController
        ppc?.permittedArrowDirections = UIPopoverArrowDirection.init(rawValue: 0)
        ppc?.delegate = self
        ppc?.sourceView = self.view
        
        present(nav, animated: true, completion: nil)
    }
    
    func openBank () {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TerminalVC") as! TerminalVC
        vc.location = LocationModel(JSONString: "{\"id\":23,\"name\":\"SAVINGS BANK OF THE RUSSIAN FEDERATION (SBERBANK)\",\"latitude\":59.95247471691382,\"longitude\":30.299606323242188,\"bank_name\":\"\",\"type\":\"Снятие наличных;\",\"work_time\":\"с 10:00 до 22:57\",\"currency\":\"RUB\",\"cashless\":false,\"is_merchant\":false,\"address\":\"Лиговский проспект, 30А, этаж 1, Возле магазина: Zara\",\"bank_id\":4}")
        //        vc.user = data[indexPath.row]
        //        vc.doneCount = user.doneCount
        //        vc.rating = user.rating
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .popover
        //print(self.view.frame.size.width)
        //print(self.view.frame.size.height)
        nav.preferredContentSize = CGSize(width: self.view.frame.size.width - 20, height: self.view.frame.size.height - 50)
        
        let ppc = nav.popoverPresentationController
        ppc?.permittedArrowDirections = UIPopoverArrowDirection.init(rawValue: 0)
        ppc?.delegate = self
        ppc?.sourceView = self.view
        
        present(nav, animated: true, completion: nil)
    }
    
    func openBank2 () {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TerminalVC") as! TerminalVC
        vc.location = LocationModel(JSONString: "{\"id\":23,\"name\":\"SAVINGS BANK OF THE RUSSIAN FEDERATION (SBERBANK)\",\"latitude\":59.95247471691382,\"longitude\":30.299606323242188,\"bank_name\":\"\",\"type\":\"Снятие наличных;\",\"work_time\":\"с 10:00 до 22:57\",\"currency\":\"RUB\",\"cashless\":false,\"is_merchant\":true,\"address\":\"Лиговский проспект, 30А, этаж 1, Возле магазина: Zara\",\"bank_id\":4}")
        //        vc.user = data[indexPath.row]
        //        vc.doneCount = user.doneCount
        //        vc.rating = user.rating
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .popover
        //print(self.view.frame.size.width)
        //print(self.view.frame.size.height)
        nav.preferredContentSize = CGSize(width: self.view.frame.size.width - 20, height: self.view.frame.size.height - 50)
        
        let ppc = nav.popoverPresentationController
        ppc?.permittedArrowDirections = UIPopoverArrowDirection.init(rawValue: 0)
        ppc?.delegate = self
        ppc?.sourceView = self.view
        
        present(nav, animated: true, completion: nil)
    }

    @IBAction func changeAtmType(_ sender: UISegmentedControl) {
        getAllLocations()
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }

}

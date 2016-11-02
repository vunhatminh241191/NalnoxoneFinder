//
//  CarrierMainApplication.swift
//  NalFind
//
//  Created by Minh Vu on 11/2/16.
//
//

import Foundation
import UIKit
import GoogleMaps
import GooglePlaces


class CarrierMainApplication:UIViewController {
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var findingNaloxone: UITextView!
    @IBOutlet weak var settings: UIButton!
    
    let listPoints = [NalFinder(latPoint: 45.518244, longPoint: -122.6883403),
                      NalFinder(latPoint: 45.5270595, longPoint: -122.5375007),
                      NalFinder(latPoint: 45.6372174, longPoint: -122.6343184),
                      NalFinder(latPoint: 45.5283386, longPoint: -122.6595437)]
    
    let locationManager = CLLocationManager()
     var currentLocation = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        
        settings.addTarget(self, action: #selector(self.GoingToSettings), for: .touchDown)
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        }
        
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.FindingNaloxone))
        findingNaloxone.addGestureRecognizer(tap1)
        SaveALife()
    }
    
    func GoingToSettings() {
        self.performSegue(withIdentifier: "settings", sender: self)
    }
    
    func FindingNaloxone() {
        if findingNaloxone.text == "Find Nalnoxone" {
            let path = GMSMutablePath()
            for point in listPoints {
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: point._latPoint, longitude: point._longPoint)
                marker.map = mapView
                path.add(CLLocationCoordinate2D(latitude: point._latPoint, longitude: point._longPoint))
            }
            let bounds = GMSCoordinateBounds(path: path)
            mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 50.0))
            findingNaloxone.text = "Main Page" }
        else if findingNaloxone.text == "Main Page" {
            findingNaloxone.text = "Find Nalnoxone"
            locationManager.startUpdatingLocation()
            mapView.clear() }

    }
    
    func SaveALife() {
        let patientLocation = NalFinder(latPoint: 45.4486938, longPoint: -122.7150369 )
        let listOverDosePoints = [patientLocation, NalFinder(latPoint: currentLocation.latitude, longPoint: currentLocation.longitude)]
        let path = GMSMutablePath()
        for point in listOverDosePoints {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: point._latPoint, longitude: point._longPoint)
            marker.icon = GMSMarker.markerImage(with: getRandomColor())
            marker.map = mapView
            marker.appearAnimation = kGMSMarkerAnimationPop
            path.add(CLLocationCoordinate2D(latitude: point._latPoint, longitude: point._longPoint))
        }
        
        let bounds = GMSCoordinateBounds(path: path)
        mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 50.0))
        
        // hard core function to show a map with title
        let alertController = UIAlertController(title: "Save a life",message: "There is a overdose person need your help. It only take 5 mins"
            , preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.default) {
            UIAlertAction in
            alertController.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(UIAlertAction(title: "Busy", style: UIAlertActionStyle.cancel) {
            UIAlertAction in alertController.dismiss(animated: true, completion: nil)})
        
        self.present(alertController, animated: true, completion: nil)

    }
    func getRandomColor() -> UIColor{
        //Generate between 0 to 1
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
}

extension CarrierMainApplication: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            currentLocation = location.coordinate
            locationManager.stopUpdatingLocation()
        }
    }
    
}

extension CarrierMainApplication: GMSMapViewDelegate {
    
}

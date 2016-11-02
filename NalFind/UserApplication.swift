//
//  UserApplication.swift
//  NalFind
//
//  Created by Minh Vu on 10/31/16.
//
//

import Foundation
import UIKit
import GoogleMaps
import GooglePlaces

struct NalFinder {
    var _latPoint: Double!
    var _longPoint: Double!
    
    init(latPoint: Double, longPoint: Double) {
        _latPoint = latPoint
        _longPoint = longPoint
    }
}

class UserMainApplication: UIViewController {
    @IBOutlet weak var overdose: UIButton!
    @IBOutlet weak var settings: UIButton!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var findNalnoxone: UITextView!
    
    let locationManager = CLLocationManager()
    let listPoints = [NalFinder(latPoint: 45.518244, longPoint: -122.6883403),
                      NalFinder(latPoint: 45.5270595, longPoint: -122.5375007),
                      NalFinder(latPoint: 45.6372174, longPoint: -122.6343184),
                      NalFinder(latPoint: 45.5283386, longPoint: -122.6595437)]
    
    var currentLocation = CLLocationCoordinate2D()
    
    let rescuerLocation = NalFinder(latPoint: 45.4486938, longPoint: -122.7150369 )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        
        settings.addTarget(self, action: #selector(self.GoingToSettings), for: .touchDown)
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        }
        overdose.addTarget(self, action: #selector(self.OverDoseFunction), for: .touchDown)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        LoadMap()
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.FindingNaloxone))
        findNalnoxone.addGestureRecognizer(tap1)
    }
    
    func GoingToSettings() {
        self.performSegue(withIdentifier: "settings", sender: self)
    }
    
    func FindingNaloxone() {
        //List of these address where we can find Nalnoxone
        if findNalnoxone.text == "Find Nalnoxone" {
            let path = GMSMutablePath()
            for point in listPoints {
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: point._latPoint, longitude: point._longPoint)
                marker.map = mapView
                path.add(CLLocationCoordinate2D(latitude: point._latPoint, longitude: point._longPoint))
            }
            let bounds = GMSCoordinateBounds(path: path)
            mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 50.0))
            findNalnoxone.text = "Main Page" }
        else if findNalnoxone.text == "Main Page" {
            findNalnoxone.text = "Find Nalnoxone"
            locationManager.startUpdatingLocation()
            mapView.clear() }
    }
    
    func LoadMap(){
        mapView.animate(toZoom: 17)
        //Controls whether the My Location dot and accuracy circle is enabled.
        mapView.isMyLocationEnabled = true
        //Controls the type of map tiles that should be displayed.
        mapView.mapType = kGMSTypeNormal;
        //Shows the compass button on the map
        mapView.settings.compassButton = true
        //Shows the my location button on the map
        mapView.settings.myLocationButton = true
    }
    
    func OverDoseFunction() {
        let listOverDosePoints = [rescuerLocation, NalFinder(latPoint: currentLocation.latitude, longPoint: currentLocation.longitude)]
        let path = GMSMutablePath()
        for point in listOverDosePoints {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: point._latPoint, longitude: point._longPoint)
            marker.map = mapView
            path.add(CLLocationCoordinate2D(latitude: point._latPoint, longitude: point._longPoint))
        }
        let bounds = GMSCoordinateBounds(path: path)
        mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 50.0))

        let alertController = UIAlertController(title: "Notice",message: "There are 5 minutes travel time for the closet carrier"
            , preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Notice", style: UIAlertActionStyle.default) {
            UIAlertAction in
            alertController.dismiss(animated: true, completion: nil)
        })
        self.present(alertController, animated: true, completion: nil)
    }
}

extension UserMainApplication: CLLocationManagerDelegate{
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

extension UserMainApplication: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if marker.position.latitude == 45.4486938 && marker.position.longitude == -122.7150369 {
            let alertController = UIAlertController(title: "Wanna Call",message: "You can connect with your rescuer"
                , preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Call", style: UIAlertActionStyle.default) {
                UIAlertAction in
                alertController.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
                UIAlertAction in alertController.dismiss(animated: true, completion: nil)})

            self.present(alertController, animated: true, completion: nil)
        }
        return true;
    }
}

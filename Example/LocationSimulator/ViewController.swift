//
//  ViewController.swift
//  LocationSimulator
//
//  Created by strongwillow on 03/23/2020.
//  Copyright (c) 2020 strongwillow. All rights reserved.
//

import UIKit
import MapKit
import LocationSimulator

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    let locationSimulator = LSLocationManager(builtInLocationFileName: "EindhovenBiking.gpx")
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationSimulator.delegate = self
        locationSimulator.startUpdatingLocation()
        mapView.delegate = self
    }
    
    func printLocation(loc: CLLocation) {
        print(loc.coordinate.latitude, loc.coordinate.longitude, loc.altitude)
    }
    
    var lastCoord: CLLocationCoordinate2D?
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let last = lastCoord {
            var coords = [CLLocationCoordinate2D]()
            coords.append(last)
            for i in locations {
                coords.append(i.coordinate)
            }
            let poly = MKPolyline(coordinates: coords, count: coords.count)
            mapView.addOverlay(poly, level: .aboveLabels)
        }
        lastCoord = locations.last?.coordinate
        
        let cam = MKMapCamera(lookingAtCenter: lastCoord!, fromDistance: 1500, pitch: 0, heading: 0)
        mapView.setCamera(cam, animated: false)
        
        for loc in locations {
            printLocation(loc: loc)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .red
            renderer.lineWidth = 5
            return renderer
        }
        return MKOverlayRenderer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


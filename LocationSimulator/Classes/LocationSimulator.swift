import os
import UIKit
import CoreLocation

public final class SimLocationManager: CLLocationManager {
    
    override public init() {
        
    }
    
    public override func startUpdatingLocation() {
        parseFile(filename: "cycle.gpx")
        startFeedingLocations()
    }
    
    public override func stopUpdatingLocation() {
        
    }

    var locations = [CLLocation]()
    func parseFile(filename: String) {
        
        let myBundle = Bundle(for: Self.self)
        guard let resourceBundleURL = myBundle.url(
        forResource: "LocationSimulator", withExtension: "bundle")
        else { fatalError("MySDK.bundle not found!") }

        let path = resourceBundleURL.appendingPathComponent(filename).path
        locations = GPXFile(fileURL: URL(fileURLWithPath: path)).getLocations()
    }

    func startFeedingLocations() {
       
        DispatchQueue.global().async {
            var i = 0

            while (true) {
                usleep(1000000) //0.1s
                
                let it = self.locations[i]
                var dis = 0.0
                if (i > 0) {
                    dis = self.locations[i].distance(from: self.locations[i - 1])
                }
                
                let tmp = CLLocation(coordinate: it.coordinate, altitude: it.altitude, horizontalAccuracy: it.horizontalAccuracy, verticalAccuracy: it.verticalAccuracy, course: it.course, speed: dis, timestamp: Date())

                DispatchQueue.main.sync {
                    self.delegate?.locationManager?(self, didUpdateLocations: [tmp])
                }
                
                i = (i + 1) % self.locations.count
            }
        }

    }
}

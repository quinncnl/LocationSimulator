import os
import UIKit
import CoreLocation

public final class LSLocationManager: CLLocationManager {
    
    var sourceURL: URL?
    var locations = [CLLocation]()
    
    public init(locationFile: URL) {
        sourceURL = locationFile
        super.init()
    }
    
    public init(builtInLocationFileName: String) {
        let myBundle = Bundle(for: Self.self)
        guard let resourceBundleURL = myBundle.url(
            forResource: "LocationSimulator", withExtension: "bundle")
            else { fatalError("MySDK.bundle not found!") }
        
        let path = resourceBundleURL.appendingPathComponent(builtInLocationFileName).path
        sourceURL = URL(fileURLWithPath: path)
        super.init()
    }
    
    public override func startUpdatingLocation() {
        parseLocationFile()
        startFeedingLocations()
    }
    
    public override func stopUpdatingLocation() {
        
    }

    func parseLocationFile() {
        guard self.sourceURL != nil else {
            assert(false, "Location source file not set")
        }
        locations = GPXFile(fileURL: self.sourceURL!).getLocations()
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

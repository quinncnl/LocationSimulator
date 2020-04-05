import UIKit
import CoreLocation

public final class GPXFile: NSObject {

    private let REGEXP_GPX_COORD = try! NSRegularExpression(pattern: "lat=\"(-?\\d+\\.\\d+)\" lon=\"(-?\\d+\\.\\d+)\"", options: NSRegularExpression.Options.anchorsMatchLines)

    private var locations = [CLLocation]()
    private var url: URL

    public required init(fileURL url: URL) {
        self.url = url
        super.init()
        load()
    }
    
    func getLocations() -> [CLLocation] {
        return locations
    }
    
    func load() {

        guard let data = FileManager.default.contents(atPath: url.path) else {
            assert(false, "File not found")
        }
        
        let fileContent = String(data: data, encoding: .utf8)!
        let str = fileContent as NSString
        
        // Coordinates may be encapsulated in <trk> or <rte> tags
        var range = str.range(of: "<trk>")
        
        if (range.length == 0) {
            range = str.range(of: "<rte>")
        }
        
        range.length = str.length - range.location
        
        let strstr = str as String
        
        REGEXP_GPX_COORD.enumerateMatches(in: strstr, options: NSRegularExpression.MatchingOptions.reportCompletion, range: range, using: { (res, flag, stop) -> Void in
            
            if let r = res {
                
                let lat = (str.substring(with: r.range(at: 1)) as NSString).doubleValue
                let lng = (str.substring(with: r.range(at: 2)) as NSString).doubleValue
                
                let coord = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                locations.append(CLLocation(coordinate: coord, altitude: 0, horizontalAccuracy: 0, verticalAccuracy: 0, timestamp: Date(timeIntervalSince1970: 0)))
            }
        })
    }
}

import Capacitor
import CoreLocation

@objc(FastGeolocationPlugin)
public class FastGeolocationPlugin: CAPPlugin, CAPBridgedPlugin, CLLocationManagerDelegate {
    var locationManager: CLLocationManager!
    var savedCall: CAPPluginCall?

    public let identifier = "FastGeolocationPlugin"
    public let jsName = "FastGeolocation"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "getCurrentCity", returnType: CAPPluginReturnPromise)
    ]

    override public func load() {
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
    }

    @objc func getCurrentCity(_ call: CAPPluginCall) {
        self.savedCall = call

        let status = CLLocationManager.authorizationStatus()

        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.requestLocation()
        } else {
            call.reject("Location permission not granted")
        }
    }

    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            manager.requestLocation()
        } else if status == .denied || status == .restricted {
            savedCall?.reject("Location permission denied")
        }
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("📍 didUpdateLocations fired with \(locations.count) location(s)")
        guard let location = locations.first else {
            savedCall?.reject("No location found")
            return
        }

        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                self.savedCall?.reject("Geocoder error", error.localizedDescription)
                return
            }

            if let placemark = placemarks?.first {
                let result: [String: Any] = [
                    "latitude": location.coordinate.latitude,
                    "longitude": location.coordinate.longitude,
                    "city": placemark.locality ?? "",
                    "state": placemark.administrativeArea ?? "",
                    "country": placemark.country ?? ""
                ]
                self.savedCall?.resolve(result)
            } else {
                self.savedCall?.reject("No placemark found")
            }
        }
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("❌ didFailWithError: \(error.localizedDescription)")
        savedCall?.reject("Location error", error.localizedDescription)
    }
}

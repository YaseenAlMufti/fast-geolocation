import Capacitor
import CoreLocation

@objc(FastGeolocationPlugin)
public class FastGeolocationPlugin: CAPPlugin, CLLocationManagerDelegate {
    var locationManager: CLLocationManager!
    var savedCall: CAPPluginCall?

    @objc func getCurrentCity(_ call: CAPPluginCall) {
        self.savedCall = call
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
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
        savedCall?.reject("Location error", error.localizedDescription)
    }
}

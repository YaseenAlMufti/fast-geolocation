# FastGeolocation

> Fast native geolocation plugin for Capacitor that returns city, state, and country using on-device reverse geocoding.

![npm](https://img.shields.io/npm/v/@yaseenalmufti/fast-geolocation?color=blue)
![Capacitor](https://img.shields.io/badge/capacitor-5.x-blue)

---

## ✨ Features

- ✅ Fast native geolocation
- 🌍 Reverse geocoding (City, State, Country)
- ⚡ Works offline with on-device services (no external APIs)

---

## 📦 Installation

```bash
npm install @yaseenalmufti/fast-geolocation
npx cap sync
```

---

## 🔧 Platform Support

| Platform | Supported |
|----------|-----------|
| Android  | ✅        |
| iOS      | ✅        |
| Web      | ❌        |

---

## 📚 Usage

```ts
import FastGeolocation from '@yaseenalmufti/fast-geolocation';

const getLocation = async () => {
  try {
    const location = await FastGeolocation.getCurrentCity();
    console.log(\`You are in \${location.city}, \${location.state}, \${location.country}\`);
  } catch (error) {
    console.error('Error getting location:', error);
  }
};
```

---

## 📥 API

### `getCurrentCity(): Promise<CityLocation>`

Returns the current GPS location and reverse-geocoded city, state, and country.

#### `CityLocation` structure:
```ts
interface CityLocation {
  latitude: number;
  longitude: number;
  city: string;
  state: string;
  country: string;
}
```

---

## ⚙️ Android Setup

In `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
```

The plugin uses:

- `FusedLocationProviderClient` for fast location access
- `Geocoder` for native reverse geocoding

---

## ⚙️ iOS Setup

In `ios/App/App/Info.plist`:

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>We need your location to determine your city</string>
```

The plugin uses:

- `CLLocationManager` for GPS access
- `CLGeocoder` for native reverse geocoding

---

## 🧑‍💻 Author

**Yaseen Almufti**

- GitHub: [@yaseenalmufti](https://github.com/yaseenalmufti)
- npm: [@yaseenalmufti](https://www.npmjs.com/~yaseenalmufti)

---

## 📝 License

MIT

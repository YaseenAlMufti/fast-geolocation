export interface FastGeolocationPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}

export interface CityLocation {
  latitude: number;
  longitude: number;
  city: string;
  state: string;
  country: string;
}

export interface FastGeolocationPlugin {
  getCurrentCity(): Promise<CityLocation>;
}

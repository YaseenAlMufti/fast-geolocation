package com.almufti.fastgeolocation;

import android.location.Address;
import android.location.Geocoder;
import android.location.Location;

import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;
import com.google.android.gms.location.FusedLocationProviderClient;
import com.google.android.gms.location.LocationServices;

import org.json.JSONException;

import java.io.IOException;
import java.util.List;
import java.util.Locale;

import com.getcapacitor.JSObject;

@CapacitorPlugin(name = "FastGeolocation")
public class FastGeolocationPlugin extends Plugin {
    private FusedLocationProviderClient fusedLocationClient;

    @Override
    public void load() {
        fusedLocationClient = LocationServices.getFusedLocationProviderClient(getActivity());
    }

    @PluginMethod
    public void getCurrentCity(PluginCall call) {
        
        fusedLocationClient.getLastLocation().addOnSuccessListener(location -> {
            if (location != null) {
                Geocoder geocoder = new Geocoder(getContext(), Locale.getDefault());
                try {
                    List<Address> addresses = geocoder.getFromLocation(location.getLatitude(), location.getLongitude(), 1);
                    if (!addresses.isEmpty()) {
                        Address address = addresses.get(0);

                        JSObject result = new JSObject();
                        result.put("latitude", location.getLatitude());
                        result.put("longitude", location.getLongitude());
                        result.put("city", address.getLocality());
                        result.put("state", address.getAdminArea());
                        result.put("country", address.getCountryName());

                        call.resolve(result);
                    } else {
                        call.reject("No address found");
                    }
                } catch (IOException e) {
                    call.reject("Geocoder failed", e);
                }
            } else {
                call.reject("Location is null");
            }
        }).addOnFailureListener(e -> call.reject("Failed to get location", e));
    }
}

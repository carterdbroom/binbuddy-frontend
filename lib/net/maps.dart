import "dart:convert";
import 'package:geolocator/geolocator.dart';
import "package:http/http.dart" as http;
import "package:google_maps_flutter/google_maps_flutter.dart";

class Maps {
    static const String API_KEY = "AIzaSyBbBxg-WAsX9eJEpseirhyJbmijwcuqqCw";

    static Future<http.Response> sendTextQuery(String query, num lat, num long, {num radius = 2000, num resultCount = 10}) {
        String apiHeader = "https://places.googleapis.com/v1/places:searchText";

        return http.post(
            Uri.parse(apiHeader),
            headers: {
                "Content-Type": "application/json",
                "X-Goog-Api-Key": API_KEY,
                "X-Goog-FieldMask": "places.location,places.formattedAddress,places.displayName.text",
            },
            body: jsonEncode(
                {
                    "textQuery": query,
                    "maxResultCount": resultCount,
                    "rankPreference": "DISTANCE",
                    "locationBias": {
                        "circle": {
                            "center": {
                                "latitude": lat,
                                "longitude": long
                            },
                            "radius": radius
                        }
                    }
                }
            )
        );
    }

    static Marker buildMarkerFromPlaceJSON(Map<String, dynamic> place) {
        print(place['location']['latitude']);
        
        return Marker(
                markerId: MarkerId(place['displayName']['text']), 
                position: LatLng(place['location']['latitude'], place['location']['longitude']),
                infoWindow: InfoWindow(
                    title: place['displayName']['text'],
                    snippet: place['formattedAddress']
                )
                );
    }

    static Future<List<Marker>> queryLocations(String query, Position position) async {
        ///ToDo: Implement this function to query the google maps API
        ///and get locations that match the given query
        http.Response request = await sendTextQuery(query, position.latitude, position.longitude);

        var body = jsonDecode(request.body);

        var places = body['places'];

        List<Marker> output = [];

        for(var i = 0; i < places.length; i++) {
            var place = places[i];
            
            output.add(buildMarkerFromPlaceJSON(place));
        }
        
        return output;
    }

    static Future<Position> getCurrentLocation() async {
        bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the 
        // App to enable the location services.
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale 
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately. 
        return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
      } 

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      return await Geolocator.getCurrentPosition();
    }
}
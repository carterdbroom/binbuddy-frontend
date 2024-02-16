import "dart:convert";

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
            /*body: jsonEncode(
            {
                "maxResultCount": resultCount,
                "rankPreferance": "DISTANCE",
            })*/
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

    static Future<List<Marker>> queryLocations(String query, num lat, num long) async {
        ///ToDo: Implement this function to query the google maps API
        ///and get locations that match the given query
        http.Response request = await sendTextQuery(query, lat, long);

        var body = jsonDecode(request.body);

        var places = body['places'];

        List<Marker> output = [];

        for(var i = 0; i < places.length; i++) {
            var place = places[i];
            
            output.add(buildMarkerFromPlaceJSON(place));
        }
        
        return output;
    }
}
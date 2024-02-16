import 'package:binbuddy_frontend/net/maps.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class QueryMap extends StatefulWidget {
    const QueryMap({super.key, required this.query});

    final String query;
    @override
    State<QueryMap> createState() => _QueryMapState();
}

class _QueryMapState extends State<QueryMap> {
    List<Marker> markers = [];
    LatLng position = const LatLng(43.258012, -79.919929);

    @override
    void initState() {
        updateMarkers();
        super.initState();
    }

    void updateMarkers() async {
        print("here");
        
        setState(() async {
          markers = await Maps.queryLocations(widget.query, position.latitude, position.longitude);
        }); 
    }

    @override
    Widget build(BuildContext context) {
        return GoogleMap(
          initialCameraPosition: CameraPosition(target: position),
          markers: markers.toSet(),
        );
    }
}
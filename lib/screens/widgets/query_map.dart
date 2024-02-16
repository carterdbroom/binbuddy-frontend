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
        var result = await Maps.queryLocations(widget.query, position.latitude, position.longitude);
        //print(result);
        setState(() {
          markers = result;
          //markers = [ Marker(markerId: MarkerId("0"), position: position, infoWindow: InfoWindow(title: "Test") ) ];
        });
    }

    @override
    Widget build(BuildContext context) {
        //print(markers);
        
        return GoogleMap(
          initialCameraPosition: CameraPosition(target: position, zoom: 12),
          markers: markers == [] ? {Marker(markerId: MarkerId("0"), position: position, infoWindow: InfoWindow(title: "Test") )} : markers.toSet(),
        );
    }
}
import 'package:camera/camera.dart';
import 'package:binbuddy_frontend/net/maps.dart';
import 'package:binbuddy_frontend/net/vision.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum DisposalLocation {
  garbage,
  recycling,
  compost,
  unknown
}

class Disposal {
  DisposalLocation location;
  String locationKey;
  String description;
  String item;
  List<Marker>? searchedLocations;
  Position? disposalPosition;

  Disposal(this.location, this.locationKey, this.description, this.item);

  static Future<Disposal> getDisposalLocation(XFile imgFile, bool withMaps) async {
      final props = await Vision.getImageProperties(imgFile, 0.5);
      Disposal disposal = Vision.evaluateProperties(props);

      if(disposal.location == DisposalLocation.unknown && withMaps) {
          disposal.disposalPosition = await Maps.getCurrentLocation();
          disposal.searchedLocations = await Maps.queryLocations(disposal.locationKey, disposal.disposalPosition!);
      }

      return disposal;
  }

  static Garbage(String item) {
    return Disposal(
      DisposalLocation.garbage, 
      "Garbage",
      "Look for a black bin usually signed with Waste or Garbage!",
      item
    );
  }
  static Recycling(String item) { 
    return Disposal(
      DisposalLocation.recycling, 
      "Recycling",
      "Look for a blue bin usually signed with Recycling or a three arrow symbol.\nBe careful as some recycling bins are specific to certain items only, like paper or glass",
      item
    );
  }
  static Compost(String item) {
    return Disposal(
      DisposalLocation.compost, 
      "Compost",
      "Look for a green bin usually signed with Compost!",
      item
    );
  }
  static Electronic(String item) {
    return Disposal(
      DisposalLocation.unknown, 
      "Electronic Recycling Depot",
      "These locations take in any electronic parts and help to recycle and dispose of them correctly!",
      item
    );
  }


  static Textile(String item) {
    return Disposal(
      DisposalLocation.unknown, 
      "Textile Recycling Depot",
      "These location take any textile based items (clothes, sheets, fabrics) and help to recycle / redistribute them!",
      item
    );
  }
}
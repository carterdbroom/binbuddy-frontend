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
  List<Marker>? searchedLocations;
  Position? disposalPosition;

  Disposal(this.location, this.locationKey);

  static Future<Disposal> getDisposalLocation(XFile imgFile) async {
      final props = await Vision.getImageProperties(imgFile, 0.5);
      Disposal disposal = Vision.evaluateProperties(props);

      if(disposal.location == DisposalLocation.unknown) {
          disposal.disposalPosition = await Maps.getCurrentLocation();
          disposal.searchedLocations = await Maps.queryLocations(disposal.locationKey, disposal.disposalPosition!);
      }

      return disposal;
  }

  static var garbage = Disposal(DisposalLocation.garbage, "Garbage");
  static var recycling = Disposal(DisposalLocation.recycling, "Recycling");
  static var compost = Disposal(DisposalLocation.compost, "Compost");
  static var electronic = Disposal(DisposalLocation.unknown, "Electronic Recycling Depot");
  static var textile = Disposal(DisposalLocation.unknown, "Textile Recycling Depot");
}
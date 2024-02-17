import 'package:flutter/material.dart';
import 'package:binbuddy_frontend/net/maps.dart';
import 'package:binbuddy_frontend/net/vision.dart';

enum DisposalLocation {
  garbage,
  recycling,
  compost,
  unknown
}

class Disposal {
  DisposalLocation location;
  String locationKey;
  List<String>? searchedLocations;

  Disposal(this.location, this.locationKey);

  static Future<Disposal> getDisposalLocation(Image img) async {
      final props = await Vision.getImageProperties(img, 0.7);
      Disposal disposal = Vision.evaluateProperties(props);

      if(disposal.location == DisposalLocation.unknown) {
          //disposal.searchedLocations = await Maps.queryLocations(disposal.locationKey, 0, 0);
      }

      return disposal;
  }

  static var garbage = Disposal(DisposalLocation.garbage, "Garbage");
  static var recycling = Disposal(DisposalLocation.recycling, "Recycling");
  static var compost = Disposal(DisposalLocation.compost, "Compost");
  static var electronic = Disposal(DisposalLocation.unknown, "Electronic Recycling Depot");
  static var textile = Disposal(DisposalLocation.unknown, "Textile Recycling Depot");
}
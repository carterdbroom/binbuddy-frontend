import 'dart:ui';
import 'package:binbuddy_frontend/models/io.dart';
import 'package:binbuddy_frontend/net/disposal.dart';

class Vision {
    static var recyclables = <String>{};
    static var compostables = <String>{};
    static var electronicRecycling = <String>{};
    static var textileRecycling = <String>{};
    
    static Future<List<String>> getImageProperties(Image img, double discretion) async {
        ///TODO! Implement vision API request and check
        ///Return only properties above the given discretion rating
        ///Should be ordered from highest to lowest
        ///Throw error if no property is above the discretion rating
        return [];
    }

    static void prepareFiles() async {
        recyclables = await readLines("../recycle.txt");
        compostables = await readLines("../compost.txt");
        electronicRecycling = await readLines("../electron-depot.txt");
        textileRecycling = await readLines("../texttile-recycling.txt");
    }

    static Disposal evaluateProperties(List<String> properties) {
        for(var i = 0; i < properties.length; i++) {
            if(compostables.contains(properties[i])) {
              return Disposal.compost;
            }
            if(recyclables.contains(properties[i])) {
              return Disposal.recycling;
            }
            if(electronicRecycling.contains(properties[i])) {
              return Disposal.electronic;
            }
            if(textileRecycling.contains(properties[i])) {
              return Disposal.textile;
            }
        }

        return Disposal.garbage;
    }
}
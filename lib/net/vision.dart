import 'dart:convert';
import 'dart:typed_data';
import 'dart:io' show File;
import 'dart:ui' show Image;
import 'package:binbuddy_frontend/models/io.dart';
import 'package:binbuddy_frontend/net/disposal.dart';
import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:google_vision_flutter/google_vision_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Vision {
    static var recyclables = <String>{};
    static var compostables = <String>{};
    static var electronicRecycling = <String>{};
    static var textileRecycling = <String>{};

    static Future<List<String>> getImageProperties(XFile file, double discretion) async {
        ///TODO! Implement vision API request and check
        ///Return only properties above the given discretion rating
        ///Should be ordered from highest to lowest
        ///Throw error if no property is above the discretion rating
        print("Loading tokens...");
        
        final googleVision =
          await GoogleVision.withAsset('assets/responsive-bird-414516-3a1eca44c353.json');

        print("Loaded tokens.");

        final bytes = await file.readAsBytes();

        JsonImage jsonImg = JsonImage(byteBuffer: bytes.buffer);
        
        print("Loaded image.");

        final requests = AnnotationRequests(requests: [
          AnnotationRequest(jsonImage: jsonImg, features: [
            Feature(maxResults: 10, type: AnnotationType.labelDetection),
            Feature(maxResults: 3, type: AnnotationType.objectLocalization)
          ])
        ]);

        print("Created request.");

        final annotatedResponses =
          await googleVision.annotate(requests: requests);

        print("Made request.");
        print(annotatedResponses.toJson());


        final labels = annotatedResponses.toJson()['responses'][0]['labelAnnotations'] as List<EntityAnnotation>;
        final objects = annotatedResponses.toJson()['responses'][0]['localizedObjectAnnotations'] as List<LocalizedObjectAnnotation>;

        List<String> output = [];

        for(var i = 0; i < labels.length; i++) {
            if(labels[i].score! < discretion) {
                break;
            }
            output.add(labels[i].description);
        }

        for(var i = 0; i < objects.length; i++) {
            output.add(objects[i].name);
        }

        return output;
    }

    static Future<List<String>> testGetImageProperties() async {
        ///TODO! Implement vision API request and check
        ///Return only properties above the given discretion rating
        ///Should be ordered from highest to lowest
        ///Throw error if no property is above the discretion rating
        print("Loading tokens...");
        
        final googleVision =
          await GoogleVision.withAsset('assets/responsive-bird-414516-3a1eca44c353.json');

        print("Loaded tokens.");

        //final img =
          //Image.network("https://imgs.search.brave.com/my-C_ow_2ZZwM-Hb3EGoZjPCdydigeXJ5IfwFvN4p84/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS1waG90/by9wbGFzdGljLWJs/dWUtYm90dGxlLXdp/dGgtd2F0ZXJfMTU5/OTM4LTg5MC5qcGc_/c2l6ZT02MjYmZXh0/PWpwZw");

        final jsonImg = JsonImage(imageUri: "https://imgs.search.brave.com/Qxj4jdiAIJJsRd1YsE2N17Zgu2M9UBZt7Mk04ofgDPw/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9pNS53/YWxtYXJ0aW1hZ2Vz/LmNvbS9kZncvODgy/MmFlZjYtYWE0OS9r/Mi1fMmViNmMyMjEt/NjUyYS00N2RmLWEy/YjgtZjk1MDk3Yjk5/NDliLnYxLmpwZw");

        print("Loaded image.");

        final requests = AnnotationRequests(requests: [
          AnnotationRequest(jsonImage: jsonImg, features: [
            Feature(maxResults: 10, type: AnnotationType.labelDetection),
            Feature(maxResults: 3, type: AnnotationType.objectLocalization)
          ])
        ]);

        print("Created request.");

        final annotatedResponses =
          await googleVision.annotate(requests: requests);

        print("Made request.");
        print(annotatedResponses.toJson());


        final labels = annotatedResponses.toJson()['responses'][0]['labelAnnotations'] as List<EntityAnnotation>;
        final objects = annotatedResponses.toJson()['responses'][0]['localizedObjectAnnotations'] as List<LocalizedObjectAnnotation>;

        List<String> output = [];

        for(var i = 0; i < labels.length; i++) {
            if(labels[i].score! < 0.75) {
                break;
            }
            output.add(labels[i].description);
        }

        for(var i = 0; i < objects.length; i++) {
            output.add(objects[i].name);
        }

        return output;
    }

    /*static void prepareFiles() async {
        recyclables = await readFirebaseLines("assets/recycle.txt");
        compostables = await readFirebaseLines("assets/compost.txt");
        electronicRecycling = await readFirebaseLines("assets/electron-depot.txt");
        textileRecycling = await readFirebaseLines("assets/textile-recycling.txt");
    }*/

    static void prepareFiles() async {
        recyclables = {
          "Newspaper"
          "Magazine"
          "Paper"
          "Envelopes"
          "Catalog"
          "Book,(with hardcovers removed)"
          "Box"
          "Jar"
          "Bottle"
          "Can"
          "Aluminum foil"
          "Pie pan"
          "Jug"
          "Container"
          "Lid"
          "Bottle Cap"
          "Bag"
          "Plastic wrap"
          "Cling wrap"
          "Saran wrap"
          "Squeeze bottle"
          "Cup"
          "Cutlery"
          "Plant pots"
          "Toys"
          "Plastic buckets"
          "Juice box"
          "Juicebox"
          "Paint can"
          "Bakeware"
          "Candle holder"
          "Perfume bottle"
          "Food container"
          "Windowpane"
          "Glassware"
          "Bicycle"
          "Printer cartridge"
          "Coat-hanger"
          "Hanger"
          "Pot"
          "Pan"
          "Silverware"
          "Fork"
          "Knife"
          "Spoon"
          "Spork"
          "Pipe"
          "Wire"
          "Shelving units"
          "Jewelry"
          "Sunglasses"
          "Holiday decorations"
        };

        compostables = {
            "food",
            "soil",
            "dirt"
        };

        electronicRecycling = {
          "Electronic"
          "Phone"
          "Laptop"
          "Television"
          "Battery"
          "TV"
          "Power cable"
          "Printer"
          "Microwave"
          "Computer"
          "Monitor"
          "Scanner"
          "Keyboard"
          "Mouse"
          "Speaker"
          "Cell phone"
          "Smart phone"
          "Tablet"
          "Camera"
          "DVD player"
          "VCR"
          "Stereo system"
          "Console"
          "Hard drive"
          "Flash drive"
          "USB"
          "Router"
          "Switch"
          "Modem"
          "Power strip"
          "Surge protector"
          "Charger"
          "Adapter"
          "Cable"
          "Cord"
          "Landline phone"
          "Electric toothbrush"
          "Blender"
          "Hair dryer"
          "Hair straightener"
          "Electric shaver"
          "Power tool"
          "Drill"
          "Saw"
          "Mitersaw"
          "Jigsaw"
          "Circularsaw"
          "Leaf blower"
          "Thermostat"
          "Smoke detector"
          "Carbon monoxide detector"
          "GPS"
          "Smartwatch"
          "Fitbit"
          "Headphones"
          "Earbuds"
          "Calculators"
          "Projectors"
          "Microscope"
          "Lab instrument"
          "Watch"
        };

        textileRecycling = {
            "Textile"
            "Shoe"
            "Sheet"
            "Towel"
            "Curtain"
            "Pillow"
            "Mattress"
            "Rug"
            "Blanket"
            "Stuffed animal"
            "Backpack"
            "Handbag"
            "Wallet"
            "Belt"
            "Hat"
            "Glove"
            "Scarve"
        };
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
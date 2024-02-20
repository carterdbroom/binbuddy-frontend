import 'package:binbuddy_frontend/net/disposal.dart';
import 'package:binbuddy_frontend/net/vision.dart';
import 'package:binbuddy_frontend/screens/widgets/bottom_nav_bar.dart';
import 'package:binbuddy_frontend/screens/widgets/camera.dart';
import 'package:binbuddy_frontend/screens/widgets/query_map.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WasteWizardPage extends StatefulWidget {
  WasteWizardPage({super.key});

  @override
  State<WasteWizardPage> createState() => _WasteWizardPageState();
}

class _WasteWizardPageState extends State<WasteWizardPage> {
    CameraDescription? camera;
    Disposal? foundDisposal;
    String mode = "";

    void initCamera() async {
      WidgetsFlutterBinding.ensureInitialized();

      // Obtain a list of the available cameras on the device.
      final cameras = await availableCameras();

      // Get a specific camera from the list of available cameras.
      setState(() {
          camera = cameras.first;
      });
    }

      @override
    void initState() {
      super.initState();
      initCamera();
    }
    
    void afterImage(XFile imgFile) async {
        Disposal disposal = await Disposal.getDisposalLocation(imgFile);

        setState(() {
            foundDisposal = disposal;
        });
    }

    void setMode(String s) {
        setState(() {
          mode = s;
        });
    }

    @override
    Widget build(BuildContext context) { 
        var bar = AppBar(
              centerTitle: true,
              title: const Text(
                "Waste Wizard",
                style: TextStyle(
                  fontFamily: "Monospace",
                ),
              ),
            );

        if(mode == "") {
          return SelectMode(setMode: setMode, bar: bar);
        }

        if(camera != null && foundDisposal == null) {
          return Scaffold(
            appBar: bar,
            body: TakePictureScreen(camera: camera!, callAfter: afterImage),
            bottomNavigationBar: const Bottom(),
          );
        } else if(camera != null) {
          return Scaffold (
            appBar: bar,
            body: QueryMap(
                markers: foundDisposal!.searchedLocations!, 
                position: LatLng(
                    foundDisposal!.disposalPosition!.latitude, 
                    foundDisposal!.disposalPosition!.longitude
                    )
                )
          );
        }
      return  const Center(child: CircularProgressIndicator());
    }
}

class SelectMode extends StatelessWidget {
    SelectMode({super.key, required this.setMode, required this.bar});

    final PreferredSizeWidget bar;
    final Function setMode;

    TextStyle tStyle = const 
      TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 24
      );

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: bar,
            body: Container (
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () => {
                          setMode("Track")
                      }, 
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          "Track Waste", 
                          style: tStyle,
                          )
                      )
                    ),
                  ), 
                  Padding(
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () => {
                          setMode("Discover")
                      }, 
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          "Discover", 
                          style: tStyle,
                          )
                      )
                    ),
                  ),  
                ],
              )
            ),
            bottomNavigationBar: const Bottom(),
        );
    }
}
import 'package:binbuddy_frontend/net/disposal.dart';
import 'package:binbuddy_frontend/net/vision.dart';
import 'package:binbuddy_frontend/screens/widgets/bottom_nav_bar.dart';
import 'package:binbuddy_frontend/screens/widgets/camera.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class WasteWizardPage extends StatefulWidget {
  WasteWizardPage({super.key});

  @override
  State<WasteWizardPage> createState() => _WasteWizardPageState();
}

class _WasteWizardPageState extends State<WasteWizardPage> {
    CameraDescription? camera;
    Disposal? foundDisposal;

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

    @override
    Widget build(BuildContext context) {
        if(camera != null) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                "Waste Wizard",
                style: TextStyle(
                  fontFamily: "Monospace",
                ),
              ),
            ), 
            body: TakePictureScreen(camera: camera!, callAfter: afterImage),
            bottomNavigationBar: const Bottom(),
          );
        }
      return const Text("Loading...");
    }
}
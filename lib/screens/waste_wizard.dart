import 'package:binbuddy_frontend/net/disposal.dart';
import 'package:binbuddy_frontend/net/vision.dart';
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
    
    void afterImage(Image img) async {
        List<String> properties = await Vision.getImageProperties(img, 0.75);
        Disposal disposal = Vision.evaluateProperties(properties);

        setState(() {
            foundDisposal = disposal;
        });
    }

    @override
    Widget build(BuildContext context) {
        if(camera != null) {
            return TakePictureScreen(camera: camera!, callAfter: afterImage);
        }

        return const Text("Loading...");
    }
}
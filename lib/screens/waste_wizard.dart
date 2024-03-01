import 'package:binbuddy_frontend/models/user.dart';
import 'package:binbuddy_frontend/net/disposal.dart';
import 'package:binbuddy_frontend/screens/home.dart';
import 'package:binbuddy_frontend/screens/widgets/bottom_nav_bar.dart';
import 'package:binbuddy_frontend/screens/widgets/camera.dart';
import 'package:binbuddy_frontend/screens/widgets/login_button.dart';
import 'package:binbuddy_frontend/screens/widgets/query_map.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WasteWizardPage extends StatefulWidget {
  const WasteWizardPage({super.key, required this.user, required this.setUser});

  final User? user;
  final Function setUser;

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
        
        var backButton = IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () {
            setMode("");
          },
        );

        var bar = AppBar(
              centerTitle: true,
              title: const Text(
                "Waste Wizard",
                style: TextStyle(
                  fontFamily: "Monospace",
                ),
              ),
            );
        
        var barWithBack = AppBar(
              leading: backButton,
              centerTitle: true,
              title: const Text(
                "Waste Wizard",
                style: TextStyle(
                  fontFamily: "Monospace",
                ),
              ),
            );

        if(mode == "") {
          return SelectMode(setMode: setMode, bar: bar, user: widget.user, setUser: widget.setUser,);
        }

        if (camera != null && foundDisposal == null) {
          return Scaffold(
            appBar: barWithBack,
            body: TakePictureScreen(camera: camera!, callAfter: afterImage),
            bottomNavigationBar: Bottom(user: widget.user, setUser: widget.setUser,),
          );
        } else if (camera != null && foundDisposal != null && mode == "Track") {
          return Scaffold(
            appBar: bar,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Scan Complete!",
                  style: TextStyle(
                    fontFamily: "Monospace",
                    fontSize: 20,
                  )
                ),
                const Text(
                  "Where Should It Go?",
                  style: TextStyle(
                    fontFamily: "Monospace",
                    fontSize: 20,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoginButton(
                      onTap:() {
                        if (foundDisposal!.locationKey == "Garbage"){
                          setMode("Correct");
                        } else {
                          setMode("Incorrect");
                        }
                      },
                      child: const Text(
                        "Garbage",
                      ),
                    ),
                    LoginButton(
                      onTap:() {
                        if (foundDisposal!.locationKey == "Compost"){
                          setMode("Correct");
                        } else {
                          setMode("Incorrect");
                        }
                      },
                      child: const Text(
                        "Compost",
                      ),
                    ),
                    LoginButton(
                      onTap:() {
                        if (foundDisposal!.locationKey == "Recycling"){
                          setMode("Correct");
                        } else {
                          setMode("Incorrect");
                        }
                      },
                      child: const Text(
                        "Recycling",
                      ),
                    ),
                  ],
                ), 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoginButton(
                      onTap:() {
                        if (foundDisposal!.locationKey == "Textile Recycling Depot"){
                          setMode("Correct");
                        } else {
                          setMode("Incorrect");
                        }
                      },
                      child: const Text(
                        "Textiles",
                      ),
                    ),   
                    LoginButton(
                      onTap:() {
                        if (foundDisposal!.locationKey == "Electronic Recycling Depot"){
                          setMode("Correct");
                        } else {
                          setMode("Incorrect");
                        }
                      },
                      child: const Text(
                        "Electronics",
                      ),
                    ),
                  ],                                    
                ),
              ],
            ),
            bottomNavigationBar: Bottom(user: widget.user, setUser: widget.setUser,),
          );
        } else if (camera != null && foundDisposal != null && mode == "Correct") {
          return Scaffold(
            backgroundColor: Colors.green,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_rounded,
                  size: 75,
                ),
                LoginButton(
                  onTap: () {
                    widget.user!.updateStats(foundDisposal!.location);
                    Navigator.pushNamedAndRemoveUntil(context, '/wastewizard', (route) => false);
                  },
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      fontFamily: "Monospace",
                    ),
                  ),
                ),
              ],           
            ),
          );
        } else if (camera != null && foundDisposal != null && mode == "Incorrect") {
          return Scaffold(
            backgroundColor: Colors.red,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.close_rounded,
                  size: 75,
                ),
                LoginButton(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/wastewizard', (route) => false);
                  },
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      fontFamily: "Monospace",
                    ),
                  ),
                ),
              ],           
            ),
          );
        } else if (camera != null && foundDisposal != null && mode == "Discover") {
          Widget title = Text(
            "Disposal Location: ${foundDisposal!.locationKey}",
            style: const TextStyle(fontSize: 24)
          );
          Widget description = Text(foundDisposal!.description);

          List<Widget> content = [ title, description ];

          switch(foundDisposal!.location) {
              case DisposalLocation.unknown:
                content.add(
                  SizedBox (
                    height: 400,
                    width: 600,
                    child: QueryMap(
                      markers: foundDisposal!.searchedLocations!, 
                      position: LatLng(
                        foundDisposal!.disposalPosition!.latitude, 
                        foundDisposal!.disposalPosition!.longitude
                      )
                    ),
                  )
                );
                break;
              case DisposalLocation.recycling:
                content.add(
                  Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYY7_ycuMMr6eNbjZTWADe4VqeZMZ8mTvowQ&usqp=CAU", height: 400, width: 600)
                );
              case DisposalLocation.garbage:
                content.add(
                  Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxJhZLM9XbecBwMFsTsbpzj0aLZL2pQiLAUQ&usqp=CAU", height: 400, width: 600)
                );
              case DisposalLocation.compost:
                content.add(
                  Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmhgCZVOK_XNoO2F6FRaYyiDy68LywFhU_eQ&usqp=CAU", height: 400, width: 600)
                );
          }

          content.add(
            LoginButton(
              onTap: () => {
                setState(() {
                  mode = "";
                  foundDisposal = null;
                })
              }, 
              child: const Text("Continue", style: TextStyle(fontSize: 18),)
            )
          );

          return Scaffold (
            appBar: bar,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: content
            ),
          );
        } 
      return const Center(child: CircularProgressIndicator());
    }
}

class SelectMode extends StatelessWidget {
    SelectMode({super.key, required this.setMode, required this.bar, required this.user, required this.setUser});

    final PreferredSizeWidget bar;
    final Function setMode;
    final User? user;
    final Function setUser;


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
                    padding: const EdgeInsets.fromLTRB(10, 10, 2, 10),
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
                    padding: const EdgeInsets.fromLTRB(2, 10, 10, 10),
                    child: ElevatedButton(
                      onPressed: () => {
                          setMode("Discover")
                      }, 
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
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
            bottomNavigationBar: Bottom(user: user, setUser: setUser),
        );
    }
}
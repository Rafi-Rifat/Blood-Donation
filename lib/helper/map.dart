import 'package:auth_app/GET/controller.dart';
import 'package:auth_app/screens/home_screen.dart';
import 'package:auth_app/screens/request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../screens/signup_screen.dart';

//void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MapSample(),
//     );
//   }
// }

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
  //late final bool poll;
}

class MapSampleState extends State<MapSample> {
  //final cont=Get.put(Controller());
  final Controller cont=Get.find();
  GoogleMapController? mapController;
  LatLng markerLocation = LatLng(37.7749, -122.4194);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Marker Position'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: (controller) {
                mapController = controller;
              },
              onTap: (tapPosition) {
                // Update the marker position
                setState(() {
                  markerLocation = tapPosition;
                });
              },
              initialCameraPosition: CameraPosition(
                target: markerLocation,
                zoom: 12.0,
              ),
              markers: <Marker>[
                Marker(
                  markerId: MarkerId('marker_1'),
                  position: markerLocation,
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
                  infoWindow: InfoWindow(
                    title: 'Marker Title',
                    snippet: 'Marker Description',
                  ),
                ),
              ].toSet(),
            ),
          ),
          TextButton(
            onPressed: () {
              // You can use `markerLocation` as the selected location
              cont.lt=markerLocation;
              if(cont.pu==false){
                Get.to(SignUpScreen());
              }
              else{
                cont.homeIndex=1;
                Get.offAll(HomeScreen(user: cont.Cuser1));
              }
            },
            child: Text("Import Location"),
          ),
        ],
      ),
    );
  }
}

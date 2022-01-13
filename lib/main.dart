import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapApp(),
    );
  }
}

class MapApp extends StatefulWidget {
  @override
  _MapAppState createState() => _MapAppState();
}

class _MapAppState extends State<MapApp> {
  // LatLng point = LatLng(13.08, 80.27);
  // var location = [];

  @override
  Widget build(BuildContext context) {
    String accTok = dotenv.env['API_KEY'];
    GoogleMapController mycontroller;
    final Set<Marker> markers = new Set();
    const LatLng showLocation = LatLng(27.7089, 85.3086);
    
    // return Stack(
    //   children: [
    //     FlutterMap(
    //       options: MapOptions(
    //         onTap: (tapPos, p) async {
    //           location = await Geocoder.local.findAddressesFromCoordinates(
    //               Coordinates(p.latitude, p.longitude));

    //           setState(() {
    //             point = p;
    //           });
    //         },
    //         center: LatLng(13.08, 80.27),
    //         zoom: 10.0,
    //       ),
    //       layers: [
    //         TileLayerOptions(
    //           urlTemplate:
    //               'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token=$accTok',
    //           subdomains: ['a', 'b', 'c'],
    //         ),
    //         MarkerLayerOptions(
    //           markers: [
    //             Marker(
    //               width: 100.0,
    //               height: 100.0,
    //               point: point,
    //               builder: (ctx) => Container(
    //                 child: const Icon(
    //                   Icons.location_on,
    //                   color: Colors.red,
    //                   size: 40.0,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //     Padding(
    //       padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 34.0),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Card(
    //             //Location search
    //             child: TextField(
    //               decoration: InputDecoration(
    //                 contentPadding: EdgeInsets.all(16.0),
    //                 hintText: "Search for a place here",
    //                 prefixIcon: Icon(
    //                   Icons.location_on,
    //                   color: Colors.lightBlue,
    //                 ),
    //               ),
    //             ),
    //           ),
    //           Card(
    //             child: Padding(
    //               padding: const EdgeInsets.all(16.0),
    //               child: location.isEmpty
    //                   ? Text(
    //                       'Tap anywhere on the map!',
    //                       style: TextStyle(
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                     )
    //                   : Text(
    //                       '${location.first.featureName}, ${location.first.locality}, ${location.first.countryName}',
    //                       style: const TextStyle(
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                     ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );

    Set<Marker> getMarkers() {
      setState(() {
        markers.add(Marker(
          markerId: MarkerId(showLocation.toString()),
          position: showLocation,
          infoWindow: InfoWindow(title: 'First Marker', snippet: 'Description'),
          icon: BitmapDescriptor.defaultMarker,
        ));

        markers.add(Marker(
          markerId: MarkerId(showLocation.toString()),
          position: showLocation,
          infoWindow: InfoWindow(title: 'Second Marker', snippet: 'Description 2'),
          icon: BitmapDescriptor.defaultMarker,
        ));

        markers.add(Marker(
          markerId: MarkerId(showLocation.toString()),
          position: showLocation,
          infoWindow: InfoWindow(title: 'Third Marker', snippet: 'Description 3'),
          icon: BitmapDescriptor.defaultMarker,
        ));
      });
      return markers;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Tripscape'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 500.0,
            child: GoogleMap(
              onMapCreated: (controller) {
                setState(() {
                  mycontroller = controller;
                });
              },
              compassEnabled: true,
              initialCameraPosition: CameraPosition(
                target: showLocation,
                zoom: 14.0,
              ),
              zoomGesturesEnabled: true,
              markers: getMarkers(),
              mapType: MapType.satellite,
              
            ),
          ),
        ],
      ),
    );
  }
}

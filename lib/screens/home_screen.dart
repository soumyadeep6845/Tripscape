import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tripscape/blocs/application_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);

    return Scaffold(
      body: (applicationBloc.currentLocation == null)
          ? Center(
              child: Text('Loading...'),
            )
          : ListView(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Location here',
                  ),
                ),
                Container(
                  height: 300.0,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        applicationBloc.currentLocation.latitude,
                        applicationBloc.currentLocation.longitude,
                      ),
                      zoom: 14.0,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

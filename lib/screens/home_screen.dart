import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tripscape/blocs/application_bloc.dart';
import 'package:tripscape/models/place.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _mapController = Completer();
  StreamSubscription locationSubscription;
  StreamSubscription boundsSubscription;
  final _locationController = TextEditingController();

  @override
  void initState() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    locationSubscription =
        applicationBloc.selectedLocation.stream.listen((place) {
      if (place != null) {
        _locationController.text = place.name;
        _goToPlace(place);
      } else {
        _locationController.text = "";
      }
    });

    applicationBloc.bounds.stream.listen((bounds) async {
      final GoogleMapController controller = await _mapController.future;
      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50.0));
    });
    super.initState();
  }

  @override
  void dispose() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    applicationBloc.dispose();
    _locationController.dispose();
    boundsSubscription.cancel();
    locationSubscription.cancel();
    super.dispose();
  }

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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _locationController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      hintText: 'Search by City',
                      suffixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) => applicationBloc.searchPlaces(value),
                    onTap: () => applicationBloc.clearSelectedLocation(),
                  ),
                ),
                Stack(
                  children: [
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
                        onMapCreated: (GoogleMapController controller) {
                          _mapController.complete(controller);
                        },
                        markers: Set<Marker>.of(applicationBloc.markers),
                      ),
                    ),
                    if (applicationBloc.searchResults != null &&
                        applicationBloc.searchResults.length != 0)
                      Container(
                        height: 300.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          backgroundBlendMode: BlendMode.darken,
                        ),
                      ),
                    if (applicationBloc.searchResults != null &&
                        applicationBloc.searchResults.length != 0)
                      Container(
                        height: 300.0,
                        child: ListView.builder(
                          itemCount: applicationBloc.searchResults.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                applicationBloc
                                    .searchResults[index].description,
                                style: TextStyle(color: Colors.white),
                              ),
                              onTap: () {
                                applicationBloc.setSelectedLocation(
                                  applicationBloc.searchResults[index].placeId,
                                );
                              },
                            );
                          },
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 20.0,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Find nearest...',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 8.0,
                    children: [
                      FilterChip(
                        label: Text('Campground'),
                        onSelected: (val) =>
                            applicationBloc.togglePlaceType('campground', val),
                        selected: applicationBloc.placeType == 'campground',
                        backgroundColor: Colors.green,
                      ),
                      FilterChip(
                        label: Text('Bakery'),
                        onSelected: (val) =>
                            applicationBloc.togglePlaceType('bakery', val),
                        selected: applicationBloc.placeType == 'bakery',
                        backgroundColor: Colors.green,
                      ),
                      FilterChip(
                        label: Text('Airport'),
                        onSelected: (val) =>
                            applicationBloc.togglePlaceType('airport', val),
                        selected: applicationBloc.placeType == 'airport',
                        backgroundColor: Colors.green,
                      ),
                      FilterChip(
                        label: Text('Convenience Store'),
                        onSelected: (val) => applicationBloc.togglePlaceType(
                            'convenience_store', val),
                        selected:
                            applicationBloc.placeType == 'convenience_store',
                        backgroundColor: Colors.green,
                      ),
                      FilterChip(
                        label: Text('Gym'),
                        onSelected: (val) =>
                            applicationBloc.togglePlaceType('gym', val),
                        selected: applicationBloc.placeType == 'gym',
                        backgroundColor: Colors.green,
                      ),
                      FilterChip(
                        label: Text('Hospital'),
                        onSelected: (val) =>
                            applicationBloc.togglePlaceType('hospital', val),
                        selected: applicationBloc.placeType == 'hospital',
                        backgroundColor: Colors.green,
                      ),
                      FilterChip(
                        label: Text('Embassy'),
                        onSelected: (val) =>
                            applicationBloc.togglePlaceType('embassy', val),
                        selected: applicationBloc.placeType == 'embassy',
                        backgroundColor: Colors.green,
                      ),
                      FilterChip(
                        label: Text('Pharmacy'),
                        onSelected: (val) =>
                            applicationBloc.togglePlaceType('pharmacy', val),
                        selected: applicationBloc.placeType == 'pharmacy',
                        backgroundColor: Colors.green,
                      ),
                      FilterChip(
                        label: Text('Park'),
                        onSelected: (val) =>
                            applicationBloc.togglePlaceType('park', val),
                        selected: applicationBloc.placeType == 'park',
                        backgroundColor: Colors.green,
                      ),
                      FilterChip(
                        label: Text('Spa'),
                        onSelected: (val) =>
                            applicationBloc.togglePlaceType('spa', val),
                        selected: applicationBloc.placeType == 'spa',
                        backgroundColor: Colors.green,
                      ),
                      FilterChip(
                        label: Text('Train Station'),
                        onSelected: (val) => applicationBloc.togglePlaceType(
                            'train_station', val),
                        selected: applicationBloc.placeType == 'train_station',
                        backgroundColor: Colors.green,
                      ),
                      FilterChip(
                        label: Text('Casino'),
                        onSelected: (val) =>
                            applicationBloc.togglePlaceType('casino', val),
                        selected: applicationBloc.placeType == 'casino',
                        backgroundColor: Colors.green,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _goToPlace(Place place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target:
            LatLng(place.geometry.location.lat, place.geometry.location.lng),
        zoom: 14.0,
      ),
    ));
  }
}

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tripscape/models/place_search.dart';
import 'package:tripscape/services/geolocator_service.dart';
import 'package:tripscape/services/places_service.dart';

class ApplicationBloc with ChangeNotifier {
  final geoLocatorService = GeolocatorService();
  final placesService = PlacesService();
  
  Position currentLocation;
  List<PlaceSearch> searchResults;

  ApplicationBloc() {
    setCurrentLocation();
  }
  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
  }

  searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutoComplete(searchTerm);
    notifyListeners();
  }
}


import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:tripscape/models/place_search.dart';

class PlacesService {
  final key = dotenv.env['GOOGLE_API_KEY'];

  Future<List<PlaceSearch>> getAutoComplete(String search) async {
    var url = Uri.parse(
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=%28cities%29&key=$key");
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
<<<<<<< HEAD
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList(); 
=======
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
>>>>>>> a24a9a5305b06e0a00cde2bdf818ed90435f6636
  }
}

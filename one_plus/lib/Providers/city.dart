import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_physio/constants/UrlConstants.dart';
import 'package:my_physio/models/city.dart';


class CityProvider with ChangeNotifier {

  List<Cities> _city = [
  ];

  List<Cities> get cities {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._city];
  }
  Future<void> fetchAndSetCity() async {
    final url = Uri.parse(UrlConstants.FIREBASE_API_URL+'/city.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) ;
      if (extractedData == null) {
        return;
      }
      final List<Cities> loadedCity = [];
      print(extractedData);
      extractedData.forEach((cities) {
        print('aaa');
        loadedCity.add(
        cities["name"]
        );
      });
      print('abc');
      _city = loadedCity;
      //notifyListeners();
    } catch (error) {

      print(error.toString());
      throw (error);
    }
  }
}
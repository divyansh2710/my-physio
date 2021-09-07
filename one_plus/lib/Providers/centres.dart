  import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;
import 'package:my_physio/constants/UrlConstants.dart';
import 'package:my_physio/models/centres.dart';

import '../models/http_exception.dart';
class CentreProvider with ChangeNotifier {

  List<Centres> _centres = [
  ];  

    List<Centres> get centres {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._centres];
  }
  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse(UrlConstants.FIREBASE_API_URL+'/centres/jaipur.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) ;
      if (extractedData == null) {
        return;
      }
      final List<Centres> loadedCentres = [];
      print(extractedData);
      extractedData.forEach((centresData) {
        print('aaa');
        loadedCentres.add(Centres(
          centreName: centresData['centreName'],
          centreContact: centresData['centreContact'],
          centreLink: centresData['centreLink'],
          centreAddress: centresData['centreAddress'],
          cityId: centresData['cityId'],
          cardBackground:   int.parse(centresData['color']),
          cardIcon: FlutterIcons.heart_ant,
          lat: centresData['lat'],
          long: centresData['long']
        ));
      });
      print('abc');
      _centres = loadedCentres;
      //notifyListeners();
    } catch (error) {
      
      print(error.toString());
      throw (error);
    }
  }
  }
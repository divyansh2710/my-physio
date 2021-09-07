  import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;
import 'package:my_physio/constants/UrlConstants.dart';
import 'package:my_physio/models/Speciality.dart';
import 'package:my_physio/models/centres.dart';

import '../models/http_exception.dart';
class ServicesProvider with ChangeNotifier {

  List<Speciality> _services = [
  ];  

    List<Speciality> get services {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._services];
  }
  Future<void> fetchAndSetServices() async {
    final url = Uri.parse(UrlConstants.FIREBASE_API_URL+'/services.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) ;
      if (extractedData == null) {
        return;
      }
      final List<Speciality> loadedServices = [];
      print(extractedData);
      extractedData.forEach((servicesData) {
        print('aaa');
        loadedServices.add(Speciality(
          serviceName: servicesData['serviceName'],
          serviceImage: servicesData['serviceImage'],
          serviceDescription: servicesData['serviceDescription'],
          cardBackground:   int.parse(servicesData['color']),
          cardIcon: FlutterIcons.medicinebox_ant,

        ));
      });
      print('abc');
      _services = loadedServices;
      //notifyListeners();
    } catch (error) {
      
      print(error.toString());
      throw (error);
    }
  }
  }
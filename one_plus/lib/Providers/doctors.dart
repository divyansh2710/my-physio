  import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;
import 'package:my_physio/constants/UrlConstants.dart';
import 'package:my_physio/models/centres.dart';
import 'package:my_physio/models/doctordetails.dart';

import '../models/http_exception.dart';
class DoctorProvider with ChangeNotifier {

  List<DoctorDetails> _doctors = [
  ];  

    List<DoctorDetails> get doctors {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._doctors];
  }
  Future<void> fetchAndSetDoctors() async {
    final url = Uri.parse(UrlConstants.FIREBASE_API_URL+'/doctors/jaipur.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) ;
      if (extractedData == null) {
        return;
      }
      final List<DoctorDetails> loadedDoctors = [];
      print(extractedData);
      extractedData.forEach((doctorsData) {
        print('aaa');
        loadedDoctors.add(DoctorDetails(
          doctorName: doctorsData['doctorName'],
          doctorDescription: doctorsData['doctorDescription'],
          doctorJobTitle: doctorsData['doctorJobTitle'],
          
          image: doctorsData['image'],
          address: doctorsData['centre'],
          phone:   doctorsData['phone'],
          cardBackground:  [
        Color(0xffa1d4ed),
        Color(0xffa1d4ed),
      ],
          
        ));
      });
      print('abc');
      _doctors = loadedDoctors;
      //notifyListeners();
    } catch (error) {
      
      print(error.toString());
      throw (error);
    }
  }
  }
  import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:my_physio/constants/UrlConstants.dart';
import 'package:my_physio/models/AppointmentsData.dart';
import 'package:my_physio/models/centres.dart';
import 'package:my_physio/models/doctordetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';
class AppointmentsProvider with ChangeNotifier {

  List<AppointmentData> _appointments = [
  ];  

    List<AppointmentData> get appointments {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._appointments];
  }
  Future<void> fetchAndSetAppointments() async {
    print('inside service');
     final prefs = await SharedPreferences.getInstance();
     final extractedUserData = json.decode(prefs.getString('userData') as String);
     String role=prefs.getString('userRole') as String;
     print(role);
     String? _userId = extractedUserData['userId'] as String;
     String currentDate =DateFormat('dd-MM-yyyy').format(DateTime.now()); 
     String tomorrowsDate =DateFormat('dd-MM-yyyy').format(DateTime.now().add(const Duration(days: 1))); 
      final List<AppointmentData> loadedAppointments = [];
      if(role =='Doctor'){
    final url = Uri.parse(UrlConstants.FIREBASE_API_URL+'/doctorappointments/'+currentDate+'.json');
     final url1 = Uri.parse(UrlConstants.FIREBASE_API_URL+'/doctorappointments/'+tomorrowsDate+'.json');
try {
      final response = await http.get(url);
    //  print('b');
      print(response.body);
      final extractedData = json.decode(response.body) ;
      if (extractedData == null) {
        print('c1');
      
      }
      else{
      
      extractedData.forEach((appointmentsData) {
        loadedAppointments.add(AppointmentData(
          patientName: appointmentsData['patientName'],
          description: appointmentsData['description'],
          city: appointmentsData['city'],
          centre: appointmentsData['center'],
          date: appointmentsData['date'],
          mobile: appointmentsData['mobile'],
          service:   appointmentsData['service'],
          time: appointmentsData['time'],
          id: ''
          
        ));
      });
  
      _appointments = loadedAppointments;
      }
      //notifyListeners();
    } catch (error) {
      print('in error 1');
      print(error.toString());
      throw (error);
    }


        try {
      final response = await http.get(url1);
      //print('b');
      print(response.body);
      final extractedData = json.decode(response.body) ;
      if (extractedData == null) {
        print('c2');
      
      }
     
    else{
      extractedData.forEach((appointmentsData) {
        loadedAppointments.add(AppointmentData(
          patientName: appointmentsData['patientName'],
          description: appointmentsData['description'],
          city: appointmentsData['city'],
          centre: appointmentsData['center'],
          date: appointmentsData['date'],
          mobile: appointmentsData['mobile'],
          service:   appointmentsData['service'],
          time: appointmentsData['time'],
          id: ''
          
        ));
      });
  
      _appointments = loadedAppointments;
    }
      //notifyListeners();
    } catch (error) {
      print('in error 1');
      print(error.toString());
      throw (error);
    }

     
      }
      else{
    final url = Uri.parse(UrlConstants.FIREBASE_API_URL+'/appointments/'+_userId+'/'+currentDate+'.json');
     final url1 = Uri.parse(UrlConstants.FIREBASE_API_URL+'/appointments/'+_userId+'/'+tomorrowsDate+'.json');
   // print('a');
    try {
      final response = await http.get(url);
    //  print('b');
      print(response.body);
     // final extractedData = json.decode(response.body) ;
      final Map<String, dynamic> extractedData = json.decode(response.body);
      if (extractedData == null) {
        print('c1');
      
      }
      else{
      
      // extractedData.forEach((appointmentsData) {
      //   loadedAppointments.add(AppointmentData(
      //     patientName: appointmentsData['patientName'],
      //     description: appointmentsData['description'],
      //     city: appointmentsData['city'],
      //     centre: appointmentsData['center'],
      //     date: appointmentsData['date'],
      //     mobile: appointmentsData['mobile'],
      //     service:   appointmentsData['service'],
      //     time: appointmentsData['time'],
      //     id: ''
      //
      //   ));
      // });
      //
        extractedData.forEach((key, value) {


          value.forEach((valueData){
            print('ddd');
            print(valueData);
            loadedAppointments.add(AppointmentData(
                patientName: valueData['patientName'],
                description: valueData['description'],
                city: valueData['city'],
                centre: valueData['center'],
                date: valueData['date'],
                mobile: valueData['mobile'],
                service:   valueData['service'],
                time: valueData['time'],
                id: ''

            ));
          });
        });
        _appointments = loadedAppointments;
      //_appointments = loadedAppointments;
      }
      //notifyListeners();
    } catch (error) {
      print('in error 1');
      print(error.toString());
      throw (error);
    }


        try {
      final response = await http.get(url1);
      //print('b');
      print(response.body);
      final extractedData = json.decode(response.body) ;
      if (extractedData == null) {
        print('c2');
      
      }
     
    else{
      extractedData.forEach((appointmentsData) {
        loadedAppointments.add(AppointmentData(
          patientName: appointmentsData['patientName'],
          description: appointmentsData['description'],
          city: appointmentsData['city'],
          centre: appointmentsData['center'],
          date: appointmentsData['date'],
          mobile: appointmentsData['mobile'],
          service:   appointmentsData['service'],
          time: appointmentsData['time'],
          id: ''
          
        ));
      });
  
      _appointments = loadedAppointments;
    }
      //notifyListeners();
    } catch (error) {
      print('in error 1');
      print(error.toString());
      throw (error);
    }

    if(loadedAppointments.isEmpty){
final url3 = Uri.parse(UrlConstants.FIREBASE_API_URL+'/appointments/'+_userId+'.json');
    try {
      final response = await http.get(url3);
      print('b');
      print(response.body);
     // final extractedData = json.decode(response.body) ;
        final Map<String, dynamic> data = json.decode(response.body);
      if (data == null||data.isEmpty) {
        print('c3');
        
      }
      else{
data.forEach((key, value) {

 
  value.forEach((valueData){
    print('ddd');
print(valueData);
 loadedAppointments.add(AppointmentData(
           patientName: valueData['patientName'],
           description: valueData['description'],
           city: valueData['city'],
           centre: valueData['center'],
           date: valueData['date'],
           mobile: valueData['mobile'],
           service:   valueData['service'],
           time: valueData['time'],
           id: ''
          
         ));
  });
   });
   _appointments = loadedAppointments; 
      }
    } catch (error) {
      print('in error 1');
      print(error.toString());
      throw (error);
    }

    }
  }
  }
  }
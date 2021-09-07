import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class Centres {
  String centreName;
  int cardBackground;
  String centreAddress;
  String centreContact;
  var cardIcon;
  String centreLink;
  String cityId;
  double lat;
  double long;

  Centres({required this.centreName,required this.cardBackground,required this.cardIcon, required this.centreAddress,required this.centreContact,required this.centreLink,required this.cityId,required this.lat,required this.long});
}

List<Centres> centres = [
  // new Centres("Shyam Nagar", 0xFFec407a, FlutterIcons.heart_ant,'Metro Pillar No. 7','+9191919191'),
  // new Centres("Raja Park", 0xFF5c6bc0, FlutterIcons.tooth_mco,'Metro Pillar No. 7','+9191919191'),
  // new Centres("Vidhyut Nagar", 0xFFfbc02d, TablerIcons.eye,'Metro Pillar No. 7','+9191919191'),
  // new Centres("Tonk Road", 0xFF1565C0, Icons.wheelchair_pickup_sharp,'Metro Pillar No. 7','+9191919191'),
  // new Centres("Kumbha Marg", 0xFF2E7D32, FlutterIcons.baby_faw5s,'Metro Pillar No. 7','+9191919191'),
];
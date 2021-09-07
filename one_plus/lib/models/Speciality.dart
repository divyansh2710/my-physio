import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class Speciality {
   String serviceName;
  int cardBackground;
  var cardIcon;
  String serviceImage;
  String serviceDescription;

  Speciality({ required this.serviceName, required this.cardBackground,required this.cardIcon,required this.serviceImage,required this.serviceDescription});
}

// List<Speciality> specialities = [
//   new Speciality(
//       "Exercise therapy is defined as a regimen or plan of physical activities designed and prescribed to facilitate the patients to recover from diseases and any conditions, which disturb their movement and activity of daily life or maintain a state of well‐being [1] through neuro re‐education, gait training, and therapeutic activities. It is systemic execution of planned physical movements, postures, or activities intended to enable the patients to (1) reduce risk, (2) enhance function, (3) remediate or prevent impairment, (4) optimize overall health, and (5) improve fitness and well‐being ",
//       'assets/exercise.png') 
//   // new Speciality("ssdjfhdgfhdgfhd", 0xFFec407a, "sdiusdsdgsdsd",'Metro Pillar No. 7','+9191919191'),
//   //  new Speciality("ssdjfhdgfhdgfhd", 0xFFec407a, "sdiusdsdgsdsd",'Metro Pillar No. 7','+9191919191'),
//   // new Speciality("ssdjfhdgfhdgfhd", 0xFFec407a, "sdiusdsdgsdsd",'Metro Pillar No. 7','+9191919191'),
//   // new Speciality("Kumbha Marg", 0xFF2E7D32, FlutterIcons.baby_faw5s,'Metro Pillar No. 7','+9191919191'),
// ];

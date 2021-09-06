import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class CardModel {
  String doctor;
  int cardBackground;
  var cardIcon;

  CardModel(this.doctor, this.cardBackground, this.cardIcon);
}

List<CardModel> cards = [
  new CardModel("Exercise Therapy", 0xFFec407a, FlutterIcons.medicinebox_ant),
  new CardModel("ElectroTherapy Treatment", 0xFF5c6bc0, FlutterIcons.medicinebox_ant),
  new CardModel("Posture Correction", 0xFFfbc02d, FlutterIcons.medicinebox_ant),
  new CardModel("Interferrential Therapy", 0xFF1565C0, FlutterIcons.medicinebox_ant),
  new CardModel("Pain Management", 0xFF2E7D32, FlutterIcons.medicinebox_ant),
];
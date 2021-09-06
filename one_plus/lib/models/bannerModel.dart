import 'package:flutter/material.dart';

class BannerModel {
  String text;
  List<Color> cardBackground;
  String image;
  String title;

  BannerModel(this.text, this.cardBackground, this.image, this.title);
}

List<BannerModel> bannerCards = [
  new BannerModel(
      "Dr Atul Singh",
      [
        Color(0xffa1d4ed),
        Color(0xffa1d4ed),
      ],
      "https://lh3.googleusercontent.com/p/AF1QipMQUU4g2aFrb_Ze6YaHhTQ7GMXQNN0C2dX7XHbO=s1600-w400",
      "BPTh/BPT, MPTh/MPT - Musculoskeletal Physiotherapy"),
  new BannerModel(
      "Dr Nidhi Sharma",
      [
        Color(0xffa1d4ed),
        Color(0xffa1d4ed),
      ],
      "https://myphysioindia.in/wp-content/uploads/2021/04/WhatsApp-Image-2021-04-03-at-10.52.14-PM-370x410.jpeg",
      "BPTh/BPT- Musculoskeletal Physiotherapy"),
];

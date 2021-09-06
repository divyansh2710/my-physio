import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_physio/Providers/doctors.dart';
import 'package:my_physio/doctorProfile.dart';

import 'package:my_physio/models/bannerModel.dart';



class Carouselslider extends StatelessWidget {
   final DoctorProvider doctorsData;
  const Carouselslider(this.doctorsData);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider.builder(
        itemCount: this.doctorsData.doctors.length,
        itemBuilder: (context, index, realIndex) {
          return Container(
            //alignment:  Alignment.centerLeft,
            //width: MediaQuery.of(context).size.width,
            height: 140,
            margin: EdgeInsets.only(left: 0, right: 0, bottom: 20),
            padding: EdgeInsets.only(left: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                stops: [0.3, 0.7],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: this.doctorsData.doctors[index].cardBackground,
              ),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                        return DoctorProfile(this.doctorsData.doctors[index]);
                      }));


                // index == 0
                //     ? Navigator.push(context,
                //         MaterialPageRoute(builder: (BuildContext context) {
                //         return Disease();
                //       }))
                //     : Navigator.push(context,
                //         MaterialPageRoute(builder: (BuildContext context) {
                //         return DiseaseDetail(disease: 'Covid-19');
                //       }));
              },
              child: Stack(
                children: [
                  Image.asset(
                    this.doctorsData.doctors[index].image,
                    //'assets/414.jpg',
                    fit: BoxFit.fitHeight,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 7, right: 5),
                    alignment: Alignment.topRight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          this.doctorsData.doctors[index].doctorName,
                          //'Check Disease',
                          style: GoogleFonts.lato(
                            color: Colors.lightBlue[900],
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.lightBlue[900],
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          scrollPhysics: ClampingScrollPhysics(),
        ),
      ),
    );
  }
}

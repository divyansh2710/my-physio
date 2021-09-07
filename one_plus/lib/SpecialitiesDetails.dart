
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_physio/models/Speciality.dart';

class SpecialitiesDetails extends StatefulWidget {
  final Speciality speciality;
  const SpecialitiesDetails(this.speciality);
  @override
  _SpecialitiesDetailsState createState() => _SpecialitiesDetailsState();
}

class _SpecialitiesDetailsState extends State<SpecialitiesDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text(
          widget.speciality.serviceName,
          style: GoogleFonts.lato(color: Colors.black),
        ),
      ),
           body  : ListView(
                physics: ClampingScrollPhysics(),
                children:[
                  Image(image: AssetImage(
                     widget.speciality.serviceImage                  
                ),
                ),
                // ...specialities.map((document) {
                   Container(
     
                    margin: EdgeInsets.only(top: 10),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue[300],
                            ),
                            child: Text(
                              widget.speciality.serviceDescription,
                              style: GoogleFonts.lato(
                                  color: Colors.black54, fontSize: 18),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            padding: EdgeInsets.only(left: 20, right: 20),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blueGrey[50],
                            ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        
                        SizedBox(
                          height: 20,
                        ),
                        
                      ],
                    ),
                  )
              //  }).toList()
                ]
                )
                );
                
     }
}

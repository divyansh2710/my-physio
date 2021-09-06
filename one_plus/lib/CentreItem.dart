import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_physio/Providers/centres.dart';
import 'package:my_physio/centreProfile.dart';
import 'package:url_launcher/url_launcher.dart';


class CentreItem extends StatelessWidget {
  final CentreProvider centresData;
  CentreItem(this.centresData);


  @override
  Widget build(BuildContext context) {
    return   Container(
                      height: 150,
                      
                      padding: EdgeInsets.only(top: 14),
                      child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        
                        itemCount: centresData.centres.length,
                        itemBuilder: (context, index) {
                          //print("images path: ${cards[index].cardImage.toString()}");
                          return Container(
                            margin: EdgeInsets.only(right: 14),
                            height: 150,
                            width: 140,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(centresData.centres[index].cardBackground),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[400] as Color,
                                    blurRadius: 4.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(3, 3),
                                  ),
                                ]
                                // image: DecorationImage(
                                //   image: AssetImage(cards[index].cardImage),
                                //   fit: BoxFit.fill,
                                // ),
                                ),
                            // ignore: deprecated_member_use
                            child: FlatButton(
                             onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CentreProfile(centresData.centres[index])
                                  
                                        ),
                              );
                            },
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 29,
                                        child: Icon(
                                          centresData.centres[index].cardIcon,
                                          size: 26,
                                          color:
                                              Color( centresData.centres[index].cardBackground),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      centresData.centres[index].centreName,
                                      style: GoogleFonts.lato(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
  
                        })
      );

    }

  
}
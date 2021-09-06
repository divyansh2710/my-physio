import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_physio/SpecialitiesDetails.dart';
import 'package:my_physio/models/Speciality.dart';

class ServiceItem extends StatelessWidget {
final List<Speciality> service;

  const ServiceItem(this.service);

  @override
  Widget build(BuildContext context) {
    return Container(
                    height: 150,
                    padding: EdgeInsets.only(top: 14),
                    child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      itemCount: service.length,
                      itemBuilder: (context, index) {
                        //print("images path: ${cards[index].cardImage.toString()}");
                        return Container(
                          margin: EdgeInsets.only(right: 14),
                          height: 150,
                          width: 140,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(service[index].cardBackground),
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
                                    builder: (context) => SpecialitiesDetails(service[index])
                                  
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
                                        service[index].cardIcon,
                                        size: 26,
                                        color:
                                            Color(service[index].cardBackground),
                                      )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                
                                 Container(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    service[index].serviceName,
                                    style: GoogleFonts.lato(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ) 
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
  }
}
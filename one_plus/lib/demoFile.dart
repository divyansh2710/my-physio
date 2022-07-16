import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_physio/Providers/centres.dart';
import 'package:my_physio/models/AppointmentsData.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Providers/appointments.dart';

class demoPage extends StatefulWidget {

  @override
  _demoPageState createState() => _demoPageState();
}

class _demoPageState extends State<demoPage> {
  var _isInit = true;
  var _isLoading = true;
  @override
  void didChangeDependencies() {
    print('in change dep');
    if (_isInit) {
      if(mounted) {
        setState(() {
          _isLoading = true;
        });
      }
      Provider.of<AppointmentsProvider>(context,listen: false).fetchAndSetAppointments().then((_) {
        if(mounted)
        {   setState(() {

          _isLoading = false;

        });}
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // _checkDiff(DateTime _date) {
  //   var diff = DateTime.now().difference(_date).inHours;
  //   if (diff > 2) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
  final dbRef = FirebaseDatabase.instance.reference();
  Future<void>? deleteAppointment(String docID) {
    // return FirebaseFirestore.instance
    //     .collection('appointments')
    //     .doc(user.email.toString())
    //     .collection('pending')
    //     .doc(docID)
    //     .delete();
    return null;
  }
  Widget build(BuildContext context) {
    final appointmentsData = Provider.of<AppointmentsProvider>(context,listen: false);
    _launchCaller(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
    return _isLoading?Center(
      child:
      CircularProgressIndicator()
      ):appointmentsData.appointments.length==0?Center(
      child: Text("NO Appointments"),
    ):

       ListView.builder(

        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: appointmentsData.appointments.length,
        itemBuilder: (context, index) {
          var document = appointmentsData.appointments[index];
          // print(_compareDate(document.date.toString()));
          return Card(
            // SafeArea(
            //     child:Card(
            color: document.shared == 'true' ? Colors.white54 : Colors.white,
            elevation: 2,
            borderOnForeground: true,
            child: InkWell(
              onTap: () {},
              child: ExpansionTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        null != document.centre ? document.centre + "," +
                            document.city + " " : document.city + " ",
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(

                      null != document.date ? " " + document.date : '' + ' ' +
                          document.time,

                      style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      child: Icon(Icons.share),
                      onTap: () {
                        var data = document as String;
                        Share.share(data.toString());
                        dbRef..child("doctorappointments").child(document.date).child(document.key).update(
                            {
                              "shared":'true'
                            }
                        );

                      },
                    ),

                    SizedBox(
                      width: 0,
                    ),
                    GestureDetector(
                      child: Icon(Icons.share),
                      onTap: () {
                        var data = document as String;
                        Share.share(data.toString());
                        dbRef..child("doctorappointments").child(document.date).child(document.key).update(
                            {
                              "shared":'true'
                            }
                        );

                      },
                    ),

                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(

                    document.service,
                    style: GoogleFonts.lato(
                        color: Colors.black
                    ),
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 20, right: 10, left: 16),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              " Patient name: " + document.patientName,
                              style: GoogleFonts.lato(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextButton(
                              onPressed: () =>
                              {
                                  _launchCaller("tel:" + document.mobile)
                              },
                              
                              child: Text('Mobile: ' +
                                  document.mobile,
                                style: GoogleFonts.lato(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ),
                            // Text(
                            //   "Mobile: " +

                            //         document.mobile,


                            //   style: GoogleFonts.lato(
                            //     fontSize: 16,
                            //   ),
                            // ),
                          ],
                        ),
                        IconButton(
                          tooltip: 'Delete Appointment',
                          icon: Icon(
                            Icons.delete,
                            color: Colors.black87,
                          ),
                          onPressed: () {
                            print(">>>>>>>>>" + document.id);
                            // var _documentID = document.id;
                            //showAlertDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });

  }
}

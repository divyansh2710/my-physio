
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_physio/Providers/appointments.dart';
import 'package:share_plus/share_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAppointmentList extends StatefulWidget {
  @override
  _MyAppointmentListState createState() => _MyAppointmentListState();
}

class _MyAppointmentListState extends State<MyAppointmentList> {
    var _isInit = true;
  var _isLoading = false;
  // FirebaseAuth _auth = FirebaseAuth.instance;
  // User user;
  // String _documentID;

  // Future<void> _getUser() async {
  //   user = _auth.currentUser;
  // }

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

  String _dateFormatter(String _timestamp) {
    String formattedDate =
        DateFormat('dd-MM-yyyy').format(DateTime.parse(_timestamp));
    return formattedDate;
  }

  String _timeFormatter(String _timestamp) {
    String formattedTime =
        DateFormat('kk:mm').format(DateTime.parse(_timestamp));
    return formattedTime;
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        deleteAppointment('');
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirm Delete"),
      content: Text("Are you sure you want to delete this Appointment?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _checkDiff(DateTime _date) {
    var diff = DateTime.now().difference(_date).inHours;
    if (diff > 2) {
      return true;
    } else {
      return false;
    }
  }

  _compareDate(String _date) {
    if (_dateFormatter(DateTime.now().toString())
            .compareTo(_dateFormatter(_date)) ==
        0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    //_getUser();
  }

  @override
  Widget build(BuildContext context) {
  _launchCaller(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
print('in widget ');
    final appointmentsData = Provider.of<AppointmentsProvider>(context,listen: false);
    return _isLoading?Center(
        child: Container(
          height:70,
          width:70,
          child: CircularProgressIndicator(),
        ),
       ):SafeArea(
          child: appointmentsData.appointments.length == 0
              ? Center(
                  child: Text(
                    'No Appointment Scheduled',
                    style: GoogleFonts.lato(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                )
              : Container(
                 color: Colors.blue,
                child: ListView.builder(

                    scrollDirection: Axis.vertical,
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: appointmentsData.appointments.length,
                    itemBuilder: (context, index) {
                      var document = appointmentsData.appointments[index];
                     // print(_compareDate(document.date.toString()));
                      // if (_checkDiff(document.date)) {
                      //   deleteAppointment(document.id);
                      // }
                      return Card(
                        color:document.shared == 'true'? Colors.white54:Colors.white,
                        elevation: 2,
                        child: InkWell(
                          onTap: () {},
                          child: ExpansionTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    null!=document.centre?document.centre+","+document.city+" ":document.city+" ",
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(

                                          null!=document.date?" "+document.date:'' + ' '+ document.time,

                                  style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 0,
                                ),
                                IconButton(
                                  splashRadius: 20,
                                  icon: Icon(Icons.share),
                                  onPressed: () {
                                    var data = document.patientName +'('+document.mobile+")";
                                    print("share");
                                    Share.share(data);
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
                                  onPressed: () =>{
                                      _launchCaller("tel:" + document.mobile)
                                  },
                                  child: Text('Mobile: '+
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
                                        showAlertDialog(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              ),
      );

  }
}

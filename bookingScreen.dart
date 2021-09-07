import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:my_physio/Providers/centres.dart';
import 'package:my_physio/Providers/Services.dart';
import 'package:my_physio/constants/UrlConstants.dart';
import 'package:my_physio/models/centres.dart';

class BookingScreen extends StatefulWidget {
  final CentreProvider centres;
  final ServicesProvider services;

  const BookingScreen(this.centres,this.services);
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  //final TextEditingController _doctorController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();
  FocusNode f5 = FocusNode();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime selectedDate = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  String timeText = 'Select Time';
  late String dateUTC;
  late String date_Time;

  // Future<void> _getUser() async {
  //   user = _auth.currentUser;
  // }
  sendNotification(String name) async{
    final url = Uri.parse(UrlConstants.PUSH_NOTIFICATION_URL);
    final body = jsonEncode({
      "to":"/topics/Doctor",
      "notification":{
        "body":name,
        "title":'New Appointment'
      }
    });
    await http.post(url,
        headers: {
          'Content-Type':'application/json',
          'Authorization':UrlConstants.FCM_SERVER_KEY
        },
        body: body
    );

  }

  Future<void> selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    ).then(
      (date) {
        setState(
          () {
            selectedDate = date!;
            String formattedDate =
                DateFormat('dd-MM-yyyy').format(selectedDate);
            _dateController.text = formattedDate;
            dateUTC = DateFormat('yyyy-MM-dd').format(selectedDate);
          },
        );
      },
    );
  }

  Future<void> selectTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );

    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    String formattedTime = localizations.formatTimeOfDay(selectedTime!,
        alwaysUse24HourFormat: false);

    if (formattedTime != null) {
      setState(() {
        timeText = formattedTime;
        _timeController.text = timeText;
      });
    }
    date_Time = selectedTime.toString().substring(10, 15);
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: GoogleFonts.lato(fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => MyAppointments(),
        //   ),
        // );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Done!",
        style: GoogleFonts.lato(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        "Appointment is registered.",
        style: GoogleFonts.lato(),
      ),
      actions: [
        okButton,
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

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      //  selectTime(context);
     // _doctorController.text = widget.doctor;
    });

    //_getUser();
  }
    String selectedCenter='';
    String selectedService='';
    String selectedCity='';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowGlow();
            return true;
          },
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                child: Image(
                  image: AssetImage('assets/appointment.jpg'),
                  height: 250,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.only(top: 0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          'Enter Patient Details',
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: _nameController,
                        focusNode: f1,
                        validator: (value) {
                          if (value!.isEmpty)
                            return 'Please Enter Patient Name';
                          return null;
                        },
                        style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide: const BorderSide(width: 2.0),
                          ),
                          //  filled: true,
                          //  fillColor: Colors.grey[350],
                          hintText: 'Patient Name*',
                          hintStyle: GoogleFonts.lato(
                            color: Colors.black26,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        onFieldSubmitted: (String value) {
                          f1.unfocus();
                          FocusScope.of(context).requestFocus(f2);
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        focusNode: f2,
                        controller: _phoneController,
                        style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                              borderSide: const BorderSide(width: 2.0)),
                          // filled: true,
                          // fillColor: Colors.grey[350],
                          hintText: 'Mobile*',
                          hintStyle: GoogleFonts.lato(
                            color: Colors.black26,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Phone number';
                          } else if (value.length < 10) {
                            return 'Please Enter correct Phone number';
                          }
                          return null;
                        },
                        onFieldSubmitted: (String value) {
                          f2.unfocus();
                          FocusScope.of(context).requestFocus(f3);
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        focusNode: f3,
                        controller: _descriptionController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide: const BorderSide(width: 2.0),
                          ),
                          //filled: true,
                          // fillColor: Colors.grey[350],
                          hintText: 'Description',
                          hintStyle: GoogleFonts.lato(
                            color: Colors.black26,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        onFieldSubmitted: (String value) {
                          f3.unfocus();
                          FocusScope.of(context).requestFocus(f4);
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField(
                        style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide: const BorderSide(width: 2.0),
                          )),
                        items: widget.services.services.map((value) {
                          return DropdownMenuItem<String>(
                            value: value.serviceName,
                            child: new Text(value.serviceName),
                          );
                        }).toList(),
                        onChanged: (selectedServ) {
                         setState(() {
                selectedService = selectedServ as String;
              });

                        },
                        hint: Text('Select Service',style: TextStyle(
                           color: Colors.black26,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                        ),),

                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField(
                        style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide: const BorderSide(width: 2.0),
                          )),
                        items: widget.services.services.map((value) {
                          return DropdownMenuItem<String>(
                            value: value.serviceName,
                            child: new Text(value.serviceName),
                          );
                        }).toList(),
                        onChanged: (_) {},
                        hint: Text('Select City',style: TextStyle(
                           color: Colors.black26,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                        ),),

                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField(
                        style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide: const BorderSide(width: 2.0),
                          )),
                        items: widget.centres.centres.map((value) {
                          return DropdownMenuItem<String>(
                            value: value.centreName,
                            child: new Text(value.centreName),
                          );
                        }).toList(),
                        onChanged: ( selectedCent) {
     setState(() {
                selectedCenter = selectedCent as String;
              });

                        },
                        hint: Text('Select Center',style: TextStyle(
                           color: Colors.black26,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                        ),),

                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            TextFormField(
                              focusNode: f4,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  left: 20,
                                  top: 10,
                                  bottom: 10,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(90.0)),
                                  borderSide: const BorderSide(width: 2.0),
                                ),
                                // filled: true,
                                //  fillColor: Colors.grey[350],
                                hintText: 'Select Date*',
                                hintStyle: GoogleFonts.lato(
                                  color: Colors.black26,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              controller: _dateController,
                              validator: (value) {
                                if (value!.isEmpty)
                                  return 'Please Enter the Date';
                                return null;
                              },
                              onFieldSubmitted: (String value) {
                                f4.unfocus();
                                FocusScope.of(context).requestFocus(f5);
                              },
                              textInputAction: TextInputAction.next,
                              style: GoogleFonts.lato(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: ClipOval(
                                child: Material(
                                  color: Colors.indigo, // button color
                                  child: InkWell(
                                    // inkwell color
                                    child: SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Icon(
                                        Icons.date_range_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: () {
                                      selectDate(context);
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            TextFormField(
                              focusNode: f5,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  left: 20,
                                  top: 10,
                                  bottom: 10,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(90.0)),
                                  borderSide: const BorderSide(width: 2.0),
                                ),
                                //filled: true,
                                //fillColor: Colors.grey[350],
                                hintText: 'Select Time*',
                                hintStyle: GoogleFonts.lato(
                                  color: Colors.black26,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              controller: _timeController,
                              validator: (value) {
                                if (value!.isEmpty)
                                  return 'Please Enter the Time';
                                return null;
                              },
                              onFieldSubmitted: (String value) {
                                f5.unfocus();
                              },
                              textInputAction: TextInputAction.next,
                              style: GoogleFonts.lato(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: ClipOval(
                                child: Material(
                                  color: Colors.indigo, // button color
                                  child: InkWell(
                                    // inkwell color
                                    child: SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Icon(
                                        Icons.timer_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: () {
                                      selectTime(context);
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 2,
                            primary: Colors.indigo,
                            onPrimary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print(_nameController.text);
                              print(_dateController.text);
                              print(this.selectedCenter);
                              print(this.selectedService);
                             // print(widget.doctor);
                              sendNotification(_nameController.text);
                              showAlertDialog(context);
                              // _createAppointment();
                            }
                          },
                          child: Text(
                            "Book Appointment",
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> _createAppointment() async {
  //   print(dateUTC + ' ' + date_Time + ':00');
  //   FirebaseFirestore.instance
  //       .collection('appointments')
  //       .doc(user.email)
  //       .collection('pending')
  //       .doc()
  //       .set({
  //     'name': _nameController.text,
  //     'phone': _phoneController.text,
  //     'description': _descriptionController.text,
  //     'doctor': _doctorController.text,
  //     'date': DateTime.parse(dateUTC + ' ' + date_Time + ':00'),
  //   }, SetOptions(merge: true));

  //   FirebaseFirestore.instance
  //       .collection('appointments')
  //       .doc(user.email)
  //       .collection('all')
  //       .doc()
  //       .set({
  //     'name': _nameController.text,
  //     'phone': _phoneController.text,
  //     'description': _descriptionController.text,
  //     'doctor': _doctorController.text,
  //     'date': DateTime.parse(dateUTC + ' ' + date_Time + ':00'),
  //   }, SetOptions(merge: true));
  // }
}

import 'package:flutter/material.dart';
import 'package:my_physio/Providers/centres.dart';
import 'package:my_physio/Providers/Services.dart';
import 'package:my_physio/bookingScreen.dart';
import 'package:my_physio/myAppointmentList.dart';


class TabsScreen extends StatefulWidget {
    final CentreProvider centreProvider;
  final ServicesProvider servicesProvider;
  const TabsScreen( this.centreProvider,this.servicesProvider);
  @override
  _TabsScreenState createState() => _TabsScreenState( this.centreProvider,this.servicesProvider);

  
}

class _TabsScreenState extends State<TabsScreen> {
     final CentreProvider centreProvider;
  final ServicesProvider servicesProvider;
   List<Map<String, Object>> _pages = [];
_TabsScreenState(this.centreProvider,this.servicesProvider){
  _pages=[
    {
      'page': MyAppointmentList(),
      'title': 'My Appointments',
    },
    {
      'page': BookingScreen(centreProvider,servicesProvider),
      'title': 'Book Appointment',
    },
  ];
}
  
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'] as String),
      ),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.history_rounded),
            title: Text('My Appointments'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.app_registration),
            title: Text('Book Appointments'),
          ),
        ],
      ),
    );
  }
}

class AppointmentData{
String patientName;
String description;
String date;
String centre;
String service;
String id;
String time;
String city;
String mobile;

AppointmentData( {required this.patientName,required this.description,required this.date,required this.centre,required this.service,required this.id,required this.time,required this.city,required this.mobile});


}
// List<AppointmentData> appointmetns =[
//   // new DoctorProfile("Dr. Atul Singh", "Test ", "Health Expert", "https://lh3.googleusercontent.com/p/AF1QipMQUU4g2aFrb_Ze6YaHhTQ7GMXQNN0C2dX7XHbO=s1600-w400"),
//   new AppointmentData("Mr. Divyansh Kulshrestha",DateTime.now().add(Duration(days: 1)),"Shyam Nagar","Exercise Therapy",'1')
// ];
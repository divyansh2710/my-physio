class AppointmentData{
String name;
DateTime date;
String centre;
String service;
String id;

AppointmentData( this.name, this.date, this.centre,this.service,this.id);


}
List<AppointmentData> appointmetns =[
  // new DoctorProfile("Dr. Atul Singh", "Test ", "Health Expert", "https://lh3.googleusercontent.com/p/AF1QipMQUU4g2aFrb_Ze6YaHhTQ7GMXQNN0C2dX7XHbO=s1600-w400"),
  new AppointmentData("Mr. Divyansh Kulshrestha",DateTime.now().add(Duration(days: 1)),"Shyam Nagar","Exercise Therapy",'1')
];
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices{

  uploadUserDetails(userDetails){
    FirebaseFirestore.instance.collection('users').add(userDetails);
  }

  getUserByemail(String email){
    return FirebaseFirestore.instance.collection("users").where("email", isEqualTo: email).get();
  }
}
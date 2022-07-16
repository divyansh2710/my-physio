import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:my_physio/auth.dart';
import 'package:my_physio/homePage.dart';
import 'package:my_physio/models/http_exception.dart';
import 'package:my_physio/services/databaseService.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery
        .of(context)
        .size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .primaryColor,
          title: Text('My Physio', style: TextStyle(color: Colors.black)
          )),
      // resizeToAvoidBottomInset: false,
      body:

      Container(

        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/myphysio.PNG"),
                fit: BoxFit.cover)
        ),

        child: Stack(
          children: <Widget>[

            Container(
              decoration: BoxDecoration(
//              image: DecorationImage(
                //          image: AssetImage("assets/myphysio.PNG"),
                //        fit: BoxFit.fitWidth),
                gradient: LinearGradient(
                  colors: [

                    Color.fromRGBO(30, 157, 252, 0),
                    Color.fromRGBO(30, 107, 252, 0),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0, 1],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: deviceSize.height,
                width: deviceSize.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    Flexible(
                      flex: deviceSize.width > 600 ? 2 : 1,
                      child: AuthCard(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class AuthCard extends StatefulWidget {
  // const AuthCard({
  //   Key key,
  // }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  DatabaseServices databaseService = DatabaseServices();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            title: Text('An Error Occurred!'),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
     try {
    if (_authMode == AuthMode.Login) {
       setUserName(_emailController.text );
       await Provider.of<Auth>(context,listen:false).login(_authData['email'] as String, _authData['password'] as String);

    } else {
    await Provider.of<Auth>(context,listen:false).signup(_authData['email'] as String, _authData['password'] as String);

    Map<String,String> userDetails={
      "email":_emailController.text,
      "role": 'Patient',
      "name": _nameController.text
    };
    databaseService.uploadUserDetails(userDetails);
    sunscribeToNotify('Patient');
    }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      print('error is'+error.toString());
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (contex) => HomePage()));
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
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
    final deviceSize = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: 180),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 8.0,
          child: Container(
            height: _authMode == AuthMode.Signup ? 320 : 260,
            constraints:
                BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
            width: deviceSize.width * 0.75,
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    if (_authMode == AuthMode.Signup)
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(labelText: 'Name'),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Invalid email!';
                          }
                          return null;
                        },

                      ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'E-Mail'),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Invalid email!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _authData['email'] = value!;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 5) {
                          return 'Password is too short!';
                        }
                      },
                      onSaved: (value) {
                        _authData['password'] = value!;
                      },
                    ),
                    if (_authMode == AuthMode.Signup)
                      TextFormField(
                        enabled: _authMode == AuthMode.Signup,
                        decoration: InputDecoration(labelText: 'Confirm Password'),
                        obscureText: true,
                        validator: _authMode == AuthMode.Signup
                            ? (value) {
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match!';
                                }
                              }
                            : null,
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    if (_isLoading)
                      CircularProgressIndicator()
                    else
                      RaisedButton(
                        child:
                            Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                        onPressed: _submit,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                        color: Theme.of(context).primaryColor,
                        textColor: Theme.of(context).primaryTextTheme.button!.color,
                      ),
                    FlatButton(
                      child: Text(
                          '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                      onPressed: _switchAuthMode,
                      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      textColor: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 70,),
        RaisedButton(
          child:
          Text("Contact Us"),
          onPressed:(){_launchCaller("tel:9782468066");} ,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding:
          EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
          color: Theme.of(context).primaryColor,
          textColor: Theme.of(context).primaryTextTheme.button!.color,
        ),
      ],
    );
  }
  void sunscribeToNotify(topic)async{
    await FirebaseMessaging.instance.subscribeToTopic(topic);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      AwesomeNotifications().createNotification(
          content:NotificationContent(
              id: 1,
              channelKey: 'key1',
              title: message.notification?.title,
              body: message.notification?.body
          )
      );
    });
  }
  setUserName (String email) async {
    await databaseService.getUserByemail(email).then((val ) async {
      QuerySnapshot result;
      result = val;
     String username = result.docs[0].get("name");
      String role = result.docs[0].get("role");
      final prefs =  await SharedPreferences.getInstance();
      prefs.setString('userRole', role);
      String role2=prefs.getString('userRole') as String;
      print('user pref'+role2);
      sunscribeToNotify(role);
    });
  }

   setUserRole (String role) async {
final prefs =  await SharedPreferences.getInstance();
      prefs.setString('userRole', role);

   }

}



import 'package:flutter/material.dart';
import 'package:uts_akb/Animation/FadeAnimation.dart';
import 'package:uts_akb/utils/helper.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final RoundedLoadingButtonController _btnController2 =
      RoundedLoadingButtonController();

  Future<void> _showMyDialog(String _tittle, String _msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_tittle),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(_msg),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _doSomething(RoundedLoadingButtonController controller) async {
    Timer(Duration(seconds: 2), () {
      chekUser(cusername, cpassword);
      if (statusLog) {
        controller.success();
        nextScreen(context, "/Home");
      } else {
        controller.error();
      }
      Timer(Duration(seconds: 2), () {
        _btnController2.reset();
      });
    });
  }

  final cusername = TextEditingController();
  final cpassword = TextEditingController();
  var statusLog = false;

  void chekUser(TextEditingController _user, _pass) async {
    if (_user.text == "" && _pass.text == "") {
      _showMyDialog("Peringatan", "Username/Password masih kosong");
      statusLog = false;
    } else if (_user.text != "admin" && _pass.text != "admin") {
      _showMyDialog("Peringatan", "username/password salah");
      statusLog = false;
    } else if (_user.text == "admin" && _pass.text == "admin") {
      statusLog = true;
      Fluttertoast.showToast(
          msg: "Selamat Datang Kembali, Admin",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/background-dark.png'),
            fit: BoxFit.fill,
          )),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                FadeAnimation(
                  1,
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/images/Vector2.png'),
                      fit: BoxFit.fill,
                    )),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage('assets/images/Vector1.png'),
                            fit: BoxFit.fill,
                          )),
                        ),
                        Positioned(
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 100),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/logo_unikom.png'))),
                            ),
                          ),
                        ),
                        Positioned(
                          child: Container(
                            margin: EdgeInsets.only(top: 100),
                            child: Center(
                              child: Text(
                                "Ujian Tengah Semester\n AKB 2021",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                          1.8,
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[100]))),
                                  child: TextField(
                                    controller: cusername,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Username",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: cpassword,
                                    autofocus: false,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                )
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                        2,
                        RoundedLoadingButton(
                          color: Colors.indigo[600],
                          successColor: Colors.green[800],
                          controller: _btnController2,
                          onPressed: () => _doSomething(_btnController2),
                          borderRadius: 8,
                          child: Text('Login',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                          1.5,
                          Text(
                            "Logout",
                            style: TextStyle(
                                color: Color.fromRGBO(143, 148, 251, 1)),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

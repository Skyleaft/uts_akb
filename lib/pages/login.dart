import 'package:flutter/material.dart';
import 'package:uts_akb/Animation/FadeAnimation.dart';
import 'package:uts_akb/utils/helper.dart';


class Login extends StatelessWidget {

final cusername = TextEditingController();
final cpassword = TextEditingController();
var statusLog = false;

void chekUser (TextEditingController _user,_pass){
  if(_user.text =="" && _pass.text ==""){
    print("username/password masih kosong");
    statusLog = false;
  }
  else if(_user.text !="admin" && _pass.text !="admin"){
    print("username/password salah");
    statusLog = false;
  }
  else if(_user.text =="admin" && _pass.text =="admin"){
    statusLog = true;
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
                  )
              ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                FadeAnimation(1, Container(
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/Vector2.png'),
                          fit: BoxFit.fill,
                      )
                  ),
                  child: Stack(
                    children: <Widget>[
                      FadeAnimation(1.3, Positioned(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/Vector1.png'),
                              fit: BoxFit.fill,
                            )
                          ),
                        ),
                      ),
                      ),
                      Positioned(
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 100),
                              decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/logo_unikom.png')
                              )
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          child: Container(
                            margin: EdgeInsets.only(top: 100),
                            child: Center(
                              child: Text("Ujian Tengah Semester\n AKB 2021", 
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 20,),),
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
                       FadeAnimation(1.8, Container(
                         padding: EdgeInsets.all(5),
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(10),
                           boxShadow: [
                             BoxShadow(
                               color: Color.fromRGBO(143, 148, 251, .2),
                               blurRadius: 20.0,
                               offset: Offset(0, 10)
                             )
                           ]
                         ),
                         child: Column(
                           children: <Widget>[
                             Container(
                               padding: EdgeInsets.all(8.0),
                               decoration: BoxDecoration(
                                 border: Border(bottom: BorderSide(color: Colors.grey[100]))
                               ),
                               child: TextField(
                                 controller: cusername,
                                 decoration: InputDecoration(
                                   border: InputBorder.none,
                                   hintText: "Username",
                                   hintStyle: TextStyle(color: Colors.grey[400])
                                 ),
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
                                   hintStyle: TextStyle(color: Colors.grey[400])
                                 ),
                               ),
                             )
                           ],
                         ),
                       )),
                       SizedBox(height: 30,),
                       FadeAnimation(2,
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment(0.8, 0.0),
                                  colors: [
                                    Color.fromRGBO(83, 80, 224, 1),
                                    Color.fromRGBO(62, 61, 146, 1),
                                  ]
                                ),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: (){
                                    chekUser(cusername, cpassword);
                                    if(statusLog){
                                      nextScreen(context, "/Home");
                                    }
                                    },
                                    borderRadius: BorderRadius.circular(15.0),
                                    splashColor: Colors.indigo[400],
                                    child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    ),
                              ),
                            ),
                          ),
                       ),
                       SizedBox(height: 20,),
                       FadeAnimation(1.5, Text("Logout", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),)),
                     ],
                   ),
                ),
              ],
                  ),
                 
          ) ),
    );
  }
}

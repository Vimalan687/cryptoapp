import 'package:auto_size_text/auto_size_text.dart';
import 'package:cryptoapp/Authorization/auth_helper.dart';
import 'package:cryptoapp/screens/ResetPassword.dart';
import 'package:cryptoapp/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageMode createState() => _LoginPageMode();
}

class _LoginPageMode extends State<LoginPage> {
  GlobalKey<FormState> validkey = GlobalKey<FormState>();
  bool visible_text = true;
  TextEditingController email_Input = TextEditingController();
  TextEditingController password_Input = TextEditingController();
  String? _error;
  @override
  void initState() {
    super.initState();
  }

  Widget showAlert() {
    if (_error != null) {
      return Container(
        color: Colors.red,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: AutoSizeText(
                _error!,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _error = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: SingleChildScrollView(
        child: Form(
          key: validkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20.0),

              showAlert(),
              SizedBox(height: 20.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              ///////////////////////////////////EMAIL
              Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.people_alt,
                        size: 80.0,
                      ),
                      SizedBox(height: 20.0),

                      TextFormField(
                          controller: email_Input,
                          decoration: InputDecoration(
                              labelText: 'EMAIL',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "REQUIRED"),
                            EmailValidator(
                                errorText: "ENTER AN VALID EMAIL ID"),
                          ])),

                      ///////// PASSWORD
                      SizedBox(height: 20.0),
                      TextFormField(
                          controller: password_Input,
                          decoration: InputDecoration(
                            labelText: 'PASSWORD',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  visible_text = !visible_text;
                                });
                              },
                              child: Icon(
                                visible_text
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black87,
                                size: 24.0,
                              ),
                            ),
                          ),
                          obscureText: visible_text,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "REQUIRED"),
                          ])),
                    ],
                  )),
              /////// FORGET PASSWORD
              SizedBox(height: 5.0),
              Container(
                alignment: Alignment(1.0, 0.0),
                padding: EdgeInsets.only(top: 15.0, left: 20.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RESETPASSWORD(),
                        ));
                  },
                  child: InkWell(
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ),

////////////////////////////////////////////////////LOGIN

              const SizedBox(height: 10.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                        child: Text('LOGIN'),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 92, vertical: 10),
                            primary: Colors.green,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        onPressed: () async {
                          if (validkey.currentState!.validate()) {
                            // validation purpose
                            try {
                              await AuthHelper.signInWithEmail(
                                  // the variable being assign to auth helper variable
                                  email: email_Input.text,
                                  password: password_Input.text);
                            } catch (e) {
                              setState(() {
                                print(e);
                                // _error = e.message;
                              });
                            }
                          } else {
                            //////////////////dDOWN VALIDATION
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("ERROR IN SIGN IN"),
                              // duration: const Duration(seconds: 2),
                            ));
                          }
                        })
                  ]),

              //////////////////////////Google sign in
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SignInButton(
                    Buttons.Google,
                    onPressed: () async {
                      try {
                        await AuthHelper.signInWithGoogle();
                      } catch (e) {
                        print(e);
                        // _error = e.message;
                      }
                    },
                  ),
                ],
              ),
//////////////////////////////////// SIGN UP
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'New user ?',
                    style: TextStyle(fontFamily: 'Montserrat'),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SignupPage(),
                          ));
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),

////////////////////////////////////
            ],
          ),
        ),
      ),
    );
  }
}

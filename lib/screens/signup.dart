import 'package:auto_size_text/auto_size_text.dart';
import 'package:cryptoapp/Authorization/auth_helper.dart';
import 'package:cryptoapp/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  GlobalKey<FormState> validkey = GlobalKey<FormState>();

  bool visible_text = true;
  TextEditingController? email_Input;
  TextEditingController? password_Input;
  TextEditingController? _confirmPasswordController;
  String? _error;

  @override
  void initState() {
    super.initState();
    email_Input = TextEditingController(text: "");
    password_Input = TextEditingController(text: "");
    _confirmPasswordController = TextEditingController(text: "");
  }

  Widget showAlert() {
    if (_error != null) {
      return Container(
        color: Colors.amberAccent,
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
              const SizedBox(height: 100.0),
              showAlert(),

              ///////////////////////////////////EMAIL
              Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
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
                            RequiredValidator(errorText: "Required"),
                            EmailValidator(
                                errorText: "ENTER AN EXISTING EMAIL"),
                          ])),

                      /////////PASSWORD
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
                            RequiredValidator(errorText: "Required"),
                          ])),
                      ////////
                      SizedBox(height: 20.0),
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
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
                        validator: (confirmation) {
                          return confirmation!.isEmpty
                              ? 'Confirm password cant be empty'
                              : chkpass(confirmation, password_Input!.text)
                                  ? null
                                  : 'Confirm password and password does not match';
                        },
                      ),
                    ],
                  )),
              /////////////////////////////

              ///////////////////////////////////////
              const SizedBox(height: 10.0),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: <
                  Widget>[
                ElevatedButton(
                  child: Text('SIGN UP'),
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                      primary: Colors.green,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      textStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    if (validkey.currentState!.validate()) {
                      try {
                        await AuthHelper.signupWithEmail(
                            email: email_Input!.text,
                            password: password_Input!.text);

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text("Account have been cretead succesfully"),
                          duration: const Duration(seconds: 2),
                        ));

                        Navigator.of(context).pop();

                        return;
                      } catch (e) {
                        setState(() {
                          print(e);

                          // _error = e.message;
                        });
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Error occurred"),
                      ));
                    }
                  },
                )
              ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => LoginPage(),
                            ));
                      },
                      child: Text(
                        'BACK TO LOGIN',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}

bool chkpass(String currentValue, String checkValue) {
  if (currentValue == checkValue) {
    return true;
  } else {
    return false;
  }
}

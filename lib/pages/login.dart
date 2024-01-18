import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'forgot.dart';
import 'home.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure3 = true;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Center(
                child: Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  margin: EdgeInsets.all(12),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: 35.0, left: 0.0, right: 20.0),
                          child: Stack(
                            children: [
                              Container(
                                padding:
                                    EdgeInsets.fromLTRB(10.0, 110.0, 0.0, 0.0),
                                child: const Text('Welcome',
                                    style: TextStyle(
                                        fontSize: 70.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                padding:
                                    EdgeInsets.fromLTRB(10.0, 175.0, 0.0, 0.0),
                                child: const Text('Back',
                                    style: TextStyle(
                                        fontSize: 70.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                padding:
                                    EdgeInsets.fromLTRB(170.0, 175.0, 0.0, 0.0),
                                child: const Text('!',
                                    style: TextStyle(
                                        fontSize: 70.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green)),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'USERNAME',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                          ),
                          validator: (value) {
                            if (value!.length == 0) {
                              return "Email cannot be empty";
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Please enter a valid email");
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            emailController.text = value!;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: _isObscure3,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure3
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _isObscure3 = !_isObscure3;
                                  });
                                }),
                            labelText: 'PASSWORD',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                          ),
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return "Password cannot be empty";
                            }
                            if (!regex.hasMatch(value)) {
                              return ("please enter valid password min. 6 character");
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            passwordController.text = value!;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                            width: 400,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  // side: BorderSide(color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  visible = true;
                                });
                                signIn(emailController.text,
                                    passwordController.text);
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Visibility(
                            maintainSize: true,
                            maintainAnimation: true,
                            maintainState: true,
                            visible: visible,
                            child: Container(
                                child: CircularProgressIndicator(
                              color: Colors.white,
                            ))),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Do not have an account ?',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Register(),
                      ),
                    );
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }
}

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   bool _isObscure3 = true;
//   bool visible = false;
//   final _formkey = GlobalKey<FormState>();
//   final TextEditingController emailController = new TextEditingController();
//   final TextEditingController passwordController = new TextEditingController();

//   final _auth = FirebaseAuth.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: EdgeInsets.only(top: 35.0, left: 10.0, right: 20.0),
//             child: Stack(
//               children: [
//                 Container(
//                   padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
//                   child: const Text('Welcome',
//                       style: TextStyle(
//                           fontSize: 70.0, fontWeight: FontWeight.bold)),
//                 ),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(15.0, 175.0, 0.0, 0.0),
//                   child: const Text('Back',
//                       style: TextStyle(
//                           fontSize: 70.0, fontWeight: FontWeight.bold)),
//                 ),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(180.0, 175.0, 0.0, 0.0),
//                   child: const Text('!',
//                       style: TextStyle(
//                           fontSize: 70.0,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.green)),
//                 )
//               ],
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.only(top: 50.0, left: 30.0, right: 30.0),
//             child: Column(
//               children: [
//                 Form(
//                   key: _formkey,
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         controller: emailController,
//                         decoration: const InputDecoration(
//                           labelText: 'USERNAME',
//                           labelStyle: TextStyle(
//                             fontFamily: 'Montserrat',
//                             fontWeight: FontWeight.bold,
//                             color: Colors.grey,
//                           ),
//                           focusedBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: Colors.green),
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value!.length == 0) {
//                             return "Email cannot be empty";
//                           }
//                           if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
//                               .hasMatch(value)) {
//                             return ("Please enter a valid email");
//                           } else {
//                             return null;
//                           }
//                         },
//                         onSaved: (value) {
//                           emailController.text = value!;
//                         },
//                         keyboardType: TextInputType.emailAddress,
//                       ),
//                       SizedBox(height: 20.0),
//                       TextFormField(
//                         controller: passwordController,
//                         obscureText: _isObscure3,
//                         decoration: InputDecoration(
//                           suffixIcon: IconButton(
//                             icon: Icon(_isObscure3
//                                 ? Icons.visibility
//                                 : Icons.visibility_off),
//                             onPressed: () {
//                               setState(() {
//                                 _isObscure3 = !_isObscure3;
//                               });
//                             },
//                           ),
//                           labelText: 'PASSWORD',
//                           labelStyle: const TextStyle(
//                             fontFamily: 'Montserrat',
//                             fontWeight: FontWeight.bold,
//                             color: Colors.grey,
//                           ),
//                           focusedBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: Colors.green),
//                           ),
//                         ),
//                         validator: (value) {
//                           RegExp regex = RegExp(r'^.{6,}$');
//                           if (value!.isEmpty) {
//                             return 'Password cannot be empty';
//                           }
//                           if (!regex.hasMatch(value)) {
//                             return 'Please enter a valid password (min. 6 characters)';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) {
//                           passwordController.text = value!;
//                         },
//                         keyboardType: TextInputType.emailAddress,
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 50.0),
//                 Container(
//                   height: 40.0,
//                   child: Material(
//                     borderRadius: BorderRadius.circular(20.0),
//                     shadowColor: Colors.greenAccent,
//                     color: Colors.green,
//                     elevation: 7.0,
//                     child: GestureDetector(
//                       onTap: () async {
//                         setState(() {
//                           visible = true;
//                         });
//                         signIn(emailController.text, passwordController.text);
//                         setState(() {
//                           visible =
//                               false; // Hide the progress indicator after sign-in attempt
//                         });
//                       },
//                       child: Center(
//                         child: Text(
//                           'LOGIN',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: 'Montserrat'),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 70.0),
//                 Visibility(
//                     maintainSize: true,
//                     maintainAnimation: true,
//                     maintainState: true,
//                     visible: visible,
//                     child: Container(
//                         child: CircularProgressIndicator(
//                       color: Colors.white,
//                     ))),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       'Do not have an account ?',
//                       style: TextStyle(fontFamily: 'Montserrat'),
//                     ),
//                     SizedBox(width: 5.0),
//                     InkWell(
//                       onTap: () {
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => Register(),
//                           ),
//                         );
//                       },
//                       child: Text(
//                         'Register',
//                         style: TextStyle(
//                             color: Colors.green,
//                             fontFamily: 'Montserrat',
//                             fontWeight: FontWeight.bold,
//                             decoration: TextDecoration.underline),
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   void signIn(String email, String password) async {
//     if (_formkey.currentState!.validate()) {
//       try {
//         UserCredential userCredential =
//             await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: email,
//           password: password,
//         );
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => HomePage(),
//           ),
//         );
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'user-not-found') {
//           print('No user found for that email.');
//         } else if (e.code == 'wrong-password') {
//           print('Wrong password provided for that user.');
//         }
//       }
//     }
//   }
// }

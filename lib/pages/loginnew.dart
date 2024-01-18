// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'login.dart';
// import 'model.dart';

// class Register extends StatefulWidget {
//   @override
//   _RegisterState createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   _RegisterState();

//   bool showProgress = false;
//   bool visible = false;

//   final _formkey = GlobalKey<FormState>();
//   final _auth = FirebaseAuth.instance;
//   CollectionReference ref = FirebaseFirestore.instance.collection('users');
//   final TextEditingController passwordController = new TextEditingController();
//   final TextEditingController confirmpassController =
//       new TextEditingController();
//   final TextEditingController name = new TextEditingController();
//   final TextEditingController emailController = new TextEditingController();
//   final TextEditingController mobile = new TextEditingController();
//   bool _isObscure = true;
//   bool _isObscure2 = true;
//   File? file;
//   var options = [
//     'Student',
//     'Teacher',
//   ];
//   var _currentItemSelected = "Student";
//   var rool = "Student";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Container(
//                 child: Stack(
//                   children: <Widget>[
//                     Container(
//                       padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
//                       child: Text(
//                         'Signup',
//                         style: TextStyle(
//                             fontSize: 80.0, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.fromLTRB(260.0, 125.0, 0.0, 0.0),
//                       child: Text(
//                         '.',
//                         style: TextStyle(
//                             fontSize: 80.0,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.green),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                   padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
//                   child: Column(
//                     children: <Widget>[
//                       TextFormField(
//                         controller: emailController,
//                         decoration: InputDecoration(
//                             labelText: 'EMAIL',
//                             labelStyle: TextStyle(
//                                 fontFamily: 'Montserrat',
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.grey),
//                             // hintText: 'EMAIL',
//                             // hintStyle: ,
//                             focusedBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.green))),
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
//                         onChanged: (value) {},
//                         keyboardType: TextInputType.emailAddress,
//                       ),
//                       SizedBox(height: 10.0),
//                       TextFormField(
//                         obscureText: _isObscure,
//                         controller: passwordController,
//                         decoration: InputDecoration(
//                             suffixIcon: IconButton(
//                                 icon: Icon(_isObscure
//                                     ? Icons.visibility_off
//                                     : Icons.visibility),
//                                 onPressed: () {
//                                   setState(() {
//                                     _isObscure = !_isObscure;
//                                   });
//                                 }),
//                             labelText: 'PASSWORD ',
//                             labelStyle: TextStyle(
//                                 fontFamily: 'Montserrat',
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.grey),
//                             focusedBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.green))),
//                         validator: (value) {
//                           RegExp regex = new RegExp(r'^.{6,}$');
//                           if (value!.isEmpty) {
//                             return "Password cannot be empty";
//                           }
//                           if (!regex.hasMatch(value)) {
//                             return ("please enter valid password min. 6 character");
//                           } else {
//                             return null;
//                           }
//                         },
//                         onChanged: (value) {},
//                       ),
//                       SizedBox(height: 10.0),
//                       TextFormField(
//                           obscureText: _isObscure2,
//                           controller: confirmpassController,
//                           decoration: InputDecoration(
//                               suffixIcon: IconButton(
//                                   icon: Icon(_isObscure2
//                                       ? Icons.visibility_off
//                                       : Icons.visibility),
//                                   onPressed: () {
//                                     setState(() {
//                                       _isObscure2 = !_isObscure2;
//                                     });
//                                   }),
//                               labelText: 'CONFIRM PASSWORD ',
//                               labelStyle: TextStyle(
//                                   fontFamily: 'Montserrat',
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.grey),
//                               focusedBorder: UnderlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.green))),
//                           validator: (value) {
//                             if (confirmpassController.text !=
//                                 passwordController.text) {
//                               return "Password did not match";
//                             } else {
//                               return null;
//                             }
//                           },
//                           onChanged: (value) {}),
//                       SizedBox(height: 50.0),
//                       Container(
//                         // padding: EdgeInsets.symmetric(horizontal: 20.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "SELECT ROLE",
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                             ),
//                             SizedBox(height: 30),
//                             DropdownButtonFormField<String>(
//                               dropdownColor: Colors.white,
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20,
//                               ),
//                               // value: _currentItemSelected,
//                               items: options.map((String dropDownStringItem) {
//                                 return DropdownMenuItem<String>(
//                                   value: dropDownStringItem,
//                                   child: Text(dropDownStringItem),
//                                 );
//                               }).toList(),
//                               onChanged: (newValueSelected) {
//                                 setState(() {
//                                   _currentItemSelected = newValueSelected!;
//                                   rool = newValueSelected;
//                                 });
//                               },
//                               value: _currentItemSelected,
//                               decoration: InputDecoration(
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.green),
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 50.0),
//                       Container(
//                           height: 40.0,
//                           child: Material(
//                             borderRadius: BorderRadius.circular(20.0),
//                             shadowColor: Colors.greenAccent,
//                             color: Colors.green,
//                             elevation: 7.0,
//                             child: GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   showProgress = true;
//                                 });
//                               },
//                               child: Center(
//                                 child: Text(
//                                   'SIGNUP',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       fontFamily: 'Montserrat'),
//                                 ),
//                               ),
//                             ),
//                           )),
//                       SizedBox(height: 20.0),
//                       Container(
//                         height: 40.0,
//                         color: Colors.transparent,
//                         child: Container(
//                           decoration: BoxDecoration(
//                               border: Border.all(
//                                   color: Colors.black,
//                                   style: BorderStyle.solid,
//                                   width: 1.0),
//                               color: Colors.transparent,
//                               borderRadius: BorderRadius.circular(20.0)),
//                           child: InkWell(
//                             onTap: () {
//                               CircularProgressIndicator();
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => LoginPage(),
//                                 ),
//                               );
//                             },
//                             child: Center(
//                               child: Text('Go Back',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontFamily: 'Montserrat')),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   )),
//             ]));
//   }

//   void signUp(String email, String password, String rool) async {
//     CircularProgressIndicator();
//     if (_formkey.currentState!.validate()) {

//       await _auth
//           .createUserWithEmailAndPassword(email: email, password: password)
//           .then((value) => {postDetailsToFirestore(email, rool)})
//           .catchError((e) {});
//     }
//   }

//   postDetailsToFirestore(String email, String rool) async {
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     User? user = _auth.currentUser;
//     UserModel userModel = UserModel();
//     userModel.email = email;
//     userModel.uid = user!.uid;
//     userModel.wrool = rool;
//     await firebaseFirestore
//         .collection("users")
//         .doc(user.uid)
//         .set(userModel.toMap());

//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => LoginPage()));
//   }
// }

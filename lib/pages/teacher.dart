import 'package:demo_app/pages/addpost.dart';

import 'StudentList.dart';
import 'posts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'model.dart';

class Teacher extends StatefulWidget {
  String id;
  Teacher({required this.id});
  @override
  _TeacherState createState() => _TeacherState(id: id);
}
 int _selectedIndex = 0;
class _TeacherState extends State<Teacher> {
  String id;
  var rooll;
  var emaill;
  UserModel loggedInUser = UserModel();

  _TeacherState({required this.id});
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users") //.where('uid', isEqualTo: user!.uid)
        .doc(id)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
    }).whenComplete(() {
      CircularProgressIndicator();
      setState(() {
        emaill = loggedInUser.email.toString();
        rooll = loggedInUser.wrool.toString();
        id = loggedInUser.uid.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(96, 218, 218, 218),
         leading: IconButton(
          padding: EdgeInsets.only(top: 10),
              onPressed: () {
                logout(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
                weight: 10,
                
              )),
          title: Padding(
    padding: const EdgeInsets.only(top: 10.0), // Add space from the top
    child: Text(
      'Home',
      style: TextStyle(
        fontSize: 30,
        fontFamily: 'popins',
        fontWeight: FontWeight.bold,
        color: Colors.black87 // Make the text bold
      ),
    ),
  ),
          centerTitle: false,
          actions: [
            IconButton(onPressed: () {
              logout(context);
            }, icon: Icon(Icons.logout_rounded),padding: EdgeInsets.only(top: 10))
          ],
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Container(
                padding: EdgeInsets.only(
                    top: 5.0, left: 20.0, right: 20.0),
                child: Stack(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.fromLTRB(10.0, 110.0, 0.0, 0.0),
                      child: const Text('Welcome inspiring',
                          style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding:
                          EdgeInsets.fromLTRB(10.0, 175.0, 0.0, 0.0),
                      child: const Text('Teachers',
                          style: TextStyle(
                              fontSize: 50.0,
                              fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding:
                          EdgeInsets.fromLTRB(220.0, 175.0, 0.0, 0.0),
                      child: const Text('!',
                          style: TextStyle(
                              fontSize: 50.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
                    ),
                    Container(
                      padding:
                          EdgeInsets.fromLTRB(10.0, 250.0, 0.0, 0.0),
                      child: const Text('Connect, Communicate, Educate',
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.black54)),
                    )
                  ],
                ),
              ),
            const SizedBox(
              height: 50,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: Colors.green,
                ),
              ),
              minWidth: 350,        
              elevation: 7.0,
              height: 60,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => studentList(),
                  ),
                );
              },
              child: Text(
                "Show List of Student",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              color: Colors.green,
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: Colors.green,
                ),
              ),
              minWidth: 350,        
              elevation: 7.0,
              height: 60,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => posts(),
                  ),
                );
              },
              child: const Text(
                "Post an Announcement",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              color: Colors.green,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.black54,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Student List',
            backgroundColor: Colors.black54,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Handle navigation or content changes based on the selected index
    if (index == 1) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => studentList(),
        ),
      );
    } else if (index == 2) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => addnote(),
        ),
      );
    }
  }

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}

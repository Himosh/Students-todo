import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'addpost.dart';
import 'editpost.dart';

class posts extends StatefulWidget {
  @override
  _postsState createState() => _postsState();
}

class _postsState extends State<posts> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('posts').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => addnote()),
              );
            },
            tooltip: 'Add a Post',
            backgroundColor: Colors.green, // Set background color
            elevation: 5, // Add a slight elevation
            child: Icon(
              Icons.add,
              size: 30, // Increase the icon size
            ),
          ),

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(96, 218, 218, 218),
        leading: IconButton(
          padding: EdgeInsets.only(top: 10),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back to the previous screen (teacher page)
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            weight: 10,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0), // Add space from the top
          child: Text(
            'Announcements',
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'popins',
              fontWeight: FontWeight.bold,
              color: Colors.black87, // Make the text bold
            ),
          ),
        ),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            padding: EdgeInsets.only(top: 20), // Add space between AppBar and body
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            editnote(docid: snapshot.data!.docs[index]),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 15,
                          left: 15,
                          right: 15,
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          title: Text(
                            snapshot.data!.docChanges[index].doc['title'],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class studentList extends StatefulWidget {
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<studentList> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .where('wrool', isEqualTo: 'Student')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            'Student List',
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
      body: Container(
        padding: EdgeInsets.only(top: 20), // Add space between AppBar and body
        child: StreamBuilder(
          stream: _usersStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Something went wrong"),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        snapshot.data!.docChanges[index].doc['email'],
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      onTap: () {
                        // Handle onTap if needed
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

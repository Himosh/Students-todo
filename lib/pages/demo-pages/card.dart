// import 'package:flutter/material.dart';

// class CardsPage extends StatelessWidget {
//   const CardsPage({super.key});

//   static const List<Color> customGradient = [
//     Color(0xFF2193B0),
//     Color(0xFF6DD5ED)
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             // Add functionality to navigate back
//             // For example: Navigator.pop(context);
//           },
//         ),
//         title: const Text(
//           'Courses',
//           style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(16.0),
//         children: [
//           _buildCard('Machine learning', 'Charuka Dilshan', '22nd'),
//           _buildCard('Mobile application development', 'Teacher B', '22nd'),
//           _buildCard('Control System Design', 'Dr.Konara', '22nd'),
//           _buildCard('Computer Architecture', 'Dr.Subodha', '22nd'),
//           // Add more cards as needed
//         ],
//       ),
//     );
//   }

//   Widget _buildCard(String moduleName, String batchTeacher, String batch) {
//     return Card(
//       elevation: 5.0,
//       margin: EdgeInsets.symmetric(vertical: 8.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: customGradient,
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               moduleName,
//               style: const TextStyle(
//                   fontSize: 23.0,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.white),
//             ),
//             SizedBox(height: 8.0),
//             Text(
//               'For $batch Batch',
//               style: const TextStyle(
//                   fontSize: 15.0,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.white),
//             ),
//             SizedBox(height: 8.0),
//             Text(
//               'By $batchTeacher',
//               style:
//                   TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
//             ),
//             SizedBox(height: 16.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     // Handle enroll button click
//                     // You can add navigation or any other action here
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     shadowColor: Colors.transparent,
//                   ),
//                   child: const Text(
//                     'Enrol now',
//                     style: TextStyle(color: Colors.blue),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

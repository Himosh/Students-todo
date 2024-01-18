// import 'package:flutter/material.dart';

// class DashboardPage extends StatelessWidget {
//   const DashboardPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dashboard'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Announcements Section
//             _buildSectionTitle('Announcements'),
//             _buildAnnouncementCards(),

//             // Enrolled Classes Section
//             _buildSectionTitle('Enrolled Classes'),
//             _buildEnrolledClassCards(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionTitle(String title) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 8.0),
//       child: Text(
//         title,
//         style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
//       ),
//     );
//   }

//   Widget _buildAnnouncementCards() {
//     // Replace with your actual data or fetch from an API
//     List<Map<String, String>> announcements = [
//       {
//         'title': 'Important Announcement',
//         'date': '2024-01-15',
//         'module': 'Module A'
//       },
//       {
//         'title': 'Reminder: Exam Tomorrow',
//         'date': '2024-01-20',
//         'module': 'Module B'
//       },
//       {'title': 'New Course Added', 'date': '2024-01-25', 'module': 'Module C'},
//     ];

//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: List.generate(
//           announcements.length,
//           (index) => _buildAnnouncementCard(
//             announcements[index]['title']!,
//             announcements[index]['date']!,
//             announcements[index]['module']!,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildAnnouncementCard(String title, String date, String module) {
//     return Container(
//       width: 250.0,
//       margin: EdgeInsets.only(right: 16.0),
//       child: Card(
//         elevation: 5.0,
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8.0),
//               Text('Date: $date'),
//               SizedBox(height: 8.0),
//               Text('Module: $module'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildEnrolledClassCards() {
//     // Replace with your actual data or fetch from an API
//     List<String> enrolledClasses = ['Class A', 'Class B', 'Class C', 'Class D'];

//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: List.generate(
//           enrolledClasses.length,
//           (index) => _buildEnrolledClassCard(enrolledClasses[index]),
//         ),
//       ),
//     );
//   }

//   Widget _buildEnrolledClassCard(String className) {
//     return Container(
//       width: 150.0,
//       margin: EdgeInsets.only(right: 16.0),
//       child: Card(
//         elevation: 5.0,
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Center(
//             child: Text(
//               className,
//               style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:amburush/payment.dart';
import 'package:flutter/material.dart';

class AmbulanceBook extends StatefulWidget {
  const AmbulanceBook({super.key});

  @override
  State<AmbulanceBook> createState() => _AmbulanceBookState();
}

class _AmbulanceBookState extends State<AmbulanceBook> {
  String? selectedAmbulanceType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(10, 78, 159, 1),
        title: Text(
          'Ambulance Booking',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                Icons.local_hospital,
                size: 80,
                color: Color.fromRGBO(10, 78, 159, 1),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Select Ambulance Type:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: ['Basic', 'ICU', 'Cardiac', 'Neonatal']
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedAmbulanceType = value;
                });
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(10, 78, 159, 1),
                ),
                onPressed: () {
                  if (selectedAmbulanceType != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingConfirmationPage(
                            type: selectedAmbulanceType!),
                      ),
                    );
                  }
                },
                child: Text(
                  'Book Ambulance',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: Center(
                  child: Image.asset(
                'assets/ambulance.png',
                height: 200,
              )),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class BookingConfirmationPage extends StatelessWidget {
  final String type;
  const BookingConfirmationPage({super.key, required this.type});

  Future<void> sendEmail(String userEmail) async {
    final String apiKey =
        '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';
    final String sendGridUrl = 'https://api.sendgrid.com/v3/mail/send';

    final response = await http.post(
      Uri.parse(sendGridUrl),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "personalizations": [
          {
            "to": [
              {"email": userEmail}
            ],
            "subject": "🚑 Your Ambulance is on the Way!"
          }
        ],
        "from": {"email": "dhruvmehta634@gmail.com"},
        "content": [
          {
            "type": "text/plain",
            "value":
                "Hello, your $type ambulance has been dispatched. Track it live in the app!"
          }
        ]
      }),
    );

    if (response.statusCode == 202) {
      print("📩 Email sent successfully!");
    } else {
      print("❌ Failed to send email: ${response.body}");
    }
  }

  Future<String> getUserEmail() async {
    // Get current user ID from Firebase Auth
    final userId = FirebaseAuth.instance.currentUser!.uid;

    // Fetch user email from Firestore
    final userDoc =
        await FirebaseFirestore.instance.collection('Users').doc(userId).get();

    // Return email if exists, otherwise return default email
    return userDoc.exists ? userDoc['user_emailId'] : 'default@example.com';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(10, 78, 159, 1),
        title:
            Text('Booking Confirmation', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 100),
            SizedBox(height: 20),
            Text(
              'Your $type ambulance has been booked!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              
              style: ElevatedButton.styleFrom(
                
                  backgroundColor: Color.fromRGBO(10, 78, 159, 1)),
              onPressed: () async {
                String userEmail = await getUserEmail();
                await sendEmail(userEmail); // Send notification email
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PaymentPage()));
              },
              child: Text('Track', style: TextStyle(color: Colors.white,
              fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:http/http.dart'as http;

// import 'package:amburush/payment.dart';
// import 'package:flutter/material.dart';

// class AmbulanceBook extends StatefulWidget {
//   const AmbulanceBook({super.key});

//   @override
//   State<AmbulanceBook> createState() => _AmbulanceBookState();
// }

// class _AmbulanceBookState extends State<AmbulanceBook> {
//   String? selectedAmbulanceType;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromRGBO(10, 78, 159, 1),
//         title: Text(
//           'Ambulance Booking',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Icon(
//                 Icons.local_hospital,
//                 size: 80,
//                 color: Color.fromRGBO(10, 78, 159, 1),
//               ),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Select Ambulance Type:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             DropdownButtonFormField<String>(
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//               ),
//               items: ['Basic', 'ICU', 'Cardiac', 'Neonatal']
//                   .map((type) => DropdownMenuItem(
//                         value: type,
//                         child: Text(type),
//                       ))
//                   .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedAmbulanceType = value;
//                 });
//               },
//             ),
//             SizedBox(height: 20),
//             Center(
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color.fromRGBO(10, 78, 159, 1),
//                   // Text color
//                 ),
//                 onPressed: () {
//                   if (selectedAmbulanceType != null) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => BookingConfirmationPage(
//                             type: selectedAmbulanceType!),
//                       ),
//                     );
//                   }
//                 },
//                 child: Text(
//                   'Book Ambulance',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Center(
//                   child: Image.asset(
//                 'assets/ambulance.png',
//                 height: 200,
//               )),
//             ),
//             SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }
// }



// class BookingConfirmationPage extends StatelessWidget {
//   final String type;
//   const BookingConfirmationPage({super.key, required this.type});

//   Future<void> sendEmail(String userEmail) async {
//     final String apiKey = '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';
//     final String sendGridUrl = 'https://api.sendgrid.com/v3/mail/send';

//     final response = await http.post(
//       Uri.parse(sendGridUrl),
//       headers: {
//         'Authorization': 'Bearer $apiKey',
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         "personalizations": [
//           {
//             "to": [{"email": userEmail}], // Send email to the user
//             "subject": "🚑 Your Ambulance is on the Way!"
//           }
//         ],
//         "from": {"email": "your-email@example.com"},
//         "content": [
//           {
//             "type": "text/plain",
//             "value": "Hello, your $type ambulance has been dispatched. Track it live in the app!"
//           }
//         ]
//       }),
//     );

//     if (response.statusCode == 202) {
//       print("📩 Email sent successfully!");
//     } else {
//       print("❌ Failed to send email: ${response.body}");
//     }
//   }

//   Future<String> getUserEmail() async {
//     // Fetch user email from Firestore
//     final userDoc = await FirebaseFirestore.instance.collection('Users').doc('uid').get();
//     return userDoc.exists ? userDoc['user_emailId'] : 'default@example.com';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromRGBO(10, 78, 159, 1),
//         title: Text('Booking Confirmation', style: TextStyle(color: Colors.white)),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.check_circle, color: Colors.green, size: 100),
//             SizedBox(height: 20),
//             Text(
//               'Your $type ambulance has been booked!',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(10, 78, 159, 1)),
//               onPressed: () async {
//                 String userEmail = await getUserEmail();
//                 await sendEmail(userEmail); // Send notification email
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage()));
//               },
//               child: Text('Track', style: TextStyle(color: Colors.white)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

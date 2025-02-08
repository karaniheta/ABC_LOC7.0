import 'package:amburush/ambulance/ambulance_book.dart';
import 'package:amburush/health_history/health_history.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Add this import for FirebaseAuth

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    'Confirm Logout',
                    style: TextStyle(color: Color.fromRGBO(10, 78, 159, 1)),
                  ),
                  content: Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('Yes',
                          style:
                              TextStyle(color: Color.fromRGBO(10, 78, 159, 1))),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(
                        'No',
                        style: TextStyle(color: Color.fromRGBO(10, 78, 159, 1)),
                      ),
                    ),
                  ],
                ),
              ) ??
              false;
        },
        child: // Updated background color to white

            SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Hello!',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color:
                        Color.fromARGB(255, 55, 121, 201), // Updated text color
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'How can we assist you today?',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20.0),
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    DashboardButton(
                      title: 'Hospitals Near You',
                      iconAsset: 'assets/hospital.png', // URL of the image
                      onTap: () {
                        // Navigate to doctor appointment screen
                      },
                    ),
                    DashboardButton(
                      title: 'Book Appointments',
                      iconAsset: 'assets/appointment.png', // URL of the image
                      onTap: () {
                        // Navigate to lab test booking screen
                      },
                    ),
                    DashboardButton(
                      title: 'Ambulance Booking',
                      iconAsset: 'assets/ambulance.png', // URL of the image
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AmbulanceBook()),
                        );
                        // Navigate to upload prescriptions screen
                      },
                    ),
                    DashboardButton(
                      title: 'Upload Health History',
                      iconAsset: 'assets/history.png', // URL of the image
                      onTap: () {
                        String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HealthHistoryPage(uid: uid)),
                        );
                        // Navigate to chat application screen
                      },
                    ),
                    DashboardButton(
                      title: 'Pharmacies Near You',
                      iconAsset: 'assets/pharmacy.png',
                      onTap: () {},
                    ),
                    DashboardButton(
                        title: 'Quick First Aid Solutions',
                        iconAsset: 'assets/first-responder.png',
                        onTap: () {}),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class DashboardButton extends StatelessWidget {
  final String title;
  final String iconAsset; // Change IconData to String
  final VoidCallback onTap;

  DashboardButton({
    required this.title,
    required this.iconAsset, // Change IconData to String
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Color.fromARGB(255, 55, 121, 201),
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 55.0,
                width: 55.0,
                child: Image.asset(
                  iconAsset, // Use the iconUrl property
                  fit: BoxFit.contain, // Fit the image within the box
                  // Apply color if needed
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

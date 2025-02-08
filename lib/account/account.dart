import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:super_icons/super_icons.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late Future<Map<String, dynamic>?> userData;

  @override
  void initState() {
    super.initState();
    userData = fetchUserData();
  }

  Future<Map<String, dynamic>?> fetchUserData() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      // Handle unauthenticated state
      return null;
    }

    try {
      // Check the 'Users' collection
      final userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        return {'role': 'User', ...userDoc.data()!};
      }

      // Check the 'Drivers' collection
      final driverDoc = await FirebaseFirestore.instance
          .collection('Drivers')
          .doc(userId)
          .get();

      if (driverDoc.exists) {
        return {'role': 'Driver', ...driverDoc.data()!};
      }

      // If the user is not found in either collection
      return null;
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "Your Account",
            style: TextStyle(
                fontFamily: 'intersB',
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Color.fromRGBO(10, 78, 159, 1),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No user data found'));
          }

          final data = snapshot.data!;
          final role = data['role'];

          if (role == 'User') {
            return _buildUserView(data);
          } else if (role == 'Driver') {
            return _buildDriverView(data);
          } else {
            return const Center(child: Text('Unknown role'));
          }
        },
      ),
    );
  }

  Widget _buildUserView(Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
        ),
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.black,
          child: Icon(
            SuperIcons.is_profile_2user_bold,
            color: Colors.white,
            size: 50,
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Center(
          child: Container(
            padding: EdgeInsets.all(16),
            width: 400,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(12.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '                User Details',
                  style: TextStyle(
                      fontFamily: 'intersB', fontSize: 23, color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'User Name\n', // Label
                        style: TextStyle(
                          color: Colors.black, // Label color
                          fontSize: 18,
                          fontFamily: 'intersB',
                        ),
                      ),
                      TextSpan(
                        text: '${data['user_name']}', // User Name
                        style: TextStyle(
                          color: Colors.black, // User name color
                          fontSize: 16,
                          fontFamily: 'interR',
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.5,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Email\n', // Label
                        style: TextStyle(
                          color: Colors.black, // Label color
                          fontSize: 18,
                          fontFamily: 'intersB',
                        ),
                      ),
                      TextSpan(
                        text: '${data['user_emailId']}', // User Name
                        style: TextStyle(
                          color: Colors.black, // User name color
                          fontSize: 16,
                          fontFamily: 'interR',
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.5,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Date_of_Birth\n', // Label
                        style: TextStyle(
                          color: Colors.black, // Label color
                          fontSize: 18,
                          fontFamily: 'intersB',
                        ),
                      ),
                      TextSpan(
                        text: '${data['dob']}', // User Name
                        style: TextStyle(
                          color: Colors.black, // User name color
                          fontSize: 16,
                          fontFamily: 'interR',
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.5,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Account\n', // Label
                        style: TextStyle(
                          color: Colors.black, // Label color
                          fontSize: 18,
                          fontFamily: 'intersB',
                        ),
                      ),
                      TextSpan(
                        text: 'User', // User Name
                        style: TextStyle(
                          color: Colors.black, // User name color
                          fontSize: 16,
                          fontFamily: 'interR',
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.5,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Phone\n', // Label
                        style: TextStyle(
                          color: Colors.black, // Label color
                          fontSize: 18,
                          fontFamily: 'intersB',
                        ),
                      ),
                      TextSpan(
                        text: '${data['user_phoneNumber']}', // User Name
                        style: TextStyle(
                          color: Colors.black, // User name color
                          fontSize: 16,
                          fontFamily: 'interR',
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.5,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Address\n', // Label
                        style: TextStyle(
                          color: Colors.black, // Label color
                          fontSize: 18,
                          fontFamily: 'intersB',
                        ),
                      ),
                      TextSpan(
                        text: '${data['address']}', // User Name
                        style: TextStyle(
                          color: Colors.black, // User name color
                          fontSize: 16,
                          fontFamily: 'interR',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildDriverView(Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
        ),
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.black,
          child: Icon(
            SuperIcons.is_bank_outline,
            color: Colors.black,
            size: 50,
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Center(
          child: Container(
            padding: EdgeInsets.all(16),
            width: 400,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(12.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '                Driver Details',
                  style: TextStyle(
                      fontFamily: 'intersB', fontSize: 23, color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Driver Name\n', // Label
                        style: TextStyle(
                          color: Colors.black, // Label color
                          fontSize: 18,
                          fontFamily: 'intersB',
                        ),
                      ),
                      TextSpan(
                        text: '${data['driver_name']}', // User Name
                        style: TextStyle(
                          color: Colors.black, // User name color
                          fontSize: 16,
                          fontFamily: 'interR',
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.5,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Email\n', // Label
                        style: TextStyle(
                          color: Colors.black, // Label color
                          fontSize: 18,
                          fontFamily: 'intersB',
                        ),
                      ),
                      TextSpan(
                        text: '${data['driver_mail']}', // User Name
                        style: TextStyle(
                          color: Colors.black, // User name color
                          fontSize: 16,
                          fontFamily: 'interR',
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.5,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Phone\n', // Label
                        style: TextStyle(
                          color: Colors.black, // Label color
                          fontSize: 18,
                          fontFamily: 'intersB',
                        ),
                      ),
                      TextSpan(
                        text: '${data['driver_phoneNumber']}', // User Name
                        style: TextStyle(
                          color: Colors.black, // User name color
                          fontSize: 16,
                          fontFamily: 'interR',
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.5,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Account\n', // Label
                        style: TextStyle(
                          color: Colors.black, // Label color
                          fontSize: 18,
                          fontFamily: 'intersB',
                        ),
                      ),
                      TextSpan(
                        text: 'Driver', // User Name
                        style: TextStyle(
                          color: Colors.black, // User name color
                          fontSize: 16,
                          fontFamily: 'interR',
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.5,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Address\n', // Label
                        style: TextStyle(
                          color: Colors.black, // Label color
                          fontSize: 18,
                          fontFamily: 'intersB',
                        ),
                      ),
                      TextSpan(
                        text: '${data['driver_address']}', // User Name
                        style: TextStyle(
                          color: Colors.black, // User name color
                          fontSize: 16,
                          fontFamily: 'interR',
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.5,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Experience\n', // Label
                        style: TextStyle(
                          color: Colors.black, // Label color
                          fontSize: 18,
                          fontFamily: 'intersB',
                        ),
                      ),
                      TextSpan(
                        text: '${data['driver_experience']}', // User Name
                        style: TextStyle(
                          color: Colors.black, // User name color
                          fontSize: 16,
                          fontFamily: 'interR',
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.5,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'License \n', // Label
                        style: TextStyle(
                          color: Colors.black, // Label color
                          fontSize: 18,
                          fontFamily: 'intersB',
                        ),
                      ),
                      TextSpan(
                        text: '${data['driver_license']}', // User Name
                        style: TextStyle(
                          color: Colors.black, // User name color
                          fontSize: 16,
                          fontFamily: 'interR',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

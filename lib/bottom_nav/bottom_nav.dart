import 'package:amburush/dashboard.dart';
import 'package:amburush/feedback/feedback.dart';
import 'package:amburush/guidelines/guideline.dart';
import 'package:amburush/profile/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:super_icons/super_icons.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _NavbarState();
}

class _NavbarState extends State<BottomNavbar> {
  int _selectedIndex = 0;
  Map<String, dynamic>? userData;

  final List<Widget> pages = [Dashboard(), FeedbackPage(), Profile()];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchUserData();
    });
  }

  /// Fetches user data from Firestore.
  Future<void> fetchUserData() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      setState(() {
        userData = null;
      });
      return;
    }

    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        setState(() {
          userData = {'role': 'User', ...userDoc.data()!};
        });
        return;
      }

      final driverDoc = await FirebaseFirestore.instance
          .collection('Drivers')
          .doc(userId)
          .get();

      if (driverDoc.exists) {
        setState(() {
          userData = {'role': 'Driver', ...driverDoc.data()!};
        });
        return;
      }

      setState(() {
        userData = null;
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  /// Handles navigation tab changes.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: BottomNavigationBar(
          selectedFontSize: 12,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(SuperIcons.mg_home_4_fill),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(SuperIcons.is_ranking_1_bold),
              label: 'Feedback',
            ),
            BottomNavigationBarItem(
              icon: Icon(SuperIcons.bs_person_fill),
              label: 'Profile',
            ),
          ],
          selectedItemColor:
              Theme.of(context).bottomNavigationBarTheme.selectedItemColor ??
                  const Color.fromRGBO(10, 78, 159, 1),
          unselectedItemColor:
              Theme.of(context).bottomNavigationBarTheme.unselectedItemColor ??
                  Colors.grey,
          backgroundColor: Colors.white,
          elevation: Theme.of(context).bottomNavigationBarTheme.elevation ?? 0,
        ),
      ),
    );
  }
}

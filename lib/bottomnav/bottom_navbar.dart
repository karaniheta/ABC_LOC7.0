import 'package:flutter/material.dart';
import 'package:super_icons/super_icons.dart';


class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 0;
  final List<Widget> pages=[

  ];
  @override
  void _onItemTapped(int index)
  {
    setState(() {
      _selectedIndex=index;
    });
  }
    Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            
          },
          icon: Icon(Icons.info_outline, color:Color(0xFF1A998E) ),
        ),
        title: Text(
          'A M B U R U S H',
          style: TextStyle(
            fontFamily: 'interB',
            color: Color(0xFF1A998E),
          ),
        ),),
        body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: BottomNavigationBar(
          selectedFontSize: 14,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(SuperIcons.mg_home_4_fill),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(SuperIcons.lc_heartHandshake),
              label: 'Volunteer',
            ),
            BottomNavigationBarItem(
              icon: Icon(SuperIcons.bs_robot),
              label: 'AI Assistance',
            ),
            
            BottomNavigationBarItem(
              icon: Icon(SuperIcons.bs_person_fill),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor ??
            Color.fromARGB(255, 9, 128, 118),   
          unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor ??
            Colors.grey[400],
          backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor ??
              Colors.white,
          
          elevation: Theme.of(context).bottomNavigationBarTheme.elevation ?? 0,
        ),
      ),
    );
  }
}
   
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyCallButton extends StatelessWidget {
  const EmergencyCallButton({super.key});

  // Function to launch the phone dialer with an emergency number
  void _launchDialer() async {
    const String emergencyNumber =
        "tel:102"; // Change to your country's emergency number
    if (await canLaunchUrl(Uri.parse(emergencyNumber))) {
      await launchUrl(Uri.parse(emergencyNumber));
    } else {
      debugPrint("Could not launch dialer");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: Center(
              child: Text(
                "Emergency",
                style: TextStyle(
                    fontFamily: 'intersB',
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            backgroundColor: Color.fromRGBO(10, 78, 159, 1),
          ),
          SizedBox(
            height: 300,
          ),
          Center(
            child: ElevatedButton(
              onPressed: _launchDialer,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text(
                "📞 Call Emergency",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

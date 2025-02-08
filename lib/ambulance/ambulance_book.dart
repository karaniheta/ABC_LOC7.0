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
        title: Text('Ambulance Booking',
        style: TextStyle(
          color: Colors.white
        ),),
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
     // Text color
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
                child: Text('Book Ambulance',
                style: TextStyle(
                  color: Colors.white
                ),),
              ),
            ),
            Expanded(
              child: Center(
                child: Image.asset('assets/ambulance.png',
                height: 200,)
              ),
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Color.fromRGBO(10, 78, 159, 1),
        title: Text('Booking Confirmation',
        style: TextStyle(
                  color: Colors.white
                )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100,
            ),
            SizedBox(height: 20),
            Text(
              'Your $type ambulance has been booked!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
    backgroundColor: Color.fromRGBO(10, 78, 159, 1),
     // Text color
  ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Track',
              style: TextStyle(
                color: Colors.white
              ),),
            ),
          ],
        ),
      ),
    );
  }
}

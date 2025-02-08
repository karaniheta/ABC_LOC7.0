import 'package:amburush/auth.dart';
// import 'package:amburush/auth/login.dart';
import 'package:amburush/bottom_nav/bottom_nav.dart';
// import 'package:amburush/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:super_icons/super_icons.dart';

class SignorgPage extends StatefulWidget {
  const SignorgPage({super.key});

  @override
  State<SignorgPage> createState() => _SignorgPageState();
}

class _SignorgPageState extends State<SignorgPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _driverExperienceController = TextEditingController();
  final TextEditingController _driverLicenseController = TextEditingController();
  bool isLoading = false;

  void _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      String uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('Drivers').doc(uid).set({
        'driver_name': _nameController.text.trim(),
        'driver_emailId': _emailController.text.trim(),
        'driver_phoneNumber': _phoneController.text.trim(),
        'uid': uid,
        'role': 'Driver',
        'driver_address': _addressController.text.trim(),
        'driver_experience': _driverExperienceController.text.trim(),
        'driver_license': _driverLicenseController.text.trim(),
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNavbar()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Signup successful'),
          backgroundColor: Color(0xFF1E88E5),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signup failed: $e'),
          backgroundColor: const Color(0xFFE53935),
        ),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      Text('AmbuRush',
                          style: TextStyle(
                              fontFamily: 'interB',
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(10, 78, 159, 1))),
                      SizedBox(height: 60),
                      SizedBox(
                          height: 200,
                          child: Image.asset('assets/ambulance.png')),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(SuperIcons.ii_man),
                            labelText: 'Name'),
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Enter your name' : null,
                      ),
                      SizedBox(height: 10),
                       
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(SuperIcons.ii_mail),
                            labelText: 'Email'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            value == null || !value.contains('@')
                                ? 'Enter a valid email'
                                : null,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(SuperIcons.ii_lock_closed),
                            labelText: 'Password'),
                        obscureText: true,
                        validator: (value) => value == null || value.length < 6
                            ? 'Password must be at least 6 characters'
                            : null,
                      ),
                      SizedBox(height: 10),
                     
                      TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(SuperIcons.ii_call),
                            labelText: 'Phone'),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          final phoneRegExp =
                              RegExp(r'^\+?[1-9]\d{1,14}$'); // E.164 format
                          if (value == null || value.isEmpty) {
                            return 'Enter a valid phone number';
                          } else if (!phoneRegExp.hasMatch(value)) {
                            return 'Enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        controller: _addressController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(SuperIcons.ii_map),
                            labelText: 'Address'),
                        keyboardType: TextInputType.streetAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                    return 'Please enter your address.';
                  }
                  if (value.length < 10) {
                    return 'Address should be at least 10 characters long.';
                  }
                  if (!RegExp(r'^[a-zA-Z0-9\s,.-]+$').hasMatch(value)) {
                    return 'Address contains invalid characters.';
                  }
                  return null;
                },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _driverExperienceController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(SuperIcons.ii_star),
                            labelText: 'Driver Experience (years)'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter driver experience';
                          }
                          final num? exp = num.tryParse(value);
                          if (exp == null || exp < 0) {
                            return 'Enter a valid experience';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _driverLicenseController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(SuperIcons.ii_id_card),
                            labelText: 'Driver License Number'),
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Enter your license number' : null,
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _signUp,
                        child: Text('Sign Up',
                            style: TextStyle(color: Color(0xFFf1f5f5))),
                        style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                Color.fromRGBO(10, 78, 159, 1))),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

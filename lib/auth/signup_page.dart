import 'package:amburush/auth/login.dart';
import 'package:amburush/bottom_nav/bottom_nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:super_icons/super_icons.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  bool isLoading = false;

  /// Google Sign-In Function
  Future<void> _signinwithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // User canceled the login

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with Google credential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      String uid = userCredential.user!.uid;

      // Check if user exists in Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('Users').doc(uid).get();

      if (!userDoc.exists) {
        await FirebaseFirestore.instance.collection('Users').doc(uid).set({
          'user_name': googleUser.displayName ?? '',
          'user_emailId': googleUser.email,
          'user_phoneNumber': userCredential.user!.phoneNumber ?? '',
          'uid': uid,
          'role': 'User',
          'points': 0,
          'address': '',
        });
      }

      // Navigate to Home Page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNavbar()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google sign-in failed: $e')),
      );
    }
  }

  /// Email and Password Signup Function
  void _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      String uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('Users').doc(uid).set({
        'user_name': _nameController.text.trim(),
        'user_emailId': _emailController.text.trim(),
        'user_phoneNumber': _phoneController.text.trim(),
        'uid': uid,
        'role': 'User',
        'points': 0,
        'address': _addressController.text.trim(),
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNavbar()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signup successful')),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup failed: ${e.message}')),
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
                      const SizedBox(height: 40),
                      Text(
                        'AmbuRush',
                        style: TextStyle(
                          fontFamily: 'interB',
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(10, 78, 159, 1),
                        ),
                      ),
                      const SizedBox(height: 60),
                      SizedBox(
                        height: 180,
                        child: Image.asset('assets/ambulance.png'),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(SuperIcons.ii_man),
                          labelText: 'Name',
                        ),
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Enter your name' : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(SuperIcons.ii_mail),
                          labelText: 'Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            value == null || !value.contains('@') ? 'Enter a valid email' : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(SuperIcons.ii_lock_closed),
                          labelText: 'Password',
                        ),
                        obscureText: true,
                        validator: (value) =>
                            value == null || value.length < 6 ? 'Password must be at least 6 characters' : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(SuperIcons.ii_call),
                          labelText: 'Phone',
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          final phoneRegExp = RegExp(r'^\+?[1-9]\d{1,14}$');
                          if (value == null || value.isEmpty) return 'Enter a valid phone number';
                          if (!phoneRegExp.hasMatch(value)) return 'Enter a valid phone number';
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _addressController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(SuperIcons.ii_map),
                          labelText: 'Address',
                        ),
                        keyboardType: TextInputType.streetAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Please enter your address.';
                          if (value.length < 10) return 'Address should be at least 10 characters long.';
                          if (!RegExp(r'^[a-zA-Z0-9\s,.-]+$').hasMatch(value)) return 'Address contains invalid characters.';
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _signUp,
                        child: const Text('Sign Up'),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        ),
                        child: Text(
                          'Already have an account? Login',
                          style: TextStyle(color: Color(0xFF1E88E5), fontSize: 12),
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: _signinwithGoogle,
                        child: SizedBox(
                          height: 35,
                          width: 35,
                          child: Image.asset('assets/google icon.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

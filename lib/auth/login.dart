import 'package:amburush/auth/signup_page.dart';
import 'package:amburush/auth/user_type.dart';
import 'package:amburush/bottom_nav/bottom_nav.dart';
import 'package:amburush/dashboard.dart';
import 'package:amburush/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:super_icons/super_icons.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  bool keepMeLoggedIn = false; // Checkbox state

  @override
  void initState() {
    super.initState();
    _checkIfUserIsLoggedIn();
  }

  // Check if user is already logged in
  Future<void> _checkIfUserIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNavbar()),
      );
    }
  }

  // Save login status
  Future<void> _saveLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
  }

  // Logout function (Call this when user logs out)
  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    // Simulate a login process (replace with actual authentication logic)
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    if (keepMeLoggedIn) {
      await _saveLoginStatus(); // Save login status
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BottomNavbar()),
    );
  }
  Future<void> signinwithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // User canceled the login

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Navigate to Homepage after successful login
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavbar()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google sign-in failed: $e')),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AppBar(
                        automaticallyImplyLeading: false,
                        title: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontFamily: 'intersB',
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        backgroundColor: Color.fromRGBO(10, 78, 159, 1),
                      ),
                      const SizedBox(height: 60),
                      SizedBox(
                        height: 200,
                        child: Image.asset('assets/ambulance.png'),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(SuperIcons.ii_mail),
                          ),
                          labelText: 'Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            value == null || !value.contains('@')
                                ? 'Enter a valid email'
                                : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(SuperIcons.ii_lock_closed),
                          ),
                          labelText: 'Password',
                        ),
                        obscureText: true,
                        validator: (value) => value == null || value.length < 6
                            ? 'Password must be at least 6 characters'
                            : null,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Checkbox(
                            value: keepMeLoggedIn,
                            onChanged: (value) {
                              setState(() {
                                keepMeLoggedIn = value!;
                              });
                            },
                          ),
                          const Text('Keep me logged in'),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Usertype(),
                            ),
                          );
                        },
                        child: const Text(
                          'Don\'t have an account? Sign Up',
                          style: TextStyle(
                            color: Color(0xFF1E88E5),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _login,
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            const Color.fromRGBO(10, 78, 159, 1),
                          ),
                        ),
                        child: const Text(
                          'Log In',
                          style: TextStyle(color: Color(0xFFf1f5f5)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('OR'),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: signinwithGoogle, // Add Google login function here
                        child: SizedBox(
                          height: 35,
                          width: 35,
                          child: Image.asset('assets/google icon.png'),
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

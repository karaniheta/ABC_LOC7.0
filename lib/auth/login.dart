import 'package:flutter/material.dart';

import 'package:super_icons/super_icons.dart';

// import 'package:anvaya/constants/app_theme.dart';
// import 'package:anvaya/constants/colors.dart';

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
                            color: Color(0xFF69adb2)),
                      ),

                      const SizedBox(height: 60),
                      // Logo
                      SizedBox(
                        height: 200,
                        child: Image.asset('assets/ambulance.png'),
                      ),
                      const SizedBox(height: 20),
                      // Email Field
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(SuperIcons.ii_mail),
                            ),
                            labelText: 'Email'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            value == null || !value.contains('@')
                                ? 'Enter a valid email'
                                : null,
                      ),
                      const SizedBox(height: 10),
                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(SuperIcons.ii_lock_closed),
                            ),
                            labelText: 'Password'),
                        obscureText: true,
                        validator: (value) => value == null || value.length < 6
                            ? 'Password must be at least 6 characters'
                            : null,
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const SignUpPage(),
                          //   ),
                          // );
                        },
                        child: const Text(
                          'Don\'t have an account? Sign Up',
                          style: TextStyle(
                            color: Color(0xFF1E88E5),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Sign Up Button
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Color(0xFF69adb2))),
                        child: const Text(
                          'Log In',
                          style: TextStyle(color: Color(0xFFf1f5f5)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('OR'),
                      const SizedBox(height: 20),
                      // Social Login Options
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: SizedBox(
                              height: 35,
                              width: 35,
                              child: Image.asset('assets/google icon.png'),
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

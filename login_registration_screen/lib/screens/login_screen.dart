import 'package:flutter/material.dart';
import 'package:login_registration_screen/APIServices/api_services.dart';
import 'package:login_registration_screen/models/model.dart';
// import 'main_screen.dart';
import 'main_screen.dart';
import 'registration_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {


  final usertype=1;
  final ApiServices apiServices =ApiServices();

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;


  void _login() async{
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      LoginModel? result=await apiServices.loginWithModel(email, password);

      if (result != null) {
        // Successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content:Text('Invalid credentials. User does not exist or password is incorrect.')),
        // );

        setState(() {
          _errorMessage = 'Invalid credentials. User does not exist or password is incorrect.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          // Background Image
          SizedBox.expand(
            child: Image.asset(
              'assets/bkimg.jpg', // background img login 2nd screen
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Back arrow aligned to the left
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: IconButton(
                    //     icon: const Icon(Icons.arrow_back, color: Colors.black),///
                    //     onPressed: () => Navigator.pop(context),
                    //     padding: EdgeInsets.zero,
                    //   ),
                    // ),
                    const SizedBox(height: 90),

                    // Logo centered
                    Center(
                      child: Image.asset(
                        'assets/btclogo.png', // Logo path
                        height: 60,
                      ),
                    ),


                    const SizedBox(height: 35),

                    // Register Button aligned to the left

                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegistrationScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          textStyle: const TextStyle(fontSize: 12),
                        ),


                        child: const Text(
                          'New user Register Here',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),


                      ),
                    ),

                    const SizedBox(height: 24),

                    // Form section
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Center(
                            child: Text(
                              'Existing User Sign-in',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Email/Mobile Number Field
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email/Mobile Number',
                              labelStyle: TextStyle(color: Colors.white, fontSize: 12),
                              prefixIcon: Icon(Icons.email, color: Colors.white),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email or mobile number';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 16),

                          // Password Field
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.white, fontSize: 12),
                              prefixIcon: Icon(Icons.lock, color: Colors.white),
                              suffixIcon: Icon(Icons.visibility_off, color: Colors.white),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 24),
                          // Error message display
                          if (_errorMessage != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Text(
                                _errorMessage!,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),

                          // Sign In Button

                          ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                            ),
                            // padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01), // 2% of screen height
                            child: const Text('Sign In', style: TextStyle(color: Colors.white)),
                          ),

                          const SizedBox(height: 16),
                          // Forgot Password Button
                          TextButton(
                            onPressed: () {
                              // Implement forgot password logic
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 160),

                    // Footer text
                    const Text(
                      '© BharatTeleClinic, 2024 - All Rights Reserved.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.orange, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

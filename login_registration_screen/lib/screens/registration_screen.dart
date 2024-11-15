import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../APIServices/api_services.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {


  final TextEditingController email=TextEditingController();
  final TextEditingController password=TextEditingController();
  final TextEditingController fname=TextEditingController();
  final TextEditingController lname=TextEditingController();
  bool isLoading=false;


  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bkimg.jpg'), // Path to your background image
                fit: BoxFit.cover, // Cover the entire screen
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.zero,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Image.asset(
                    'assets/btclogo.png',
                    height: screenHeight * 0.07, // 8% of screen height
                    width: screenHeight * 0.07, // 8% of screen height
                  ),
                  SizedBox(height: screenHeight * 0.03), // Adjust height as needed
                  // Blue container around the form and button
                  Container(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(15), // Rounded corners
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: fname,
                            decoration: const InputDecoration(
                              labelText: 'First Name',
                              labelStyle: TextStyle(color: Colors.white,fontSize: 12),

                              prefixIcon: Icon(Icons.person,color: Colors.white),
                            )
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        TextFormField(
                          controller: lname,
                          decoration: const InputDecoration(
                            labelText: 'Last Name',
                            labelStyle: TextStyle(color: Colors.white,fontSize: 12),

                            prefixIcon: Icon(Icons.person,color: Colors.white),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  labelText: 'Gender',
                                  labelStyle: TextStyle(color: Colors.white,fontSize: 12),

                                  prefixIcon: Icon(Icons.wc,color: Colors.white),
                                ),
                                items: ['Male', 'Female', 'Other'].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (_) {},
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.04),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Age',
                                  labelStyle: TextStyle(color: Colors.white,fontSize: 12),

                                  prefixIcon: Icon(Icons.calendar_today,color: Colors.white),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: screenHeight * 0.02),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Aadhaar Number',
                            labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
                            prefixIcon: const Icon(Icons.credit_card, color: Colors.white),
                            counterText: '', // Hides the character counter
                          ),
                          keyboardType: TextInputType.number,
                          maxLength: 12, // Limit to 12 digits
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly, // Allow only digits
                          ],
                          style: const TextStyle(color: Colors.white), // Text color
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Aadhaar number';
                            } else if (value.length != 12) {
                              return 'Aadhaar number must be 12 digits';
                            }
                            return null; // Return null if valid
                          },
                        ),




                        SizedBox(height: screenHeight * 0.02),

                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Mobile Number',
                            labelStyle: TextStyle(color: Colors.white, fontSize: 12),
                            prefixIcon: Icon(Icons.phone, color: Colors.white),
                            counterText: '', // This hides the character counter
                          ),
                          keyboardType: TextInputType.phone, // Ensures the keyboard shows number layout
                          maxLength: 10, // Limits the input to 10 digits
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly, // Ensures only digits are allowed
                          ],
                          style: const TextStyle(color: Colors.white), // Text color
                          // Optionally, add validation if needed
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a mobile number';
                            } else if (value.length != 10) {
                              return 'Mobile number must be 10 digits';
                            }
                            return null; // Return null if valid
                          },
                        ),



                        SizedBox(height: screenHeight * 0.02),
                        TextFormField(
                          controller: email,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.white,fontSize: 12),

                            prefixIcon: Icon(Icons.email,color: Colors.white),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),



                        SizedBox(height: screenHeight * 0.02),
                        TextFormField(
                          controller: password,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.white,fontSize: 12),

                            prefixIcon: Icon(Icons.lock,color: Colors.white),
                            suffixIcon: Icon(Icons.visibility_off,color: Colors.white),
                          ),
                        ),



                        SizedBox(height: screenHeight * 0.02),
                        const Text(
                          'By Signing up, I agree to Terms & Conditions',
                          style: TextStyle(color: Colors.white, fontSize: 8),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        ElevatedButton(

                          onPressed: isLoading?null:RegistrationScreen,

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01), // 2% of screen height
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),

                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.01),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Existing User? Sign In'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

//The buildTextField method is a helper function designed to create a TextFormField with customizable properties
  Widget buildTextField({required String label, required IconData icon, bool isNumber = false, bool isEmail = false, bool isPassword = false}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
        prefixIcon: Icon(icon, color: Colors.white),
      ),
      keyboardType: isNumber
          ? TextInputType.number
          : isEmail
          ? TextInputType.emailAddress
          : TextInputType.text,
      obscureText: isPassword,
    );
  }



  Future<void> RegistrationScreen() async {
    if (email.text.isEmpty || password.text.isEmpty||fname.text.isEmpty||lname.text.isEmpty ) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await ApiServices().RegistrationScreen(email.text, password.text,fname.text,lname.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign up successful!')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}

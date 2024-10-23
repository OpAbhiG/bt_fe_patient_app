import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'MainScreen.dart';
void main() {
  runApp(const BharatTeleClinicApp());
}

class BharatTeleClinicApp extends StatelessWidget {
  const BharatTeleClinicApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bharat Tele Clinic',
      theme: ThemeData(
        primaryColor: const Color(0xFF1A237E),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.orange,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const LanguageClinicSelectionScreen(),
    );

  }
}


class LanguageClinicSelectionScreen extends StatefulWidget {
  const LanguageClinicSelectionScreen({super.key});

  @override
  _LanguageClinicSelectionScreenState createState() => _LanguageClinicSelectionScreenState();
}

class _LanguageClinicSelectionScreenState extends State<LanguageClinicSelectionScreen> {
  String? selectedLanguage;
  String? selectedClinic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.indigo, // Set the AppBar background color to indigo
      //   title: const Text(
      //     'Welcome to Bharat Tele ClinicApp',
      //     style: TextStyle(color: Colors.white,fontSize: 10), // Set the text color to white
      //   ),
      // ),

      body: Stack(

        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bluebg1.jpeg'), // Path to your background image 1st page
                fit: BoxFit.cover, // Cover the entire screen
              ),
            ),
          ),
          SafeArea(


            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(


                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(



                    padding: const EdgeInsets.only(top: 150), // Adjust the top padding as needed
                    child: SizedBox(
                      height: 60, // Adjust height as needed
                      width: 60, // Adjust width as needed
                      child: Image.asset(
                        'assets/btclogo.png',// logo 1st
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),





                  const SizedBox(height: 35),//Container adjusting point
                  // Blue container around the dropdowns and button
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(15), // Rounded corners
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildDropdownWithIcon(
                          'Language',
                          Icons.language,
                          ['English', 'Hindi (हिन्दी)', 'Bengali (বাংলা)', 'Marathi (मराठी)', 'Telugu (తెలుగు)', 'Tamil (தமிழ்)'],
                          selectedLanguage,
                              (String? newValue) {
                            setState(() {
                              selectedLanguage = newValue;
                            });
                          },
                        ),
                        const SizedBox(height: 30),

                        _buildDropdownWithIcon(

                          'Clinic',
                          Icons.home, // Icon for clinic
                          ['GTM4Health', 'Prakash Clinic', 'Sehat +', 'Mister Hair Clinic', 'Bharat TeleClinic', 'Krishnabhi Health Point'],
                          selectedClinic,
                              (String? newValue) {
                            setState(() {
                              selectedClinic = newValue;
                            });
                          },
                        ),





                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Continue',
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
                  const Spacer(),
                  const Text(
                    '© BharatTeleClinic, 2024 - All Rights Reserved.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

    );
  }

  // _buildDropdownWithIcon method where icon will stay visible
  Widget _buildDropdownWithIcon(String label, IconData icon, List<String> items, String? selectedValue, ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: selectedValue,
          // Always show the icon, whether an item is selected or not
          selectedItemBuilder: (BuildContext context) {
            return items.map<Widget>((String value) {
              return Row(
                children: [
                  Icon(icon, color: Colors.blue), // Keep the icon after selection
                  const SizedBox(width: 8),
                  Text(value, style: const TextStyle(color: Colors.black)),
                ],
              );
            }).toList();
          },
          hint: Row(
            children: [
              Icon(icon, color: Colors.blue), // Icon for the label
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                children: [
                  Icon(icon, color: Colors.blue), // Icon for each dropdown item
                  const SizedBox(width: 8),
                  Text(value),
                ],
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  void _login() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      if ((email == '7720024939' || email == 'gholapabhishek9@gmail.com') && password == '1234') {
        // Successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      } else {
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
              'assets/bgimg0.jpeg', // background img login 2nd screen
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    const SizedBox(height: 20),

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
                            MaterialPageRoute(builder: (context) => const RegistrationScreen()),
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
                      style: TextStyle(color: Colors.grey, fontSize: 10),
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

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

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
                image: AssetImage('assets/bgimg0.jpeg'), // Path to your background image
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
                    height: screenHeight * 0.08, // 8% of screen height
                    width: screenHeight * 0.08, // 8% of screen height
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
                          decoration: const InputDecoration(
                            labelText: 'First Name',
                            labelStyle: TextStyle(color: Colors.white,fontSize: 12),

                            prefixIcon: Icon(Icons.person,color: Colors.white),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        TextFormField(
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
                            SizedBox(width: screenWidth * 0.04),                            Expanded(
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
                          decoration: const InputDecoration(
                            labelText: 'Aadhaar Number',
                            labelStyle: TextStyle(color: Colors.white,fontSize: 12),

                            prefixIcon: Icon(Icons.credit_card,color: Colors.white),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Mobile Number',
                            labelStyle: TextStyle(color: Colors.white,fontSize: 12),

                            prefixIcon: Icon(Icons.phone,color: Colors.white),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.white,fontSize: 12),

                            prefixIcon: Icon(Icons.email,color: Colors.white),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        TextFormField(
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
                          onPressed: () {
                            // Implement sign up logic
                          },
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
}


///////////////////////////////////////////////////////////////////////////


class Doctor {
  final String name;
  final String specialty;
  final String imageUrl;
  final int experience;
  final int consultationFee;
  final String license;
  final String summary;

  Doctor({
    required this.name,
    required this.specialty,
    required this.imageUrl,
    required this.experience,
    required this.consultationFee,
    required this.license,
    required this.summary,
  });
}


class MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  List<Appointment> appointments = [];


  final List<Doctor> doctors = [
    Doctor(
        name: 'Dr. Aftab Kamrul Shaikh',
        specialty: 'General Physician',
        imageUrl: 'https://via.placeholder.com/150',
        experience: 7,
        consultationFee: 199,
        license: '66841',
        summary: 'Experienced general physician specializing in primary care and preventive medicine.'
    ),
    Doctor(
      name: 'Dr. Parvinsultan Sutar',
      specialty: 'General Physician',
      imageUrl: 'https://via.placeholder.com/150',
      experience: 12,
      consultationFee: 199,
      license: 'I-60654-E',
      summary: 'Seasoned doctor with expertise in managing chronic diseases and providing comprehensive healthcare.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: IndexedStack(
        index: _currentIndex,
        children: [
          DashboardScreen(

            appointments: appointments,
            onCancelAppointment: _cancelAppointment,
            onBookAppointment: _bookAppointment,
            doctors: doctors,
          ),
          DoctorScreen(doctors: doctors, onBookAppointment: _bookAppointment),
          const Profile(),
          AppointmentsScreen(appointments: appointments),
          const TreatmentScreen(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),

    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey[600],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.monitor_heart), label: 'Doctors'),

          BottomNavigationBarItem(icon: Icon(Icons.manage_accounts), label: ''),

          BottomNavigationBarItem(icon: Icon(Icons.date_range), label: 'Appointments'),
          BottomNavigationBarItem(icon: Icon(Icons.medical_services), label: 'Treatments'),
        ],
      ),
    );
  }

  void _bookAppointment(Doctor doctor, DateTime dateTime) {
    setState(() {
      appointments.add(Appointment(doctorName: doctor.name, dateTime: dateTime));
    });
  }

  void _cancelAppointment(Appointment appointment) {
    setState(() {
      appointments.remove(appointment);
    });
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}


class Appointment {
  final String doctorName;
  final DateTime dateTime;

  Appointment({required this.doctorName, required this.dateTime});
}

class _BookAppointmentDialogState extends State<BookAppointmentDialog> {
  Doctor? selectedDoctor;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Book an Appointment',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildDoctorDropdown(),
          const SizedBox(height: 16),
          _buildDateTimePicker(),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: selectedDoctor != null
                ? () {
              widget.onBookAppointment(selectedDoctor!, selectedDate);
              Navigator.of(context).pop();
            }
                : null,
            child: const Text('Book Appointment'),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorDropdown() {
    return DropdownButton<Doctor>(
      value: selectedDoctor,
      onChanged: (Doctor? newValue) {
        setState(() {
          selectedDoctor = newValue;
        });
      },
      hint: const Text('Select Doctor'),
      isExpanded: true,
      items: widget.doctors.map((Doctor doctor) {
        return DropdownMenuItem<Doctor>(
          value: doctor,
          child: Text(doctor.name),
        );
      }).toList(),
    );
  }

  Widget _buildDateTimePicker() {
    return InkWell(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (pickedDate != null) {
          setState(() {
            selectedDate = pickedDate;
          });
          // Call the time picker after selecting the date
          await _selectTime(context);
        }
      },
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Select Date',
          border: OutlineInputBorder(),
        ),
        child: Text(DateFormat('yyyy-MM-dd HH:mm').format(selectedDate)), // Update this line to show both date and time
      ),
    );
  }


  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        selectedDate = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }
}
class DashboardScreen extends StatelessWidget {
  final List<Appointment> appointments;
  final Function(Appointment) onCancelAppointment;
  final Function(Doctor, DateTime) onBookAppointment;
  final List<Doctor> doctors;

  const DashboardScreen({
    super.key,
    required this.appointments,
    required this.onCancelAppointment,
    required this.onBookAppointment,
    required this.doctors,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileCard(),
              const SizedBox(height: 30),
              _buildActionButtons(),
              const SizedBox(height: 30),
              _buildUpcomingAppointments(),
              const SizedBox(height: 30),
              _buildBookAppointmentButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/3135/3135715.png'),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'patient name',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Clinic's Patient ID: -",
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),


            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoItem('Blood Group', '-'),
                _buildInfoItem('Weight', '-'),
                _buildInfoItem('Age', '23 Yrs'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.grey),
        ),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionButton(Icons.medical_information_rounded, 'Medical Record'),
        _buildActionButton(Icons.history_outlined, 'Medical History'),
        _buildActionButton(Icons.medication, 'Drugs/Tests'),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }



  Widget _buildUpcomingAppointments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Upcoming Appointments',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              'View all',
              style: TextStyle(color: Colors.orange[700], fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 16),
        appointments.isEmpty
            ? const Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'No Appointments Found',

                style: TextStyle(color: Colors.grey,fontSize: 15),
              ),
            ),
          ),
        )
            : Column(
          children: appointments
              .map((appointment) => _buildAppointmentCard(appointment))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildAppointmentCard(Appointment appointment) {
    return Card(
      child: ListTile(
        title: Text(appointment.doctorName),
        subtitle: Text(DateFormat('yyyy-MM-dd HH:mm').format(appointment.dateTime)),
        trailing: ElevatedButton(
          onPressed: () => onCancelAppointment(appointment),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  Widget _buildBookAppointmentButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => _showBookAppointmentDialog(context),
        icon: const Icon(Icons.calendar_today,color: Colors.white,),
        label: const Text('Book an Appointment',style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  void _showBookAppointmentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: BookAppointmentDialog(
            doctors: doctors,
            onBookAppointment: onBookAppointment,
          ),
        );
      },
    );
  }



}
class DoctorScreen extends StatelessWidget {
  final List<Doctor> doctors;
  final Function(Doctor, DateTime) onBookAppointment;

  const DoctorScreen({
    super.key,
    required this.doctors,
    required this.onBookAppointment,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Doctor profile"),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,

      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return ListTile(
            title: Text(doctor.name),
            subtitle: Text(doctor.specialty),
            trailing: ElevatedButton(
              onPressed: () {
                _bookAppointmentDialog(context, doctor); // Method is now referenced here
              },
              child: const Text('Book Appointment'),
            ),
          );
        },
      ),
    );
  }

  void _bookAppointmentDialog(BuildContext context, Doctor doctor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: BookAppointmentDialog(
            doctors: [doctor],  // Pass the selected doctor
            onBookAppointment: onBookAppointment,  // Reference to the callback function
          ),
        );
      },
    );
  }
}

class Profile extends StatelessWidget {

  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,

      ),
      body: const Center(
        child: Text('profile screen'),
      ),
    );
  }
}

class AppointmentsScreen extends StatelessWidget {
  final List<Appointment> appointments;

  const AppointmentsScreen({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,

      ),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          return _buildAppointmentCard(appointments[index]);
        },
      ),
    );
  }

  Widget _buildAppointmentCard(Appointment appointment) {
    return Card(
      child: ListTile(
        title: Text(appointment.doctorName),
        subtitle: Text(DateFormat('yyyy-MM-dd HH:mm').format(appointment.dateTime)),
      ),
    );
  }
}
class AllAppointmentsScreen extends StatelessWidget {
  final List<Appointment> appointments;

  const AllAppointmentsScreen({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Appointments'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body:
      appointments.isEmpty
          ? const Center(child: Text('No Appointments Found'))
          : ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          return _buildAppointmentCard(appointments[index]);
        },
      ),
    );
  }

  Widget _buildAppointmentCard(Appointment appointment) {
    return Card(
      child: ListTile(
        title: Text(appointment.doctorName),
        subtitle: Text(DateFormat('yyyy-MM-dd HH:mm').format(appointment.dateTime)),
      ),
    );
  }
}
class BookAppointmentDialog extends StatefulWidget {
  final List<Doctor> doctors;
  final Function(Doctor, DateTime) onBookAppointment;

  const BookAppointmentDialog({
    super.key,
    required this.doctors,
    required this.onBookAppointment,
  });

  @override
  _BookAppointmentDialogState createState() => _BookAppointmentDialogState();
}
class TreatmentScreen extends StatelessWidget{
  const TreatmentScreen({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Treatment'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Treatment'),
      ),
    );
  }

}











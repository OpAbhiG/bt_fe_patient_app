import 'package:flutter/material.dart';
import 'login_screen.dart';

class Profile extends StatelessWidget {
  final VoidCallback onLogout;

  const Profile({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Schyler', // Optional: Custom font if available
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/limg.jpg'),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Abhishek Gholap', // Replace with API data later
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Clinics Patient ID: - ', // Replace with API data
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),

                _buildProfileDetail(label: 'First Name', value: 'Abhishek', isEditable: true, hasCalendarIcon: false),
                _buildProfileDetail(label: 'Last Name', value: 'Gholap', isEditable: true, hasCalendarIcon: true),
                // _buildProfileDetail(label: 'Date of Birth', value: 'DOB', isEditable: true, hasCalendarIcon: true),
                // _buildProfileDetail(label: 'Gender', value: 'Male', isEditable: false, hasCalendarIcon: false),
                // _buildProfileDetail(label: 'Age', value: '23 Yrs', isEditable: false, hasCalendarIcon: true),
                _buildProfileDetail(label: 'Aadhaar Number', value: '627136103936', isEditable: false, hasCalendarIcon: true),
                // _buildProfileDetail(label: 'Email', value: 'gholapabhishek9@gmail.com', isEditable: false, hasCalendarIcon: true),
                // _buildProfileDetail(label: 'Mobile Number', value: '9876543210', isEditable: true, hasCalendarIcon: true),
                _buildProfileDetail(label: 'Aadhaar Number', value: '123456789123', isEditable: true, hasCalendarIcon: true),
                _buildProfileDetail(label: 'Address', value: 'Solapur, Maharashtra', isEditable: true, hasCalendarIcon: true),
              ],
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to logout?.'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Logout'),
                        onPressed: () {
                          onLogout();
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                                (route) => false,
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            ),
            child: const Text(
              'Logout',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '© BharatTeleClinic, 2024 - All Rights Reserved.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.orange, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileDetail({required String label, required String value, required bool isEditable, required bool hasCalendarIcon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }


  // Widget _buildProfileDetail({required String label, required String value, bool isEditable = false, bool hasCalendarIcon = false}) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           label,
  //           style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  //         ),
  //         const SizedBox(height: 4),
  //         TextField(
  //           controller: TextEditingController(text: value),
  //           enabled: isEditable,
  //           decoration: InputDecoration(
  //             suffixIcon: hasCalendarIcon ? const Icon(Icons.calendar_today, color: Colors.orange) : null,
  //             filled: true,
  //             fillColor: isEditable ? Colors.white : Colors.grey[200],
  //             enabledBorder: OutlineInputBorder(
  //               borderSide: BorderSide(color: Colors.grey[300]!),
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //             disabledBorder: OutlineInputBorder(
  //               borderSide: BorderSide(color: Colors.grey[300]!),
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //           ),
  //           style: TextStyle(color: isEditable ? Colors.black : Colors.grey[600]),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildProfileDetail({required String label, required String value}) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           label,
  //           style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  //         ),
  //         const SizedBox(height: 4),
  //         Container(
  //           padding: const EdgeInsets.symmetric(horizontal: 12),
  //           decoration: BoxDecoration(
  //             color: Colors.grey[200],
  //             borderRadius: BorderRadius.circular(8),
  //             border: Border.all(color: Colors.grey[300]!),
  //           ),
  //           child: DropdownButtonHideUnderline(
  //             child: DropdownButton<String>(
  //               value: value,
  //               items: const [
  //                 DropdownMenuItem(value: 'Male', child: Text('Male')),
  //                 DropdownMenuItem(value: 'Female', child: Text('Female')),
  //               ],
  //               onChanged: (String? newValue) {},
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }



}

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
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  // Profile Picture and User Info Card
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('assets/limg.jpg'),
                          ),
                          const SizedBox(height: 10, width: 10),
                          const Text(
                            'Abhishek Gholap', // Replace with API data later
                            style: TextStyle(fontSize: 10),
                          ),
                          const SizedBox(height: 10, width: 10),
                          const Text(
                            'Clinics Patient ID: - ', // Replace with API data
                            style: TextStyle(
                              fontSize: 9,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Profile Details Card
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          _buildProfileDetail(label: 'First Name', value: 'Abhishek', isEditable: true, hasCalendarIcon: false),
                          _buildProfileDetail(label: 'Last Name', value: 'Gholap', isEditable: true, hasCalendarIcon: false),
                          // _buildProfileDetail(label: 'Date of Birth', value: 'DOB', isEditable: true, hasCalendarIcon: true),
                          // _buildProfileDetail(label: 'Gender', value: 'Male', isEditable: false, hasCalendarIcon: false, isDropdown: true),
                          _buildProfileDetail(label: 'Age', value: '23 Yrs', isEditable: false, hasCalendarIcon: false),
                          _buildProfileDetail(label: 'Aadhaar Number', value: '627136103936', isEditable: false, hasCalendarIcon: false),
                          _buildProfileDetail(label: 'Email', value: 'gholapabhishek9@gmail.com', isEditable: false, hasCalendarIcon: false),
                          _buildProfileDetail(label: 'Mobile Number', value: '9876543210', isEditable: true, hasCalendarIcon: false),
                          _buildProfileDetail(label: 'Address', value: 'Maharashtra', isEditable: true, hasCalendarIcon: false),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Logout',),
                      content: const Text('Are you sure you want to logout?..'),
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
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(fontSize: 14, color: Colors.white,fontWeight: FontWeight.bold),
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
      ),
    );
  }

  Widget _buildProfileDetail({
    required String label,
    required String value,
    bool isEditable = false,
    required bool hasCalendarIcon,
    bool isDropdown = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
          const SizedBox(height: 0.1),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal:15),
            child: isDropdown
                ? DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                items: const [
                  DropdownMenuItem(value: 'Male', child: Text('Male')),
                  DropdownMenuItem(value: 'Female', child: Text('Female')),
                ],
                onChanged: isEditable ? (String? newValue) {} : null,
              ),
            )
                : TextField(
              controller: TextEditingController(text: value),
              enabled: isEditable,
              decoration: InputDecoration(
                suffixIcon: hasCalendarIcon
                    ? const Icon(Icons.calendar_today, color: Colors.orange)
                    : null,
                border: InputBorder.none,
              ),
              style: TextStyle(color: isEditable ? Colors.black : Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }
}



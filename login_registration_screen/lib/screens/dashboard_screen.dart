
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/appointment.dart';
import '../models/doctor.dart';
import '../widgets/book_appointment_dialog.dart';

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
        automaticallyImplyLeading: false, // Remove back arrow
        title: const Text('Dashboard',style: TextStyle(
          fontSize: 18, // Adjust font size
          fontWeight: FontWeight.bold, // Make text bold
          fontFamily: 'Schyler', // Optional: Set a custom font family if you have one
        )),

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
              const SizedBox(height: 20),
              _buildActionButtons(context), // Pass context to the action buttons
              const SizedBox(height: 20),
              _buildUpcomingAppointments(),
              const SizedBox(height: 20),
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
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/limg.jpg'),
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
            const SizedBox(height: 15),
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
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionButton(
          context,
          Icons.medical_information_rounded,
          'Medical Record',
              () => _onMedicalRecordTapped(context),
        ),
        _buildActionButton(
          context,
          Icons.history_outlined,
          'Medical History',
              () => _onMedicalHistoryTapped(context),
        ),
        _buildActionButton(
          context,
          Icons.medication,
          'Drugs/Tests',
              () => _onDrugsTestsTapped(context),
        ),
      ],
    );
  }

  Widget _buildActionButton(
      BuildContext context,
      IconData icon,
      String label,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap, // Execute the passed function when tapped
      child: Column(
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
      ),
    );
  }

  // Action for Medical Record
  void _onMedicalRecordTapped(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MedicalRecordScreen()),
    );
  }

  // Action for Medical History
  void _onMedicalHistoryTapped(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MedicalHistoryScreen()),
    );
  }

  // Action for Drugs/Tests
  void _onDrugsTestsTapped(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DrugsTestsScreen()),
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
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Text(
              'View all',
              style: TextStyle(color: Colors.orange[700], fontWeight: FontWeight.bold, fontSize: 10),
            ),
          ],
        ),
        const SizedBox(height: 15),
        appointments.isEmpty
            ? const Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'No Appointments Found',
                style: TextStyle(color: Colors.grey, fontSize: 10),
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
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
          child: const Text('Cancel', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildBookAppointmentButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => _showBookAppointmentDialog(context),
        icon: const Icon(Icons.calendar_today, color: Colors.white),
        label: const Text('Book an Appointment', style: TextStyle(color: Colors.white)),
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
            borderRadius: BorderRadius.circular(30),
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



class MedicalRecordScreen extends StatelessWidget {
  const MedicalRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text('Medical Record'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,


      ),

      body: Center(
        child: const Text('Medical Record Content'),
      ),
    );
  }
}
class MedicalHistoryScreen extends StatelessWidget {
  const MedicalHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medical History'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,

      ),
      body: Center(
        child: const Text('Medical Record Content'),
      ),
    );
  }
}
class DrugsTestsScreen extends StatelessWidget {
  const DrugsTestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Drug & Lab Tests'),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          bottom: const TabBar(

            labelColor: Colors.white, // Active tab color
            unselectedLabelColor: Colors.white54, // Inactive tab color
            indicatorColor: Colors.orange, // Line under the active tab

            labelStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold), // Active tab text style
            unselectedLabelStyle: TextStyle(fontSize: 10.0), // Inactive tab text style

            tabs: [
              Tab(icon: Icon(Icons.receipt_long), text: 'My ePrescription'),
              Tab(icon: Icon(Icons.science), text: 'Lab Test'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('ePrescription Content', style: TextStyle(fontSize: 18))),
            Center(child: Text('Lab Test Content', style: TextStyle(fontSize: 18))),
          ],
        ),
      ),
    );
  }
}

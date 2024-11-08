import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/appointment.dart';


class AppointmentsScreen extends StatelessWidget {
  final List<Appointment> appointments;

  const AppointmentsScreen({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove back arrow
        title: const Text('Appointments',style: TextStyle(
          fontSize: 18, // Adjust font size
          fontWeight: FontWeight.bold, // Make text bold
          fontFamily: 'Schyler', // Optional: Set a custom font family if you have one
        )),
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
        automaticallyImplyLeading: false,
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
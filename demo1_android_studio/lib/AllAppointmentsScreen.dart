import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:demo1_android_studio/main.dart';
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
      body: appointments.isEmpty
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

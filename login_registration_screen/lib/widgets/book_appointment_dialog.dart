
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/doctor.dart';

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
            style: TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 20),
          _buildDoctorDropdown(),
          const SizedBox(height: 20),
          _buildDateTimePicker(),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              // padding: const EdgeInsets.symmetric(vertical: 10),
            ),
            onPressed: selectedDoctor  != null
                ? () {
              widget.onBookAppointment(selectedDoctor!, selectedDate);
              Navigator.of(context).pop();
            }
                : null,
            child: const Text('Book Appointment', style: TextStyle(color: Colors.white),),
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
      hint: const Text('Select Doctor',style: TextStyle(fontSize: 13.0)),
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

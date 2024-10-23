import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'AllAppointmentsScreen.dart';


void main() {
  runApp(const MedicalApp());
}

class MedicalApp extends StatelessWidget {
  const MedicalApp({super.key});

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Medical App',
      theme: ThemeData(
        primaryColor: const Color(0xFF1A237E),
        scaffoldBackgroundColor: Colors.grey[100],
      ),
        debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}

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





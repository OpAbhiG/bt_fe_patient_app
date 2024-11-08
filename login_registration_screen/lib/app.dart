import 'package:flutter/material.dart';
import 'screens/language_clinic_selection_screen.dart';

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

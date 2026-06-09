import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const TenantApp());
}

class TenantApp extends StatelessWidget {
  const TenantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tenant Portal',
      debugShowCheckedModeBanner: false, // Removes the ugly "DEBUG" banner
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade900),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
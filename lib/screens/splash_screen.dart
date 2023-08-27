import 'package:auth_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
// import 'screens/login_screen.dart';
// import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Simulating a delay for the splash screen
    Future.delayed(const Duration(seconds: 12), () {
      // After the delay, navigate to the Home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // You can change this color
      body: Center(
        child: Lottie.asset(
          'images/a.json', // Use the correct asset path
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

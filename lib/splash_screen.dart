import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to main screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo
            Image.network(
              'https://img2.pngdownload.id/20181115/euw/kisspng-logo-hydroponics-brand-product-portable-network-gr-katalog-hidroponik-jual-alat-hidroponik-812-313-1713922451697.webp',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 24),
            // App name
            const Text(
              'Smart HydroNest',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 16),
            // Loading indicator
            const CircularProgressIndicator(color: Color(0xFF2E7D32)),
          ],
        ),
      ),
    );
  }
}

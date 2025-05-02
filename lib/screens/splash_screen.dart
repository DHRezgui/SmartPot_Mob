import 'package:flutter/material.dart';
import 'package:smartpot/screens/walkthrough/walkthrough1.dart'; // 👈 Import correct

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key}); // utilisation du super.key

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate loading delay
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        // très important pour éviter erreur async
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Walkthrough1()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plantify Splash Screen',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF05965E),
        body: SafeArea(
          child: Stack(
            children: [
              // Fake Status Bar
              Positioned(
                top: 8,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '9:41',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.signal_cellular_4_bar,
                          color: Colors.white,
                          size: 14,
                        ),
                        SizedBox(width: 6),
                        Icon(Icons.wifi, color: Colors.white, size: 14),
                        SizedBox(width: 6),
                        Icon(Icons.battery_full, color: Colors.white, size: 14),
                      ],
                    ),
                  ],
                ),
              ),
              // Centered logo and text
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/logoApp2.png',
                      width: 200,
                      height: 200,
                      fit: BoxFit.contain,
                      semanticLabel:
                          'White stylized plant icon with two leaves, simple and modern design',
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Plantify',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              // Loading spinner
              if (_isLoading)
                Positioned(
                  bottom: 48,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 5,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

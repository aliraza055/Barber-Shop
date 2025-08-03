import 'package:barber_shop/pages/sign_up.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Background gradient instead of plain green
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1B1B1B), Color(0xFF2B1B17)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                "assets/cutting.png",
                height: 200,
                width: 200,
              ),

              const SizedBox(height: 20),

              // Title text
              const Text(
                'Welcome to',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(color: Colors.black45, blurRadius: 4),
                  ],
                ),
              ),
              const Text(
                'SallonX',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(color: Colors.black45, blurRadius: 4),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // Get Started button
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SignUp()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.deepPurple, Colors.indigo], // HomePage gradient
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.withOpacity(0.35),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Text(
                    "Get a Stylish Haircut",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
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

import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onSignInAsGuest;
  final VoidCallback onSignInWithGoogle;
  final VoidCallback onRegister;

  const WelcomeScreen({
    super.key,
    required this.onSignInAsGuest,
    required this.onSignInWithGoogle,
    required this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            children: [
              const SizedBox(height: 48),
              // simple logo block
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: const Color(0xFF163E35),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: const Text('AGU', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 24),
              const Text(
                'Welcome to AGÜ Store',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              const Text(
                'Browse and buy official AGÜ merch made with ❤️ by students.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
              const Spacer(),
              // Sign in with Google (non-functional placeholder)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: onSignInWithGoogle,
                  icon: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg',
                    width: 20,
                    height: 20,
                  ),
                  label: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14.0),
                    child: Text('Sign in with Google', style: TextStyle(fontSize: 16)),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Sign in as guest (navigates into app)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onSignInAsGuest,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14.0),
                    child: Text('Sign in as guest', style: TextStyle(fontSize: 16)),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: onRegister,
                child: const Text('Register', style: TextStyle(fontSize: 15)),
              ),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}
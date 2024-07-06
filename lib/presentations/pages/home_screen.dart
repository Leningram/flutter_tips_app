import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tips_app/presentations/pages/auth_screen.dart';
import 'package:flutter_tips_app/presentations/pages/tabs.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text('Loading...'),
            );
          }
          if (snapshot.hasData) {
            return const TabsScreen();
          }
          return const AuthScreen();
        });
  }
}

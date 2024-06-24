import 'package:flutter/material.dart';

import '../../controllers/controllers.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ElevatedButton(onPressed: () {
            AuthController.instance.signOut();
          }, child: const Text("Sign Out")),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:in_setu/screens/login_view/model/LoginAuthModel.dart';
import 'package:in_setu/screens/project_list/project_list_screen.dart';


class ProfileFillupScreen extends StatelessWidget {
  final User user;

  const ProfileFillupScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fill Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Welcome ${user.firstName ?? ''}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),

            /// Example field
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Designation",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                /// After filling profile → go to Home
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProjectListScreen(user: user),
                  ),
                );
              },
              child: const Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}

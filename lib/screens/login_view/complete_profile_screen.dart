import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
         child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: AppBar(
            title: const Text("Complete Your Profile",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
        child: Column(
          children: [
            const SizedBox(height: 18),

            // Profile Icon
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.amber,
              child: const Icon(
                Icons.person_outline,
                size: 40,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 14),
            
            Column(
              children: [
                const Text(
                  "Welcome!",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 4),

                const Text(
                  "Please complete your profile to continue",
                  style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                ),

                SizedBox(height: 16),

                profileFormBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget profileFormBox() {          
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      margin: const EdgeInsets.only(top: 8, bottom: 24 ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        children: [
          // First Name
          buildTextField("First Name *", "Enter your first name"),

          // Last Name
          buildTextField("Last Name *", "Enter your last name"),

          // Mobile Number
          buildTextField(
            "Mobile Number *",
            "9876543237",
            enabled: false,
            isBlackText: true,
            hintTextColor: Colors.black,
          ),

          // City
          buildTextField("City *", "Enter your city"),

          // Email
          buildTextField("Email", "Enter your email"),

          const SizedBox(height: 20),

          // Continue Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "Continue",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // TextField Widget
  Widget buildTextField(
    String label,
    String hint, {
    bool enabled = true,
    bool isBlackText = false,
    Color? hintTextColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: label.replaceAll('*', '').trim(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              if (label.contains('*'))
              const TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          enabled: enabled,
          style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: hintTextColor ?? Colors.grey.shade400,
              fontWeight: isBlackText ? FontWeight.bold : FontWeight.normal,
            ),
            filled: true,
            fillColor: Colors.grey.shade200,
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.amber,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

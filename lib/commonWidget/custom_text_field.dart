import 'package:flutter/material.dart';
import 'package:in_setu/constants/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final bool isPassword;
  final bool isPasswordVisible;
  final VoidCallback? onTogglePasswordVisibility;
  final String validationValue;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.validationValue,
    required this.controller,
    required this.labelText,
    required this.icon,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.onTogglePasswordVisibility,
    this.keyboardType = TextInputType.text
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focus) {
        setState(() {
          _isFocused = focus;
        });
      },
      child: Column(
        children: [
          TextFormField(
            autofocus: false,
            validator: (value){
              if(value == null || value.isEmpty){
                return widget.validationValue;
              }
              return null;
            },
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            obscureText: widget.isPassword && !widget.isPasswordVisible,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(44, 16, 12, 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                  color: _isFocused ? AppColors.primary : Colors.grey,
                  width: 1.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
              labelText: widget.labelText,
              labelStyle: TextStyle(
                color: _isFocused ? AppColors.primary : Colors.grey,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              prefixIcon: Icon(
                widget.icon,
                color: _isFocused ? AppColors.primary : Colors.grey,
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                icon: Icon(
                  widget.isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: widget.onTogglePasswordVisibility,
              )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
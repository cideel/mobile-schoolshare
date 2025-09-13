// custom_widgets.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? toggleObscure;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.obscureText = false,
    this.toggleObscure,
    this.validator,
    this.controller
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Container(
      margin: EdgeInsets.only(bottom: mq.size.height * 0.017),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: errorMessage != null ? Colors.red : Colors.grey.shade300,
                width: errorMessage != null ? 2 : 1,
              ),
            ),
            child: TextFormField(
              controller: widget.controller,
              obscureText: widget.isPassword ? widget.obscureText : false,
              validator: (value) {
                final error = widget.validator?.call(value);
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {
                      errorMessage = error;
                    });
                  }
                });
                return null; // Return null to prevent default error display
              },
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(fontSize: 13.sp),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: mq.size.width * 0.03,
                  vertical: mq.size.height * 0.018,
                ),
                border: InputBorder.none,
                errorStyle: const TextStyle(height: 0), // Hide default error text
                suffixIcon: widget.isPassword
                    ? IconButton(
                        icon: Icon(
                          widget.obscureText ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: widget.toggleObscure,
                      )
                    : null,
              ),
            ),
          ),
          if (errorMessage != null)
            Padding(
              padding: EdgeInsets.only(
                top: 6.h,
                left: 4.w,
              ),
              child: Text(
                errorMessage!,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}



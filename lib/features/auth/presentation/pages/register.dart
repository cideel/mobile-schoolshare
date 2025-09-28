import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import 'package:schoolshare/features/auth/presentation/pages/add_institution.dart';
import 'package:schoolshare/features/auth/controllers/auth_controller.dart';
import 'package:schoolshare/features/auth/presentation/widgets/custom_dropdown.dart'
    as dropdown;
import 'package:schoolshare/features/auth/presentation/widgets/custom_search_institution.dart';
import 'package:schoolshare/features/auth/presentation/widgets/custom_text_field.dart'
    as custom;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _positionController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agree = false;
  String? _selectedCategory;

  // Perbarui state untuk menyimpan ID institusi yang dibutuhkan API
  int? _selectedInstitutionId; // ID yang akan dikirim ke API
  String _selectedInstitutionName = ''; // Nama yang akan ditampilkan di UI

  // Lazy getter for AuthController
  AuthController get authController => Get.find<AuthController>();

  final List<String> _categories = [
    'SD/MI',
    'SMP',
    'SMA/SMK/MA',
    'Perguruan Tinggi'
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _positionController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedCategory == null) {
      _showErrorSnackBar(context, 'Silakan pilih kategori');
      return;
    }

    // Ganti _selectedInstitution.isEmpty menjadi _selectedInstitutionId == null
    if (_selectedInstitutionId == null) {
      _showErrorSnackBar(context, 'Silakan pilih institusi');
      return;
    }

    if (_positionController.text.trim().isEmpty) {
      _showErrorSnackBar(context, 'Posisi/Role harus diisi');
      return;
    }

    if (!_agree) {
      _showErrorSnackBar(context, 'Anda harus menyetujui syarat dan ketentuan');
      return;
    }

    authController.register(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
      category: _selectedCategory!,
      institutionId: _selectedInstitutionId!,
      position: _positionController.text.trim(),
      agreeToTerms: _agree,
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.error,
              color: Colors.white,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red[600],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        margin: EdgeInsets.all(16.w),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _showSuccessSnackBar(BuildContext context, String userName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'Selamat datang, $userName!',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green[600],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        margin: EdgeInsets.all(16.w),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final horizontalPadding = mq.size.width * 0.06;

    try {
      return Obx(() {
        final authState = authController.authState;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (authState.hasError && authState.errorMessage != null) {
            _showErrorSnackBar(context, authState.errorMessage!);
            authController.clearError();
          }
          if (authState.isAuthenticated && authState.user != null) {
            _showSuccessSnackBar(context, authState.user!.name!);
            Get.offAllNamed('/home');
          }
        });

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: mq.size.height * 0.02),
                  Center(
                    child: Text(
                      "Daftar Akun",
                      style: TextStyle(
                          fontSize: 25.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: mq.size.height * 0.03),

                  // Nama Lengkap field
                  custom.CustomTextField(
                    hintText: 'Nama Lengkap',
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama lengkap harus diisi';
                      }
                      if (value.length < 2) {
                        return 'Nama minimal 2 karakter';
                      }
                      return null;
                    },
                  ),

                  // Email field
                  custom.CustomTextField(
                    hintText: 'Email',
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email harus diisi';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Format email tidak valid';
                      }
                      return null;
                    },
                  ),

                  // Category dropdown
                  dropdown.CustomDropdown(
                    hint: 'Pilih Kategori',
                    items: _categories,
                    value: _selectedCategory,
                    onChanged: (val) => setState(() => _selectedCategory = val),
                  ),

                  // Institution search (Diperbarui dengan callback)
                  CustomInstitutionSearchField(
                    onInstitutionSelected: (id, name) {
                      setState(() {
                        _selectedInstitutionId = id;
                        _selectedInstitutionName = name;
                      });
                    },
                    selectedName: _selectedInstitutionName,
                  ),

                  // Posisi / Role field
                  custom.CustomTextField(
                    hintText: 'Posisi/Role Anda',
                    controller: _positionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Posisi/Role harus diisi';
                      }
                      return null;
                    },
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: mq.size.height * 0.01),
                      child: RichText(
                        text: TextSpan(
                          text: 'Tidak menemukan institusi? ',
                          style: AppTextStyle.caption.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                          children: [
                            TextSpan(
                              text: 'Daftarkan di sini',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                                color: Colors.blue,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  debugPrint(
                                      'Navigate to register institution');
                                  Get.to(() => const RegisterInstitution());
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: mq.size.height * 0.01),

                  // Password field
                  custom.CustomTextField(
                    hintText: 'Kata Sandi',
                    controller: _passwordController,
                    isPassword: true,
                    obscureText: _obscurePassword,
                    toggleObscure: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password harus diisi';
                      }
                      if (value.length < 6) {
                        return 'Password minimal 6 karakter';
                      }
                      return null;
                    },
                  ),

                  // Confirm Password field
                  custom.CustomTextField(
                    hintText: 'Konfirmasi Kata Sandi',
                    controller: _confirmPasswordController,
                    isPassword: true,
                    obscureText: _obscureConfirmPassword,
                    toggleObscure: () => setState(() =>
                        _obscureConfirmPassword = !_obscureConfirmPassword),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Konfirmasi password harus diisi';
                      }
                      if (value != _passwordController.text) {
                        return 'Konfirmasi password tidak cocok';
                      }
                      return null;
                    },
                  ),

                  // Terms and conditions checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: _agree,
                        onChanged: (val) =>
                            setState(() => _agree = val ?? false),
                      ),
                      Expanded(
                        child: Text(
                          'Saya akan menyetujui syarat dan ketentuan',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: mq.size.height * 0.02),

                  // Register button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.componentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(mq.size.width * 0.02),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: mq.size.height * 0.018),
                      ),
                      onPressed: authState.isLoading ? null : _handleRegister,
                      child: authState.isLoading
                          ? SizedBox(
                              height: 20.h,
                              width: 20.w,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              'DAFTAR',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: mq.size.height * 0.04),
                ],
              ),
            ),
          ),
        );
      });
    } catch (e) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}

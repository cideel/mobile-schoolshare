import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Ganti path ini sesuai dengan struktur project Anda
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

import '../widgets/custom_text_field.dart' as custom;
import '../../controllers/auth_controller.dart';
import 'register.dart';

class LoginPage extends StatelessWidget {
  // 1. State lokal untuk form (Non-Reactive)
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // 2. State lokal UI yang perlu reaktif (Reactive variables menggunakan GetX)
  final RxBool _obscurePassword = true.obs;
  // Flag untuk mencegah navigasi berulang jika state sukses terlalu cepat
  final RxBool _hasNavigated = false.obs;

  LoginPage({super.key});

  // Getter untuk akses cepat ke AuthController
  AuthController get authController => Get.find<AuthController>();

  void _handleLogin() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Reset navigation flag sebelum mencoba login baru
    _hasNavigated.value = false;

    authController.login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  void _showErrorSnackBar(
      BuildContext context, String message, AuthController controller) {
    // Memastikan error hanya ditampilkan sekali per event error
    if (controller.authState.hasError && controller.errorMessage == message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.white, size: 20.sp),
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          margin: EdgeInsets.all(16.w),
          duration: const Duration(seconds: 4),
        ),
      );
      // PENTING: Bersihkan error agar tidak muncul lagi saat build ulang
      controller.clearError();
    }
  }

  void _showSuccessAndNavigate(
      BuildContext context, String userName, AuthController controller) {
    // Memastikan sukses dan navigasi hanya dilakukan sekali
    if (controller.authState.isAuthenticated &&
        controller.user != null &&
        !_hasNavigated.value) {
      _hasNavigated.value = true;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white, size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                'Selamat datang, $userName!',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          backgroundColor: Colors.green[600],
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          margin: EdgeInsets.all(16.w),
          duration: const Duration(seconds: 2),
        ),
      );

      // Navigasi ke halaman utama setelah sukses
      Get.offAllNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final horizontalPadding = mq.size.width * 0.06;

    // GetBuilder digunakan untuk mengakses AuthController
    return GetBuilder<AuthController>(
      // Kita tidak menggunakan init di sini karena controller sudah di-lazyPut di AuthBinding
      builder: (controller) {
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
              // Obx digunakan untuk mendengarkan perubahan state AuthController secara reaktif
              child: Obx(() {
                final authState = controller.authState;

                // --- Reaktifitas & Side Effects (SnackBar/Navigation) ---
                // Panggil side effects setelah frame dibangun untuk menghindari error build
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (authState.hasError && authState.errorMessage != null) {
                    _showErrorSnackBar(
                        context, authState.errorMessage!, controller);
                  }
                  if (authState.isAuthenticated && authState.user != null) {
                    final userName = authState.user!.name;
                    _showSuccessAndNavigate(context, userName, controller);
                  }
                });
                // -----------------------------------------------------

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: mq.size.height * 0.12),

                    Center(
                      child: Text(
                        "SchoolShare",
                        style: AppTextStyle.titleLarge.copyWith(
                          fontFamily: 'Shipori',
                          fontSize: 40.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: mq.size.height * 0.01),
                    Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        "Menghubungkan pengetahuan tanpa batas",
                        style: AppTextStyle.subtitle.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    SizedBox(height: mq.size.height * 0.03),

                    // Email field
                    custom.CustomTextField(
                      controller: _emailController,
                      hintText: "Email",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email tidak boleh kosong';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'Format email tidak valid';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: mq.size.height * 0.015),

                    // Password field (menggunakan Obx lokal untuk obscureText)
                    custom.CustomTextField(
                      controller: _passwordController,
                      hintText: "Password",
                      isPassword: true,
                      // Mendengarkan state reaktif lokal
                      obscureText: _obscurePassword.value,
                      toggleObscure: () {
                        // Mengubah state reaktif lokal
                        _obscurePassword.value = !_obscurePassword.value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password tidak boleh kosong';
                        }
                        if (value.length < 6) {
                          return 'Password minimal 6 karakter';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: mq.size.height * 0.015),

                    // Forgot password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: authState.isLoading
                            ? null
                            : () {
                                // TODO: Implement forgot password
                              },
                        child: Text(
                          "Lupa Password?",
                          style: AppTextStyle.bodyText.copyWith(
                            color: AppColor.componentColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: mq.size.height * 0.01),

                    // Login button (Reactive terhadap authState.isLoading)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.componentColor,
                          disabledBackgroundColor:
                              AppColor.componentColor.withOpacity(0.6),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(mq.size.width * 0.02),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: mq.size.height * 0.018),
                        ),
                        // Tombol dinonaktifkan saat loading
                        onPressed: authState.isLoading ? null : _handleLogin,
                        child: authState.isLoading
                            ? SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                "MASUK",
                                style: AppTextStyle.bodyText.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),

                    SizedBox(height: mq.size.height * 0.03),

                    // Register text
                    Center(
                      child: GestureDetector(
                        onTap: authState.isLoading
                            ? null
                            : () {
                                Get.to(() => const Register());
                              },
                        child: RichText(
                          text: TextSpan(
                            text: "Belum punya akun? ",
                            style: AppTextStyle.bodyText
                                .copyWith(color: Colors.grey[600]),
                            children: [
                              TextSpan(
                                text: "Daftar",
                                style: AppTextStyle.bodyText.copyWith(
                                  color: AppColor.componentColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: mq.size.height * 0.04),
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }
}

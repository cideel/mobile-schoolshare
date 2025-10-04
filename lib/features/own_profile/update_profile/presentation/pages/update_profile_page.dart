// lib/features/own_profile/update_profile/presentation/pages/update_profile_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:schoolshare/features/own_profile/update_profile/presentation/controllers/update_profile_controller.dart';
import 'package:schoolshare/features/own_profile/update_profile/presentation/widgets/profile_photo_widget.dart';
import 'package:schoolshare/features/own_profile/update_profile/presentation/widgets/profile_form_widget.dart';
import 'package:schoolshare/features/own_profile/update_profile/presentation/widgets/save_button_widget.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  late UpdateProfileController controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() {
    try {
      // Coba ambil controller yang sudah ada dari binding
      controller = Get.find<UpdateProfileController>();
    } catch (e) {
      // Jika tidak ada, buat yang baru
      controller = Get.put(UpdateProfileController());
    }
    
    // Load data setelah frame selesai
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_isInitialized) {
        _isInitialized = true;
        controller.loadProfileData();
      }
    });
  }

  @override
  void dispose() {
    // Jangan dispose controller di sini karena mungkin digunakan di tempat lain
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final horizontalPadding = mq.size.width * 0.05;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
            size: 20.sp,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Ubah Profil',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<UpdateProfileController>(
        init: controller,
        builder: (ctrl) {
          if (ctrl.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 24.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Photo Section
                ProfilePhotoWidget(controller: ctrl),
                
                SizedBox(height: 40.h),
                
                // Form Section
                ProfileFormWidget(controller: ctrl),
                
                SizedBox(height: 48.h),
                
                // Save Button
                SaveButtonWidget(controller: ctrl),
                
                SizedBox(height: 32.h),
              ],
            ),
          );
        },
      ),
    );
  }
}

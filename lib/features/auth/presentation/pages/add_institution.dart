import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/features/auth/presentation/widgets/custom_dropdown.dart' as custom;
import 'package:schoolshare/features/auth/presentation/widgets/custom_text_field.dart' as custom;

class RegisterInstitution extends StatefulWidget {
  const RegisterInstitution({super.key});

  @override
  State<RegisterInstitution> createState() => _RegisterInstitutionState();
}

class _RegisterInstitutionState extends State<RegisterInstitution> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  
  String? _selectedCategory;
  bool _isLoading = false;
  final List<String> _categories = ['SD/MI', 'SMP', 'SMA/SMK/MA', 'Perguruan Tinggi'];

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final horizontalPadding = mq.size.width * 0.06;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Daftarkan Institusi',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: mq.size.height * 0.03),

              // Kategori dropdown
              custom.CustomDropdown(
                hint: 'Pilih Kategori',
                items: _categories,
                value: _selectedCategory,
                onChanged: (val) => setState(() => _selectedCategory = val),
              ),

              // Nama institusi field
              custom.CustomTextField(
                hintText: 'Nama Institusi',
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama institusi harus diisi';
                  }
                  if (value.length < 3) {
                    return 'Nama institusi minimal 3 karakter';
                  }
                  return null;
                },
              ),

              // Alamat institusi field
              custom.CustomTextField(
                hintText: 'Alamat Institusi',
                controller: _addressController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat institusi harus diisi';
                  }
                  if (value.length < 10) {
                    return 'Alamat institusi minimal 10 karakter';
                  }
                  return null;
                },
              ),

              SizedBox(height: mq.size.height * 0.03),

              // Submit button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.componentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                  onPressed: _isLoading ? null : _handleSaveInstitution,
                  child: _isLoading
                      ? SizedBox(
                          height: 20.h,
                          width: 20.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          'SIMPAN',
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
  }

  void _handleSaveInstitution() async {
    print('=== VALIDATION DEBUG ===');
    print('Form valid: ${_formKey.currentState?.validate()}');
    print('Category: $_selectedCategory');
    print('Name: "${_nameController.text.trim()}"');
    print('Address: "${_addressController.text.trim()}"');
    print('========================');

    // Validate form fields
    if (!_formKey.currentState!.validate()) {
      print('Form validation failed');
      _showErrorSnackBar(context, 'Harap lengkapi semua field yang diperlukan');
      return;
    }

    // Validate category selection
    if (_selectedCategory == null || _selectedCategory!.isEmpty) {
      print('Category validation failed');
      _showErrorSnackBar(context, 'Silakan pilih kategori institusi');
      return;
    }

    // Additional validation for empty fields
    if (_nameController.text.trim().isEmpty) {
      print('Name validation failed - empty');
      _showErrorSnackBar(context, 'Nama institusi harus diisi');
      return;
    }

    if (_addressController.text.trim().isEmpty) {
      print('Address validation failed - empty');
      _showErrorSnackBar(context, 'Alamat institusi harus diisi');
      return;
    }

    // Validate minimum length
    if (_nameController.text.trim().length < 3) {
      print('Name validation failed - too short');
      _showErrorSnackBar(context, 'Nama institusi minimal 3 karakter');
      return;
    }

    if (_addressController.text.trim().length < 10) {
      print('Address validation failed - too short');
      _showErrorSnackBar(context, 'Alamat institusi minimal 10 karakter');
      return;
    }

    print('All validations passed - proceeding with save');

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Show success message
      _showSuccessSnackBar(context, 'Institusi berhasil didaftarkan dan tersedia untuk digunakan');
      
      // Go back to previous screen after a short delay
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pop(context);
        }
      });
      
    } catch (e) {
      _showErrorSnackBar(context, 'Gagal mendaftarkan institusi. Silakan coba lagi.');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
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

  void _showSuccessSnackBar(BuildContext context, String message) {
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
        backgroundColor: Colors.green[600],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        margin: EdgeInsets.all(16.w),
        duration: const Duration(seconds: 4),
      ),
    );
  }
}

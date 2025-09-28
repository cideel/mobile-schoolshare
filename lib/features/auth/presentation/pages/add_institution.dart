import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/services/auth/login_services.dart';
import 'package:schoolshare/features/auth/presentation/widgets/custom_dropdown.dart'
    as custom_dropdown;
import 'package:schoolshare/features/auth/presentation/widgets/custom_text_field.dart'
    as custom_text_field;

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
  final List<String> _categories = [
    'SD/MI',
    'SMP/MTsN',
    'SMA/SMK/MA',
    'Perguruan Tinggi'
  ];
  final AuthService _authService = AuthService(); // Inisialisasi AuthService

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _handleSaveInstitution() async {
    // Validasi input
    if (!_formKey.currentState!.validate()) {
      _showSuccessSnackBar(
          context, 'Harap lengkapi semua field yang diperlukan');
      return;
    }

    if (_selectedCategory == null || _selectedCategory!.isEmpty) {
      _showSuccessSnackBar(context, 'Silakan pilih kategori institusi');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _authService.addInstitution(
        name: _nameController.text.trim(),
        location: _addressController.text.trim(),
        kategori: _selectedCategory!,
      );

      // Pastikan respons dari API valid sebelum menampilkan pesan sukses
      if (response['success'] == true) {
        _showSuccessSnackBar(context,
            'Institusi berhasil didaftarkan dan tersedia untuk digunakan');

        // Bersihkan form
        _nameController.clear();
        _addressController.clear();
        setState(() {
          _selectedCategory = null;
        });

        // Kembali ke halaman sebelumnya
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            Navigator.pop(context);
          }
        });
      } else {
        throw Exception(response['message'] ?? 'Gagal mendaftarkan institusi.');
      }
    } catch (e) {
      _showSuccessSnackBar(context, e.toString().replaceAll('Exception: ', ''));
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
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
            Icon(Icons.check_circle, color: Colors.white, size: 20.sp),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        margin: EdgeInsets.all(16.w),
        duration: const Duration(seconds: 4),
      ),
    );
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
          style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black),
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
              custom_dropdown.CustomDropdown(
                hint: 'Pilih Kategori',
                items: _categories,
                value: _selectedCategory,
                onChanged: (val) => setState(() => _selectedCategory = val),
              ),
              custom_text_field.CustomTextField(
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
              custom_text_field.CustomTextField(
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
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
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
}

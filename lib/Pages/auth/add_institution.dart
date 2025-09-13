import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/Config/color.dart';
import 'package:schoolshare/Pages/auth/widgets/custom_dropdown.dart' as custom;
import 'package:schoolshare/Pages/auth/widgets/custom_text_field.dart'
    as dropdown;
import 'package:schoolshare/Services/institution_service.dart'; // Import service baru

class RegisterInstitution extends StatefulWidget {
  const RegisterInstitution({super.key});

  @override
  State<RegisterInstitution> createState() => _RegisterInstitutionState();
}

class _RegisterInstitutionState extends State<RegisterInstitution> {
  String? _selectedCategory;
  final List<String> _categories = [
    'SD/MI',
    'SMP',
    'SMA/SMK/MA',
    'Perguruan Tinggi'
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _saveInstitution() async {
    final name = _nameController.text.trim();
    final location = _locationController.text.trim();

    if (_selectedCategory == null || name.isEmpty || location.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua field wajib diisi.')),
      );
      return;
    }

    try {
      final response = await InstitutionService().addInstitution(
        name: name,
        location: location,
        kategori: _selectedCategory!,
      );

      if (response['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Institusi berhasil ditambahkan!')),
        );
        // Kembali ke halaman sebelumnya setelah berhasil
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(response['message'] ?? 'Gagal menambahkan institusi.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan saat menyimpan: $e')),
      );
    }
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: mq.size.height * 0.03),
            custom.CustomDropdown(
              hint: 'Pilih Kategori',
              items: _categories,
              value: _selectedCategory,
              onChanged: (val) => setState(() => _selectedCategory = val),
            ),
            dropdown.CustomTextField(
              controller: _nameController,
              hintText: 'Nama Institusi',
            ),
            dropdown.CustomTextField(
              controller: _locationController,
              hintText: 'Alamat Institusi',
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
                onPressed:
                    _saveInstitution, // Panggil fungsi saat tombol ditekan
                child: Text(
                  'SIMPAN',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: mq.size.height * 0.04),
          ],
        ),
      ),
    );
  }
}

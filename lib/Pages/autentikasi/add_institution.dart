import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/Config/color.dart';
import 'package:schoolshare/Pages/autentikasi/widgets/custom_dropdown.dart' as custom;
import 'package:schoolshare/Pages/autentikasi/widgets/custom_text_field.dart' as dropdown;

class RegisterInstitution extends StatefulWidget {
  const RegisterInstitution({super.key});

  @override
  State<RegisterInstitution> createState() => _RegisterInstitutionState();
}

class _RegisterInstitutionState extends State<RegisterInstitution> {
  String? _selectedCategory;
  final List<String> _categories = ['SD/MI', 'SMP', 'SMA/SMK/MA', 'Perguruan Tinggi'];

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

            const dropdown.CustomTextField(hintText: 'Nama Institusi'),

            const dropdown.CustomTextField(hintText: 'Alamat Institusi'),

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
                onPressed: () {
                  // Aksi simpan
                  print("Institusi disubmit");
                },
                child: Text(
                  'KIRIM PERMOHONAN',
                  style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold),
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

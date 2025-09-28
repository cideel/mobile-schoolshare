// lib/own_profile/profile_tab/presentation/pages/profile_tab.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// 🔥 Impor Controller, Model, dan API yang benar
import 'package:schoolshare/features/own_profile/controllers/profile_tab_profile_controller.dart';
import 'package:schoolshare/data/models/institution_model.dart';
import 'package:schoolshare/core/services/api_urls.dart';

class ProfileTab extends StatelessWidget {
  final ProfileTabProfileController controller =
      Get.find<ProfileTabProfileController>();

  ProfileTab({super.key});

  @override
  Widget build(BuildContext trimContext) {
    final mq = MediaQuery.of(trimContext);
    final horizontalPadding = mq.size.width * 0.05;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),

        // 🔥 Menggunakan OBX untuk menangani State Loading/Error/Success
        child: controller.obx(
          (user) {
            // Sukses: Data user tersedia (user adalah UserModel)

            // Ambil data Afiliasi dari Rx variable di Controller
            final Institution? inst = controller.institution.value;
            final String posName = controller.userPositionName.value;

            // Buat list widget secara kondisional
            final List<Widget> affiliationWidgets = [];

            if (inst != null) {
              affiliationWidgets.addAll([
                Text(
                  "Afiliasi",
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildAffiliationRow(inst, posName),
                const SizedBox(height: 16),
                const Divider(color: Colors.grey, thickness: 0.5),
              ]);
            }

            return ListView(
              children: [
                ...affiliationWidgets, // Kosong jika inst == null
              ],
            );
          },
          // onLoading: Tampilan ketika data sedang diambil
          onLoading: const Center(child: CircularProgressIndicator()),
          // onError: Tampilan ketika terjadi error
          onError: (error) =>
              Center(child: Text('Gagal memuat data profil: $error')),
        ),
      ),
    );
  }

  // 🔥 Widget untuk menampilkan baris Institusi dan Posisi secara Dinamis
  Widget _buildAffiliationRow(Institution inst, String positionName) {
    final String? logoPath = inst.profileInstitusi;
    final bool useNetworkImage = logoPath != null && logoPath.isNotEmpty;

    // Tentukan URL/path yang akan digunakan
    final String imageUrl = useNetworkImage
        ? ApiUrls.storageUrl +
            (logoPath!.startsWith('/') ? logoPath : '/$logoPath')
        : 'assets/images/example-logo-univ.png'; // Fallback lokal

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: SizedBox(
            height: 50,
            width: 50,
            child: useNetworkImage
                ? Image.network(
                    imageUrl, // URL LENGKAP: storageUrl + path
                    fit: BoxFit.cover,
                    // Fallback jika Image.network gagal koneksi/404
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                        'assets/images/example-logo-univ.png',
                        fit: BoxFit.cover),
                  )
                : Image.asset(
                    // Langsung gunakan Image.asset jika profileInstitusi kosong/null
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(inst.name), // Dinamis: Nama Institusi
              _buildSubTitle("Lokasi"),
              _buildSubValue(inst.location), // Dinamis: Lokasi
              _buildSubTitle("Departemen"),
              _buildSubValue(inst.departemen ?? 'N/A'), // Dinamis: Departemen
              _buildSubTitle("Posisi"),
              _buildSubValue(
                  positionName), // Dinamis: Nama Posisi dari Controller
            ],
          ),
        ),
      ],
    );
  }

  // --- Widget helper tetap sama ---

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSubTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        text,
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _buildSubValue(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
    );
  }
}

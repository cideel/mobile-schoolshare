// import 'dart:io';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import '../../../../../data/models/publication.dart';
// import '../../../../../data/models/base_search_models.dart' show UserSearchModel;
// import '../../data/repositories/content_submission_repository_impl.dart';
// import '../../data/services/content_submission_service_clean.dart';

// class ContentSubmissionController extends GetxController {
//   final ContentSubmissionRepositoryImpl _repository;

//   ContentSubmissionController({
//     ContentSubmissionRepositoryImpl? repository,
//   }) : _repository = repository ?? ContentSubmissionRepositoryImpl();

//   // Observable states
//   final RxBool isLoading = false.obs;
//   final RxBool isSubmitting = false.obs;
//   final RxString errorMessage = ''.obs;
//   final RxList<Publication> userContents = <Publication>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     print('🎯 ContentSubmissionController initialized');
//     // Load user contents on init
//     loadUserContents();
//   }

//   // Submit new content
//   Future<bool> submitContent({
//     required String title,
//     required String description,
//     required String contentType,
//     required List<UserSearchModel> authors,
//     required List<File> files,
//     List<String>? tags,
//     String? category,
//   }) async {
//     try {
//       isSubmitting.value = true;
//       errorMessage.value = '';

//       print('🚀 Controller: Starting content submission');
//       print('📝 Title: $title');
//       print('📝 Description: ${description.substring(0, description.length > 50 ? 50 : description.length)}...');
//       print('📝 Content Type: $contentType');
//       print('📁 Files: ${files.length}');
//       print('👥 Authors: ${authors.length}');

//       // Validate inputs
//       if (title.trim().isEmpty) {
//         throw Exception('Judul tidak boleh kosong');
//       }
      
//       if (description.trim().isEmpty) {
//         throw Exception('Deskripsi tidak boleh kosong');
//       }
      
//       if (contentType.isEmpty) {
//         throw Exception('Tipe konten harus dipilih');
//       }

//       // Convert UserSearchModel to user IDs (server expects valid user IDs for authors)
//       final authorIds = authors.map((author) => author.id).toList();
//       print('👥 Author IDs to submit: $authorIds');

//       final newPublication = await _repository.submitContent(
//         title: title.trim(),
//         description: description.trim(),
//         contentType: contentType,
//         authors: authorIds,
//         files: files,
//         tags: tags,
//         category: category,
//       );

//       if (newPublication != null) {
//         print('✅ Content submitted successfully: ${newPublication.id}');
//         print('📄 Publication title: ${newPublication.title}');
        
//         // Add to local list at the beginning
//         userContents.insert(0, newPublication);
        
//         // Show success message with appropriate context
//         if (newPublication.id.toString().length > 10) {
//           // Likely a mock publication (timestamp ID)
//           _showSnackBar(
//             'Berhasil (Mock)!',
//             'Konten "${newPublication.title}" dibuat sebagai contoh. Login ulang untuk sinkronisasi dengan server.',
//             backgroundColor: Colors.orange,
//             icon: Icons.warning,
//           );
//         } else {
//           // Real publication from server
//           _showSnackBar(
//             'Berhasil!',
//             'Konten "${newPublication.title}" berhasil dikirim ke server',
//             backgroundColor: Colors.green,
//             icon: Icons.check_circle,
//           );
//         }

//         return true;
//       } else {
//         print('❌ Content submission returned null');
//         errorMessage.value = 'Gagal mengirim konten - response null';
        
//         // Show error message
//         _showSnackBar(
//           'Gagal!',
//           'Gagal mengirim konten. Silakan periksa koneksi dan coba lagi.',
//           backgroundColor: Colors.red,
//           icon: Icons.error,
//         );
        
//         return false;
//       }
//     } catch (e) {
//       print('❌ Controller error: $e');
//       errorMessage.value = 'Terjadi kesalahan: ${e.toString()}';
      
//       // Determine error type and show appropriate message
//       String userMessage;
//       if (e.toString().contains('auth') || e.toString().contains('token')) {
//         userMessage = 'Sesi berakhir, silakan login ulang';
//       } else if (e.toString().contains('network') || e.toString().contains('connection')) {
//         userMessage = 'Masalah koneksi, periksa internet Anda';
//       } else if (e.toString().contains('validation')) {
//         userMessage = 'Data tidak valid, periksa isian form';
//       } else {
//         userMessage = 'Terjadi kesalahan tidak terduga';
//       }
      
//       _showSnackBar(
//         'Error!',
//         userMessage,
//         backgroundColor: Colors.red,
//         icon: Icons.error,
//       );
      
//       return false;
//     } finally {
//       isSubmitting.value = false;
//     }
//   }

//   // Load user's submitted contents
//   Future<void> loadUserContents() async {
//     try {
//       isLoading.value = true;
//       errorMessage.value = '';

//       print('📥 Loading user contents...');

//       final contents = await _repository.getUserContents();
//       userContents.value = contents;

//       print('✅ Loaded ${contents.length} user contents');
//     } catch (e) {
//       print('❌ Error loading user contents: $e');
//       errorMessage.value = 'Gagal memuat konten: ${e.toString()}';
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Delete content
//   Future<bool> deleteContent(String contentId) async {
//     try {
//       final success = await _repository.deleteContent(contentId);
      
//       if (success) {
//         // Remove from local list
//         userContents.removeWhere((content) => content.id.toString() == contentId);
        
//         _showSnackBar(
//           'Berhasil!',
//           'Konten berhasil dihapus',
//           backgroundColor: Colors.green,
//           icon: Icons.check_circle,
//         );
        
//         return true;
//       } else {
//         _showSnackBar(
//           'Gagal!',
//           'Gagal menghapus konten',
//           backgroundColor: Colors.red,
//           icon: Icons.error,
//         );
        
//         return false;
//       }
//     } catch (e) {
//       print('❌ Error deleting content: $e');
//       _showSnackBar(
//         'Error!',
//         'Terjadi kesalahan: ${e.toString()}',
//         backgroundColor: Colors.red,
//         icon: Icons.error,
//       );
      
//       return false;
//     }
//   }

//   // Helper untuk menampilkan Snackbar
//   void _showSnackBar(
//     String title,
//     String message, {
//     required Color backgroundColor,
//     required IconData icon,
//   }) {
//     Get.snackbar(
//       title,
//       message,
//       backgroundColor: backgroundColor,
//       colorText: Colors.white,
//       icon: Icon(icon, color: Colors.white),
//       snackPosition: SnackPosition.BOTTOM,
//       margin: const EdgeInsets.all(16),
//       borderRadius: 8,
//       duration: const Duration(seconds: 3),
//     );
//   }

//   // ========== TEST METHODS ==========

//   // Test method for laporan penelitian
//   Future<bool> testLaporanPenelitian({
//     String? title,
//     String? description,
//     String? department,
//     String? reportNumber,
//     File? testFile,
//   }) async {
//     try {
//       isSubmitting.value = true;
//       errorMessage.value = '';

//       print('🧪 Testing Laporan Penelitian submission...');

//       // Use provided values or defaults
//       final testTitle = title ?? 'Test Laporan Penelitian ${DateTime.now().millisecondsSinceEpoch}';
//       final testDescription = description ?? 'Test description for laporan penelitian';
//       final testDepartment = department ?? 'Computer Science';
//       final testReportNumber = reportNumber ?? '001';

//       // Import the service directly for testing
//       final service = _getContentSubmissionService();
      
//       final result = await service.submitLaporanPenelitianTest(
//         name: testTitle,
//         description: testDescription,
//         authors: ['2'], // Default test user ID
//         files: testFile != null ? [testFile] : [],
//         department: testDepartment,
//         reportNumber: testReportNumber,
//       );

//       if (result != null) {
//         _showSnackBar(
//           'Test Success',
//           '✅ Test Laporan Penelitian berhasil!',
//           backgroundColor: Colors.green,
//           icon: Icons.check_circle,
//         );
//         await loadUserContents(); // Refresh list
//         return true;
//       } else {
//         _showSnackBar(
//           'Test Failed',
//           '❌ Test Laporan Penelitian gagal',
//           backgroundColor: Colors.red,
//           icon: Icons.error,
//         );
//         return false;
//       }
//     } catch (e) {
//       print('❌ Test error: $e');
//       _showSnackBar(
//         'Error',
//         'Error: $e',
//         backgroundColor: Colors.red,
//         icon: Icons.error,
//       );
//       return false;
//     } finally {
//       isSubmitting.value = false;
//     }
//   }

//   // Test method for video
//   Future<bool> testVideo({
//     String? title,
//     String? description,
//     String? videoUrl,
//   }) async {
//     try {
//       isSubmitting.value = true;
//       errorMessage.value = '';

//       print('🧪 Testing Video submission...');

//       final testTitle = title ?? 'Test Video ${DateTime.now().millisecondsSinceEpoch}';
//       final testDescription = description ?? 'Test description for video content';
//       final testVideoUrl = videoUrl ?? 'https://www.youtube.com/watch?v=dQw4w9WgXcQ';

//       final service = _getContentSubmissionService();
      
//       final result = await service.submitVideoTest(
//         name: testTitle,
//         description: testDescription,
//         authors: ['2'],
//         videoUrl: testVideoUrl,
//       );

//       if (result != null) {
//         _showSnackBar(
//           'Test Success',
//           '✅ Test Video berhasil!',
//           backgroundColor: Colors.green,
//           icon: Icons.check_circle,
//         );
//         await loadUserContents();
//         return true;
//       } else {
//         _showSnackBar(
//           'Test Failed',
//           '❌ Test Video gagal',
//           backgroundColor: Colors.red,
//           icon: Icons.error,
//         );
//         return false;
//       }
//     } catch (e) {
//       print('❌ Test error: $e');
//       _showSnackBar(
//         'Error',
//         'Error: $e',
//         backgroundColor: Colors.red,
//         icon: Icons.error,
//       );
//       return false;
//     } finally {
//       isSubmitting.value = false;
//     }
//   }

//   // Helper method to get service instance
//   ContentSubmissionService _getContentSubmissionService() {
//     return ContentSubmissionService();
//   }
// }

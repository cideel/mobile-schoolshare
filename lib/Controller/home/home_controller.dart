import 'package:get/get.dart';
import 'package:schoolshare/Models/content.dart';
import 'package:schoolshare/Services/home_services.dart';
import 'package:schoolshare/Services/realtime_services.dart';

class HomeController extends GetxController {
  // Gunakan RxList agar GetX dapat mendeteksi perubahan pada daftar.
  var publications = <Content>[].obs;
  // Gunakan RxBool untuk mengelola status loading.
  var isLoading = true.obs;
  // Gunakan RxString untuk menyimpan pesan error.
  var errorMessage = ''.obs;

  // Mendapatkan instance dari HomeServices.
  final HomeServices _homeServices = Get.find<HomeServices>();
  // Mendapatkan instance dari RealtimeService
  final RealtimeService _realtimeService = Get.find<RealtimeService>();

  @override
  void onInit() {
    super.onInit();
    // Panggil metode untuk mengambil data saat controller diinisialisasi.
    fetchPublications();

    // Mulai mendengarkan event real-time dari RealtimeService
    _realtimeService.eventStream.listen((event) {
      _handleRealtimeEvent(event);
    });
  }

  // Mengambil data publikasi dari layanan API.
  void fetchPublications() async {
    // Set status loading menjadi true sebelum memanggil API.
    isLoading(true);
    // Kosongkan pesan error sebelumnya.
    errorMessage('');
    try {
      // Panggil metode getContents() dari HomeServices.
      var contents = await _homeServices.getContents();
      // Perbarui daftar publikasi dengan data dari API.
      publications.assignAll(contents);
    } catch (e) {
      // Tangani kesalahan, misalnya koneksi terputus atau token tidak valid.
      errorMessage('Gagal memuat konten: ${e.toString()}');
    } finally {
      // Set status loading menjadi false setelah panggilan selesai, baik berhasil atau gagal.
      isLoading(false);
    }
  }

  // Menangani event real-time yang masuk dari WebSocket
  void _handleRealtimeEvent(Map<String, dynamic> event) {
    final eventType = event['event'];
    final eventData = event['data'];
    print('Event Received: $eventType');

    // Asumsi server mengirim event Laravel dengan format 'App\\Events\\...'
    if (eventType == 'App\\Events\\NewPostEvent') {
      final newContent = Content.fromJson(eventData);
      publications.insert(
          0, newContent); // Sisipkan di awal agar muncul di atas
    } else if (eventType == 'App\\Events\\DeletePostEvent') {
      // Jika event adalah penghapusan, cari dan hapus dari daftar
      final contentId = eventData['id'];
      publications.removeWhere((content) => content.id == contentId);
    } else if (eventType == 'App\\Events\\UpdatePostEvent') {
      // Jika event adalah pembaruan, cari dan ganti item
      final updatedContent = Content.fromJson(eventData);
      final index =
          publications.indexWhere((content) => content.id == updatedContent.id);
      if (index != -1) {
        publications[index] = updatedContent;
      }
    }
  }
}

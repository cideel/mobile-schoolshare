  import 'dart:async';
import '../models/bookmark.dart';

class BookmarkService {
  static final BookmarkService _instance = BookmarkService._internal();
  factory BookmarkService() => _instance;
  BookmarkService._internal();

  final List<Bookmark> _bookmarks = [];
  final StreamController<List<Bookmark>> _bookmarksController = StreamController<List<Bookmark>>.broadcast();

  Stream<List<Bookmark>> get bookmarksStream => _bookmarksController.stream;
  List<Bookmark> get bookmarks => List.unmodifiable(_bookmarks);

  Future<List<Bookmark>> loadBookmarks() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Mock data - replace with actual API call
    if (_bookmarks.isEmpty) {
      _bookmarks.addAll(_getMockBookmarks());
    }
    
    _bookmarksController.add(_bookmarks);
    return _bookmarks;
  }

  Future<void> addBookmark(Bookmark bookmark) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    if (!_bookmarks.any((b) => b.id == bookmark.id)) {
      _bookmarks.insert(0, bookmark);
      _bookmarksController.add(_bookmarks);
    }
  }

  Future<void> removeBookmark(String bookmarkId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    _bookmarks.removeWhere((bookmark) => bookmark.id == bookmarkId);
    _bookmarksController.add(_bookmarks);
  }

  Future<void> clearAllBookmarks() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    _bookmarks.clear();
    _bookmarksController.add(_bookmarks);
  }

  Future<bool> isBookmarked(String contentId) async {
    return _bookmarks.any((bookmark) => bookmark.id == contentId);
  }

  Future<void> refreshBookmarks() async {
    await Future.delayed(const Duration(seconds: 1));
    _bookmarksController.add(_bookmarks);
  }

  List<Bookmark> _getMockBookmarks() {
    return [
      Bookmark(
        id: 'bm1',
        title: 'Implementasi Machine Learning untuk Prediksi Cuaca dengan Akurasi Tinggi menggunakan Neural Network dan Deep Learning',
        authors: [
          'Dr. Ahmad Santoso, M.Kom',
          'Prof. Sari Wulandari, Ph.D',
          'Dr. Budi Hartono, S.T., M.T',
          'Andi Prasetyo, M.Sc',
          'Lisa Maharani, Ph.D'
        ],
        contentType: 'Penelitian',
        viewCount: 1245,
        downloadCount: 456,
        recommendationCount: 89,
        bookmarkedAt: DateTime.now().subtract(const Duration(days: 2)),
        institutionName: 'Universitas Indonesia',
      ),
      Bookmark(
        id: 'bm2',
        title: 'Analisis Dampak Perubahan Iklim terhadap Ekosistem Laut Indonesia',
        authors: [
          'Dr. Maria Sinta Dewi',
          'Prof. Hendra Gunawan',
          'Rina Kusumawati, M.Si'
        ],
        contentType: 'Jurnal',
        viewCount: 892,
        downloadCount: 234,
        recommendationCount: 67,
        bookmarkedAt: DateTime.now().subtract(const Duration(hours: 12)),
        institutionName: 'Institut Teknologi Bandung',
      ),
      Bookmark(
        id: 'bm3',
        title: 'Pengembangan Aplikasi Mobile untuk Monitoring Kesehatan Real-time',
        authors: [
          'Drs. Suprianto, M.T',
          'Dr. Nina Kartika'
        ],
        contentType: 'Skripsi',
        viewCount: 567,
        downloadCount: 123,
        recommendationCount: 34,
        bookmarkedAt: DateTime.now().subtract(const Duration(days: 1)),
        institutionName: 'Universitas Gadjah Mada',
      ),
      Bookmark(
        id: 'bm4',
        title: 'Studi Komparatif Algoritma Sorting dalam Optimasi Database Performance',
        authors: [
          'Ahmad Rizki Pratama',
        ],
        contentType: 'Tugas Akhir',
        viewCount: 445,
        downloadCount: 89,
        recommendationCount: 23,
        bookmarkedAt: DateTime.now().subtract(const Duration(days: 5)),
        institutionName: 'Universitas Brawijaya',
      ),
      Bookmark(
        id: 'bm5',
        title: 'Implementasi Blockchain untuk Sistem Voting Elektronik yang Aman dan Transparan',
        authors: [
          'Prof. Dr. Bambang Sutrisno',
          'Dr. Ir. Wahyudi Setiawan, M.T',
          'Eko Prasetyo, S.Kom., M.T',
          'Diana Sari, M.Kom'
        ],
        contentType: 'Paper',
        viewCount: 1876,
        downloadCount: 672,
        recommendationCount: 145,
        bookmarkedAt: DateTime.now().subtract(const Duration(hours: 6)),
        institutionName: 'Institut Teknologi Sepuluh Nopember',
      ),
    ];
  }

  void dispose() {
    _bookmarksController.close();
  }
}

// Content constants for MVC architecture

class ContentConstants {
  // Content types
  static const List<String> contentTypes = [
    'Peraturan',
    'Silabus',
    'Rencana Pembelajaran',
    'Lembar Kerja Siswa',
    'Laporan Penelitian',
    'Strategi',
    'Metode Pembelajaran',
    'Model Pembelajaran',
    'Video',
    'Presentasi',
    'Buku',
    'Artikel',
    'Poster',
  ];

  // File formats
  static const List<String> supportedFormats = [
    'PDF',
    'DOC',
    'DOCX',
    'PPT',
    'PPTX',
    'TXT',
  ];

  // Categories
  static const List<String> categories = [
    'Teknologi',
    'Pendidikan',
    'Kesehatan',
    'Ekonomi',
    'Hukum',
    'Sosial',
    'Budaya',
    'Sains',
    'Lainnya',
  ];

  // Available authors (mock data)
  static const List<Map<String, String>> availableAuthors = [
    {'name': 'Dr. John Doe', 'institution': 'Universitas Indonesia'},
    {'name': 'Prof. Jane Smith', 'institution': 'Institut Teknologi Bandung'},
    {'name': 'Ahmad Fauzan', 'institution': 'Universitas Gadjah Mada'},
    {'name': 'Maria Santos', 'institution': 'Universitas Airlangga'},
    {'name': 'Dr. Sarah Wilson', 'institution': 'Universitas Brawijaya'},
  ];

  // Content type configuration with colors and icons
  static const Map<String, Map<String, dynamic>> contentTypeConfig = {
    'Peraturan': {
      'label': 'Peraturan',
      'color': 0xFFE53E3E, // Red
      'icon': 'gavel',
    },
    'Silabus': {
      'label': 'Silabus',
      'color': 0xFF3182CE, // Blue
      'icon': 'menu_book',
    },
    'Rencana Pembelajaran': {
      'label': 'Rencana Pembelajaran',
      'color': 0xFF38A169, // Green
      'icon': 'assignment',
    },
    'Lembar Kerja Siswa': {
      'label': 'Lembar Kerja Siswa',
      'color': 0xFFD69E2E, // Yellow/Orange
      'icon': 'assignment_ind',
    },
    'Laporan Penelitian': {
      'label': 'Laporan Penelitian',
      'color': 0xFF805AD5, // Purple
      'icon': 'science',
    },
    'Strategi': {
      'label': 'Strategi',
      'color': 0xFF319795, // Teal
      'icon': 'lightbulb',
    },
    'Metode Pembelajaran': {
      'label': 'Metode Pembelajaran',
      'color': 0xFFE53E3E, // Red
      'icon': 'psychology',
    },
    'Model Pembelajaran': {
      'label': 'Model Pembelajaran',
      'color': 0xFF3182CE, // Blue
      'icon': 'model_training',
    },
    'Video': {
      'label': 'Video',
      'color': 0xFFE53E3E, // Red
      'icon': 'videocam',
    },
    'Presentasi': {
      'label': 'Presentasi',
      'color': 0xFFD69E2E, // Yellow/Orange
      'icon': 'slideshow',
    },
    'Buku': {
      'label': 'Buku',
      'color': 0xFF38A169, // Green
      'icon': 'book',
    },
    'Artikel': {
      'label': 'Artikel',
      'color': 0xFF3182CE, // Blue
      'icon': 'article',
    },
    'Poster': {
      'label': 'Poster',
      'color': 0xFF805AD5, // Purple
      'icon': 'image',
    },
  };

  // Max file size (in bytes)
  static const int maxFileSizeBytes = 50 * 1024 * 1024; // 50MB
  
  // Max file size readable
  static const String maxFileSizeReadable = '50MB';
}

// Legacy alias for backward compatibility
class ContentData {
  static List<String> get contentTypes => ContentConstants.contentTypes;
  static List<Map<String, String>> get availableAuthors => ContentConstants.availableAuthors;
  static Map<String, Map<String, dynamic>> get contentTypeConfig => ContentConstants.contentTypeConfig;
}

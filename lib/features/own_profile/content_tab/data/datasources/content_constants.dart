// Content type constants and data
class ContentData {
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

  static const List<Map<String, String>> availableAuthors = [
    {'id': '1', 'name': 'Sir Alex Ferguson', 'institution': 'Universitas Indonesia'},
    {'id': '2', 'name': 'Johan Liebert', 'institution': 'Universitas Garut'},
    {'id': '3', 'name': 'John Lennon', 'institution': 'Tokyo University'},
    {'id': '4', 'name': 'Paul McCarthy', 'institution': 'Universitas XYZ'},
    {'id': '5', 'name': 'M.Sc. Andi Wijaya', 'institution': 'Universitas ABCU'},
  ];

  static const Map<String, Map<String, dynamic>> contentTypeConfig = {
    'Peraturan': {
      'color': 0xFF795548,
      'icon': 'gavel',
      'label': 'Peraturan',
    },
    'Silabus': {
      'color': 0xFF3F51B5,
      'icon': 'list_alt',
      'label': 'Silabus',
    },
    'Rencana Pembelajaran': {
      'color': 0xFF009688,
      'icon': 'assignment',
      'label': 'Rencana Pembelajaran',
    },
    'Lembar Kerja Siswa': {
      'color': 0xFFFF9800,
      'icon': 'assignment_ind',
      'label': 'Lembar Kerja Siswa',
    },
    'Laporan Penelitian': {
      'color': 0xFFF44336,
      'icon': 'science',
      'label': 'Laporan Penelitian',
    },
    'Strategi': {
      'color': 0xFF607D8B,
      'icon': 'psychology',
      'label': 'Strategi',
    },
    'Metode Pembelajaran': {
      'color': 0xFF4CAF50,
      'icon': 'school',
      'label': 'Metode Pembelajaran',
    },
    'Model Pembelajaran': {
      'color': 0xFF9C27B0,
      'icon': 'model_training',
      'label': 'Model Pembelajaran',
    },
    'Video': {
      'color': 0xFFE91E63,
      'icon': 'play_circle_filled',
      'label': 'Video',
    },
    'Presentasi': {
      'color': 0xFFFF5722,
      'icon': 'slideshow',
      'label': 'Presentasi',
    },
    'Buku': {
      'color': 0xFF2196F3,
      'icon': 'menu_book',
      'label': 'Buku',
    },
    'Artikel': {
      'color': 0xFF8BC34A,
      'icon': 'article',
      'label': 'Artikel',
    },
    'Poster': {
      'color': 0xFFFFEB3B,
      'icon': 'image',
      'label': 'Poster',
    },
  };
}

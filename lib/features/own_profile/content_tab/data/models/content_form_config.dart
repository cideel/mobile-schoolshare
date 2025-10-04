// lib/features/own_profile/content_tab/data/models/content_form_config.dart

class ContentFormConfig {
  static const Map<String, Map<String, dynamic>> contentTypeFields = {
    'Buku': {
      'requiredFields': ['title', 'description', 'authors', 'file'],
      'metadata': {
        'isbn': {'type': 'text', 'label': 'ISBN', 'required': false},
        'pages': {'type': 'number', 'label': 'Jumlah Halaman', 'required': false},
        'publisher': {'type': 'text', 'label': 'Penerbit', 'required': false},
        'publicationYear': {'type': 'number', 'label': 'Tahun Terbit', 'required': false},
        'edition': {'type': 'text', 'label': 'Edisi', 'required': false},
      },
      'fileTypes': ['pdf', 'epub'],
      'allowVideo': false,
    },
    
    'Artikel': {
      'requiredFields': ['title', 'description', 'authors', 'file'],
      'metadata': {
        'journal': {'type': 'text', 'label': 'Nama Jurnal', 'required': false},
        'volume': {'type': 'text', 'label': 'Volume', 'required': false},
        'issue': {'type': 'text', 'label': 'Issue/Nomor', 'required': false},
        'pages': {'type': 'text', 'label': 'Halaman (contoh: 1-10)', 'required': false},
        'doi': {'type': 'text', 'label': 'DOI', 'required': false},
      },
      'fileTypes': ['pdf'],
      'allowVideo': false,
    },
    
    'Video': {
      'requiredFields': ['name', 'description', 'authors', 'video_url'],
      'metadata': {
        'duration': {'type': 'text', 'label': 'Durasi (menit)', 'required': false},
        'quality': {'type': 'select', 'label': 'Kualitas', 'options': ['720p', '1080p', '4K'], 'required': false},
        'language': {'type': 'text', 'label': 'Bahasa', 'required': false, 'default': 'Indonesian'},
        'category': {'type': 'text', 'label': 'Kategori', 'required': false},
        'tags': {'type': 'tags', 'label': 'Tags', 'required': false},
      },
      'fileTypes': [], // Video tidak butuh file upload
      'allowVideo': true,
      'requiresVideoUrl': true,
      'allowFileUpload': false,
    },
    
    'Presentasi': {
      'requiredFields': ['title', 'description', 'authors', 'file'],
      'metadata': {
        'slides': {'type': 'number', 'label': 'Jumlah Slide', 'required': false},
        'event': {'type': 'text', 'label': 'Nama Event/Konferensi', 'required': false},
        'date': {'type': 'date', 'label': 'Tanggal Presentasi', 'required': false},
        'location': {'type': 'text', 'label': 'Lokasi', 'required': false},
      },
      'fileTypes': ['ppt', 'pptx', 'pdf'],
      'allowVideo': true,
    },
    
    'Laporan Penelitian': {
      'requiredFields': ['title', 'description', 'authors', 'file'],
      'metadata': {
        'researchType': {'type': 'select', 'label': 'Jenis Penelitian', 'options': ['Kualitatif', 'Kuantitatif', 'Mixed Method'], 'required': false},
        'institution': {'type': 'text', 'label': 'Institusi Penelitian', 'required': false},
        'fundingSource': {'type': 'text', 'label': 'Sumber Dana', 'required': false},
        'keywords': {'type': 'tags', 'label': 'Kata Kunci', 'required': false},
        'abstract': {'type': 'textarea', 'label': 'Abstrak', 'required': false},
      },
      'fileTypes': ['pdf', 'doc', 'docx'],
      'allowVideo': false,
    },
    
    'Silabus': {
      'requiredFields': ['title', 'description', 'authors', 'file'],
      'metadata': {
        'subject': {'type': 'text', 'label': 'Mata Pelajaran', 'required': true},
        'grade': {'type': 'select', 'label': 'Tingkat/Kelas', 'options': ['SD', 'SMP', 'SMA', 'Kuliah'], 'required': true},
        'semester': {'type': 'select', 'label': 'Semester', 'options': ['Ganjil', 'Genap'], 'required': false},
        'curriculum': {'type': 'text', 'label': 'Kurikulum', 'required': false},
        'totalHours': {'type': 'number', 'label': 'Total Jam Pelajaran', 'required': false},
      },
      'fileTypes': ['pdf', 'doc', 'docx'],
      'allowVideo': false,
    },
    
    'Model Pembelajaran': {
      'requiredFields': ['title', 'description', 'authors', 'file'],
      'metadata': {
        'learningApproach': {'type': 'text', 'label': 'Pendekatan Pembelajaran', 'required': false},
        'targetAudience': {'type': 'text', 'label': 'Target Peserta', 'required': false},
        'duration': {'type': 'text', 'label': 'Durasi Implementasi', 'required': false},
        'tools': {'type': 'tags', 'label': 'Tools/Alat yang Dibutuhkan', 'required': false},
        'evaluation': {'type': 'text', 'label': 'Metode Evaluasi', 'required': false},
      },
      'fileTypes': ['pdf', 'doc', 'docx'],
      'allowVideo': true,
    },
  };

  static Map<String, dynamic>? getFieldsForContentType(String contentType) {
    return contentTypeFields[contentType];
  }

  static List<String> getRequiredFields(String contentType) {
    final config = contentTypeFields[contentType];
    return config?['requiredFields']?.cast<String>() ?? ['title', 'description', 'authors', 'file'];
  }

  static Map<String, dynamic> getMetadataFields(String contentType) {
    final config = contentTypeFields[contentType];
    return config?['metadata'] ?? {};
  }

  static List<String> getAllowedFileTypes(String contentType) {
    final config = contentTypeFields[contentType];
    return config?['fileTypes']?.cast<String>() ?? ['pdf'];
  }

  static bool allowsVideo(String contentType) {
    final config = contentTypeFields[contentType];
    return config?['allowVideo'] ?? false;
  }

  static bool requiresVideoUrl(String contentType) {
    final config = contentTypeFields[contentType];
    return config?['requiresVideoUrl'] ?? false;
  }

  static bool allowsFileUpload(String contentType) {
    final config = contentTypeFields[contentType];
    return config?['allowFileUpload'] ?? true;
  }

  static bool hasMetadataFields(String contentType) {
    final metadataFields = getMetadataFields(contentType);
    return metadataFields.isNotEmpty;
  }
}

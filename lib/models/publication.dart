// Publication model for UI compatibility
// TODO: Migrate UI components to use Content model from MVC

import 'package:schoolshare/models/models.dart';

class Publication {
  final String id;
  final String title;
  final String description;
  final String authorName;
  final String category;
  final int viewCount;
  final int downloadCount;
  final DateTime publishedDate;
  final List<String> tags;
  final String? thumbnailUrl;
  final bool isFree;
  
  // Additional properties for UI compatibility
  final List<String> authors;
  final String institutionName;
  final String type;
  final int readCount;
  final int likeCount;

  const Publication({
    required this.id,
    required this.title,
    required this.description,
    required this.authorName,
    required this.category,
    this.viewCount = 0,
    this.downloadCount = 0,
    required this.publishedDate,
    this.tags = const [],
    this.thumbnailUrl,
    this.isFree = true,
    this.authors = const [],
    this.institutionName = '',
    this.type = '',
    this.readCount = 0,
    this.likeCount = 0,
  });

  // Factory constructor from Content model
  factory Publication.fromContent(Content content) {
    return Publication(
      id: content.id,
      title: content.title,
      description: content.description,
      authorName: content.authors.isNotEmpty ? content.authors.first : 'Unknown',
      category: content.type,
      viewCount: content.viewCount,
      downloadCount: content.downloadCount,
      publishedDate: content.createdAt,
      tags: content.tags,
      thumbnailUrl: content.thumbnailUrl,
      isFree: content.price == null || content.price == 0,
      authors: content.authors,
      institutionName: content.institutionName,
      type: content.type,
      readCount: content.viewCount,
      likeCount: content.recommendationCount,
    );
  }

  // Convert to Content model
  Content toContent() {
    return Content(
      id: id,
      title: title,
      description: description,
      type: category,
      authors: [authorName],
      authorId: 'unknown',
      viewCount: viewCount,
      downloadCount: downloadCount,
      createdAt: publishedDate,
      tags: tags,
      thumbnailUrl: thumbnailUrl,
      price: isFree ? 0.0 : null,
    );
  }

  // Mock data for UI
  static List<Publication> get sampleData {
    return [
      Publication(
        id: '1',
        title: 'Analisis Implementasi Machine Learning dalam Sistem Pembelajaran Adaptif',
        description: 'Penelitian komprehensif tentang penerapan algoritma ML dalam sistem edukasi.',
        authorName: 'Dr. Ahmad Fauzan',
        category: 'Teknologi',
        viewCount: 256,
        downloadCount: 89,
        publishedDate: DateTime.now().subtract(const Duration(days: 2)),
        tags: ['machine learning', 'edukasi', 'adaptif'],
        isFree: true,
        authors: [
          'Dr. Ahmad Fauzan',
          'Prof. Maria Santos',
          'Dr. Sarah Wilson',
          'Johan Liebert',
          'Dr. Indira Sari',
        ],
        type: 'Jurnal',
        readCount: 256,
        likeCount: 47,
      ),
      Publication(
        id: '2',
        title: 'Modul Pembelajaran Digital Berbasis Gamifikasi',
        description: 'Modul komprehensif untuk pembelajaran berbasis teknologi digital dengan elemen game.',
        authorName: 'Johan Liebert',
        category: 'Pendidikan',
        viewCount: 189,
        downloadCount: 92,
        publishedDate: DateTime.now().subtract(const Duration(days: 5)),
        tags: ['digital', 'teknologi', 'pembelajaran', 'gamifikasi'],
        isFree: true,
        authors: [
          'Johan Liebert',
          'Dr. Ahmad Fauzan',
        ],
        type: 'Artikel',
        readCount: 189,
        likeCount: 34,
      ),
      Publication(
        id: '3',
        title: 'Rencana Pembelajaran Semester: Metodologi Penelitian',
        description: 'Template dan panduan penyusunan RPS metodologi penelitian yang efektif.',
        authorName: 'Prof. Indira Sari',
        category: 'Metodologi',
        viewCount: 167,
        downloadCount: 78,
        publishedDate: DateTime.now().subtract(const Duration(days: 1)),
        tags: ['rps', 'metodologi', 'penelitian', 'semester'],
        isFree: true,
        authors: [
          'Prof. Indira Sari',
          'Dr. Sarah Wilson',
          'Dr. Ahmad Fauzan',
        ],
        type: 'Skripsi',
        readCount: 167,
        likeCount: 29,
      ),
      Publication(
        id: '4',
        title: 'Analisis Dampak Sosial Media terhadap Perilaku Belajar Mahasiswa',
        description: 'Studi komprehensif tentang pengaruh platform digital terhadap motivasi belajar.',
        authorName: 'Dr. Sarah Wilson',
        category: 'Sosial',
        viewCount: 298,
        downloadCount: 134,
        publishedDate: DateTime.now().subtract(const Duration(days: 7)),
        tags: ['sosial media', 'perilaku', 'mahasiswa', 'digital'],
        isFree: false,
        authors: [
          'Dr. Sarah Wilson',
          'Prof. Maria Santos',
          'Johan Liebert',
          'Dr. Ahmad Fauzan',
          'Prof. Indira Sari',
          'Dr. Budi Santoso',
        ],
        type: 'Disertasi',
        readCount: 298,
        likeCount: 56,
      ),
      Publication(
        id: '3',
        title: 'Rencana Pembelajaran Semester',
        description: 'Template dan panduan penyusunan RPS yang efektif.',
        authorName: 'Prof. Indira Sari',
        category: 'Rencana Pembelajaran',
        viewCount: 67,
        downloadCount: 28,
        publishedDate: DateTime.now().subtract(Duration(days: 1)),
        tags: ['rps', 'perencanaan', 'semester'],
        isFree: true,
      ),
    ];
  }
}

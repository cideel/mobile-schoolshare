// import 'package:schoolshare/data/models/publication.dart';

// class HomeMockData {
//   // ✅ Sample authors data (keeping AuthorModel for future use)
//   static final List<AuthorModel> sampleAuthors = [
//     AuthorModel(id: 1, name: 'Anggito Pradana', profileUrl: 'https://picsum.photos/100/100?random=1'),
//     AuthorModel(id: 2, name: 'Dr. Sarah Johnson', profileUrl: 'https://picsum.photos/100/100?random=2'),
//     AuthorModel(id: 3, name: 'Prof. Michael Chen', profileUrl: 'https://picsum.photos/100/100?random=3'),
//     AuthorModel(id: 4, name: 'Dr. Lisa Wang', profileUrl: 'https://picsum.photos/100/100?random=4'),
//     AuthorModel(id: 5, name: 'Dr. Kevin Brown', profileUrl: 'https://picsum.photos/100/100?random=5'),
//     AuthorModel(id: 6, name: 'Prof. Ahmad Rahman', profileUrl: 'https://picsum.photos/100/100?random=6'),
//     AuthorModel(id: 7, name: 'Dr. Maya Sari', profileUrl: 'https://picsum.photos/100/100?random=7'),
//     AuthorModel(id: 8, name: 'Prof. David Wilson', profileUrl: 'https://picsum.photos/100/100?random=8'),
//     AuthorModel(id: 9, name: 'Dr. Elena Rodriguez', profileUrl: 'https://picsum.photos/100/100?random=9'),
//     AuthorModel(id: 10, name: 'Prof. Hiroshi Tanaka', profileUrl: 'https://picsum.photos/100/100?random=10'),
//     AuthorModel(id: 11, name: 'Dr. James Thompson', profileUrl: 'https://picsum.photos/100/100?random=11'),
//     AuthorModel(id: 12, name: 'Prof. Maria Santos', profileUrl: 'https://picsum.photos/100/100?random=12'),
//     AuthorModel(id: 13, name: 'Dr. Alex Kumar', profileUrl: 'https://picsum.photos/100/100?random=13'),
//     AuthorModel(id: 14, name: 'Prof. Sophie Laurent', profileUrl: 'https://picsum.photos/100/100?random=14'),
//     AuthorModel(id: 15, name: 'Dr. Robert Clarke', profileUrl: 'https://picsum.photos/100/100?random=15'),
//   ];

//   // ✅ Sample publishers data (keeping AuthorModel for future use)
//   static final List<AuthorModel> samplePublishers = [
//     AuthorModel(id: 101, name: 'IEEE', profileUrl: 'https://picsum.photos/100/100?random=101'),
//     AuthorModel(id: 102, name: 'ACM', profileUrl: 'https://picsum.photos/100/100?random=102'),
//     AuthorModel(id: 103, name: 'Springer', profileUrl: 'https://picsum.photos/100/100?random=103'),
//   ];

//   // ✅ User's submitted content sesuai model Publication (using String authors)
//   static final List<Publication> userSubmittedContent = [
//     Publication(
//       id: 1,
//       title: 'Implementasi Machine Learning dalam Prediksi Cuaca',
//       description: 'Penelitian ini membahas penggunaan algoritma machine learning untuk memprediksi cuaca dengan akurasi tinggi menggunakan data historis dan real-time. Metode yang digunakan meliputi Random Forest, SVM, dan Neural Networks.',
//       type: 'Laporan',
//       fileArticle: 'https://example.com/files/ml-weather-prediction.pdf',
//       videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
//       publishedDate: DateTime.now().subtract(Duration(days: 30)),
//       readCount: 128,
//       likeCount: 45,
//       downloadCount: 67,
//       shareCount: 23,
//       isRecommended: true,
//       isBookmarked: false,
//       uploaderName: 'Anggito Pradana',
//       uploaderInstitutionName: 'Universitas Indonesia',
//       uploaderProfileUrl: 'https://picsum.photos/100/100?random=user1',
//       authors: [sampleAuthors[0], sampleAuthors[1]], // Anggito + Dr. Sarah
//       publishers: [samplePublishers[0]], // IEEE
//     ),

//     Publication(
//       id: 2,
//       title: 'Analisis Dampak Sosial Media terhadap Kesehatan Mental Remaja',
//       description: 'Studi komprehensif mengenai bagaimana penggunaan media sosial mempengaruhi kesehatan mental remaja di era digital. Penelitian melibatkan 500 responden dari berbagai latar belakang.',
//       type: 'Artikel',
//       fileArticle: 'https://example.com/files/social-media-mental-health.pdf',
//       videoUrl: '',
//       publishedDate: DateTime.now().subtract(Duration(days: 15)),
//       readCount: 234,
//       likeCount: 78,
//       downloadCount: 45,
//       shareCount: 34,
//       isRecommended: false,
//       isBookmarked: true,
//       uploaderName: 'Anggito Pradana',
//       uploaderInstitutionName: 'Universitas Indonesia',
//       uploaderProfileUrl: 'https://picsum.photos/100/100?random=user1',
//       authors: [sampleAuthors[0], sampleAuthors[6], sampleAuthors[9]], // Anggito + Prof. Ahmad + Prof. Hiroshi
//       publishers: [samplePublishers[1]], // ACM
//     ),

//     Publication(
//       id: 3,
//       title: 'Optimalisasi Algoritma Sorting untuk Big Data Processing',
//       description: 'Penelitian tentang efisiensi berbagai algoritma sorting dalam memproses big data dan implementasinya dalam sistem distributed. Fokus pada performance comparison antara QuickSort, MergeSort, dan HeapSort.',
//       type: 'Video',
//       fileArticle: 'https://example.com/files/sorting-algorithms-big-data.pdf',
//       videoUrl: 'https://www.youtube.com/watch?v=example2',
//       publishedDate: DateTime.now().subtract(Duration(days: 7)),
//       readCount: 89,
//       likeCount: 32,
//       downloadCount: 28,
//       shareCount: 15,
//       isRecommended: true,
//       isBookmarked: false,
//       uploaderName: 'Anggito Pradana',
//       uploaderInstitutionName: 'Universitas Indonesia',
//       uploaderProfileUrl: 'https://picsum.photos/100/100?random=user1',
//       authors: [sampleAuthors[0], sampleAuthors[7]], // Anggito + Dr. Maya
//       publishers: [samplePublishers[2]], // Springer
//     ),

//     Publication(
//       id: 4,
//       title: 'Penerapan Blockchain dalam Sistem Voting Digital',
//       description: 'Eksplorasi penggunaan teknologi blockchain untuk menciptakan sistem voting digital yang aman dan transparan. Implementasi smart contracts untuk memastikan integritas data voting.',
//       type: 'Presentasi',
//       fileArticle: 'https://example.com/files/blockchain-voting-system.pdf',
//       videoUrl: '',
//       publishedDate: DateTime.now().subtract(Duration(days: 45)),
//       readCount: 156,
//       likeCount: 67,
//       downloadCount: 89,
//       shareCount: 42,
//       isRecommended: false,
//       isBookmarked: true,
//       uploaderName: 'Anggito Pradana',
//       uploaderInstitutionName: 'Universitas Indonesia',
//       uploaderProfileUrl: 'https://picsum.photos/100/100?random=user1',
//       authors: [sampleAuthors[0], sampleAuthors[8], sampleAuthors[10]], // Anggito + Dr. Elena + Dr. James
//       publishers: [samplePublishers[0], samplePublishers[1]], // IEEE + ACM
//     ),

//     Publication(
//       id: 5,
//       title: 'Sustainable Energy Solutions untuk Smart Cities',
//       description: 'Kajian tentang solusi energi berkelanjutan yang dapat diterapkan dalam konsep smart cities untuk masa depan yang lebih hijau. Mencakup solar power, wind energy, dan energy storage systems.',
//       type: 'Review Article',
//       fileArticle: 'https://example.com/files/sustainable-energy-smart-cities.pdf',
//       videoUrl: 'https://www.youtube.com/watch?v=example3',
//       publishedDate: DateTime.now().subtract(Duration(days: 60)),
//       readCount: 278,
//       likeCount: 94,
//       downloadCount: 123,
//       shareCount: 56,
//       isRecommended: true,
//       isBookmarked: false,
//       uploaderName: 'Anggito Pradana',
//       uploaderInstitutionName: 'Universitas Indonesia',
//       uploaderProfileUrl: 'https://picsum.photos/100/100?random=user1',
//       authors: [sampleAuthors[0], sampleAuthors[11], sampleAuthors[13], sampleAuthors[14]], // Anggito + Prof. Maria + Dr. Alex + Prof. Sophie
//       publishers: [samplePublishers[2]], // Springer
//     ),

//     Publication(
//       id: 6,
//       title: 'Deep Learning untuk Image Recognition dalam Medical Diagnosis',
//       description: 'Pengembangan sistem deep learning untuk membantu diagnosis medis melalui analisis citra medis. Menggunakan CNN dan transfer learning untuk meningkatkan akurasi diagnosis.',
//       type: 'Strategi',
//       fileArticle: 'https://example.com/files/deep-learning-medical-diagnosis.pdf',
//       videoUrl: '',
//       publishedDate: DateTime.now().subtract(Duration(days: 90)),
//       readCount: 345,
//       likeCount: 127,
//       downloadCount: 178,
//       shareCount: 78,
//       isRecommended: true,
//       isBookmarked: true,
//       uploaderName: 'Anggito Pradana',
//       uploaderInstitutionName: 'Universitas Indonesia',
//       uploaderProfileUrl: 'https://picsum.photos/100/100?random=user1',
//       authors: [sampleAuthors[0], sampleAuthors[12], sampleAuthors[3]], // Anggito + Dr. Alex + Dr. Lisa
//       publishers: [samplePublishers[0]], // IEEE
//     ),

//     Publication(
//       id: 7,
//       title: 'Implementasi Internet of Things dalam Smart Agriculture',
//       description: 'Penelitian tentang penerapan teknologi IoT untuk meningkatkan efisiensi pertanian modern. Meliputi sensor monitoring tanah, sistem irigasi otomatis, dan analisis data real-time untuk optimalisasi hasil panen.',
//       type: 'Thesis',
//       fileArticle: 'https://example.com/files/iot-smart-agriculture.pdf',
//       videoUrl: 'https://www.youtube.com/watch?v=example4',
//       publishedDate: DateTime.now().subtract(Duration(days: 20)),
//       readCount: 192,
//       likeCount: 58,
//       downloadCount: 73,
//       shareCount: 31,
//       isRecommended: true,
//       isBookmarked: false,
//       uploaderName: 'Anggito Pradana',
//       uploaderInstitutionName: 'Universitas Indonesia',
//       uploaderProfileUrl: 'https://picsum.photos/100/100?random=user1',
//       authors: [sampleAuthors[0], sampleAuthors[9], sampleAuthors[14]], // Anggito + Prof. Hiroshi + Prof. Sophie
//       publishers: [samplePublishers[2]], // Springer
//     ),

//     Publication(
//       id: 8,
//       title: 'Cybersecurity dalam Era Digital Banking',
//       description: 'Analisis mendalam tentang tantangan keamanan siber dalam industri perbankan digital dan strategi mitigasi risiko yang efektif. Studi kasus implementasi multi-factor authentication dan blockchain security.',
//       type: 'Laporan',
//       fileArticle: 'https://example.com/files/cybersecurity-digital-banking.pdf',
//       videoUrl: '',
//       publishedDate: DateTime.now().subtract(Duration(days: 35)),
//       readCount: 167,
//       likeCount: 43,
//       downloadCount: 52,
//       shareCount: 18,
//       isRecommended: false,
//       isBookmarked: true,
//       uploaderName: 'Anggito Pradana',
//       uploaderInstitutionName: 'Universitas Indonesia',
//       uploaderProfileUrl: 'https://picsum.photos/100/100?random=user1',
//       authors: [sampleAuthors[0], sampleAuthors[5], sampleAuthors[10]], // Anggito + Prof. Ahmad + Dr. James
//       publishers: [samplePublishers[1]], // ACM
//     ),

//     Publication(
//       id: 9,
//       title: 'Virtual Reality dalam Pendidikan: Transformasi Pembelajaran Interaktif',
//       description: 'Eksplorasi penggunaan teknologi Virtual Reality untuk menciptakan pengalaman pembelajaran yang immersive dan interaktif. Penelitian melibatkan implementasi VR dalam berbagai mata pelajaran dan analisis efektivitasnya.',
//       type: 'Video',
//       fileArticle: 'https://example.com/files/vr-education.pdf',
//       videoUrl: 'https://www.youtube.com/watch?v=example5',
//       publishedDate: DateTime.now().subtract(Duration(days: 12)),
//       readCount: 98,
//       likeCount: 37,
//       downloadCount: 29,
//       shareCount: 14,
//       isRecommended: true,
//       isBookmarked: false,
//       uploaderName: 'Anggito Pradana',
//       uploaderInstitutionName: 'Universitas Indonesia',
//       uploaderProfileUrl: 'https://picsum.photos/100/100?random=user1',
//       authors: [sampleAuthors[0], sampleAuthors[7], sampleAuthors[11]], // Anggito + Dr. Maya + Prof. Maria
//       publishers: [samplePublishers[0]], // IEEE
//     ),

//     Publication(
//       id: 10,
//       title: 'Data Analytics untuk E-Commerce: Strategi Personalisasi Customer Experience',
//       description: 'Penelitian komprehensif tentang penggunaan data analytics dan machine learning untuk meningkatkan customer experience dalam platform e-commerce. Fokus pada recommendation systems dan predictive analytics.',
//       type: 'Artikel',
//       fileArticle: 'https://example.com/files/data-analytics-ecommerce.pdf',
//       videoUrl: '',
//       publishedDate: DateTime.now().subtract(Duration(days: 25)),
//       readCount: 213,
//       likeCount: 76,
//       downloadCount: 91,
//       shareCount: 38,
//       isRecommended: false,
//       isBookmarked: true,
//       uploaderName: 'Anggito Pradana',
//       uploaderInstitutionName: 'Universitas Indonesia',
//       uploaderProfileUrl: 'https://picsum.photos/100/100?random=user1',
//       authors: [sampleAuthors[0], sampleAuthors[1], sampleAuthors[8], sampleAuthors[13]], // Anggito + Dr. Sarah + Dr. Elena + Dr. Alex
//       publishers: [samplePublishers[1]], // ACM
//     ),

//     Publication(
//       id: 11,
//       title: 'Cloud Computing Migration: Best Practices untuk Enterprise Systems',
//       description: 'Panduan lengkap migrasi sistem enterprise ke cloud computing dengan fokus pada security, scalability, dan cost optimization. Studi kasus implementasi multi-cloud strategy di berbagai industri.',
//       type: 'Presentasi',
//       fileArticle: 'https://example.com/files/cloud-migration-enterprise.pdf',
//       videoUrl: 'https://www.youtube.com/watch?v=example6',
//       publishedDate: DateTime.now().subtract(Duration(days: 50)),
//       readCount: 145,
//       likeCount: 39,
//       downloadCount: 61,
//       shareCount: 22,
//       isRecommended: true,
//       isBookmarked: false,
//       uploaderName: 'Anggito Pradana',
//       uploaderInstitutionName: 'Universitas Indonesia',
//       uploaderProfileUrl: 'https://picsum.photos/100/100?random=user1',
//       authors: [sampleAuthors[0], sampleAuthors[6], sampleAuthors[14]], // Anggito + Prof. Ahmad + Prof. Sophie
//       publishers: [samplePublishers[0], samplePublishers[2]], // IEEE + Springer
//     ),

//     Publication(
//       id: 12,
//       title: 'Augmented Reality dalam Industri Manufaktur: Revolusi Proses Produksi',
//       description: 'Analisis implementasi teknologi Augmented Reality dalam proses manufaktur untuk meningkatkan efisiensi, mengurangi error, dan mempercepat training karyawan. Termasuk ROI analysis dan future trends.',
//       type: 'Model Pembelajaran',
//       fileArticle: 'https://example.com/files/ar-manufacturing.pdf',
//       videoUrl: '',
//       publishedDate: DateTime.now().subtract(Duration(days: 75)),
//       readCount: 187,
//       likeCount: 64,
//       downloadCount: 82,
//       shareCount: 27,
//       isRecommended: false,
//       isBookmarked: true,
//       uploaderName: 'Anggito Pradana',
//       uploaderInstitutionName: 'Universitas Indonesia',
//       uploaderProfileUrl: 'https://picsum.photos/100/100?random=user1',
//       authors: [sampleAuthors[0], sampleAuthors[2], sampleAuthors[9], sampleAuthors[12]], // Anggito + Prof. Michael + Prof. Hiroshi + Dr. Alex
//       publishers: [samplePublishers[2]], // Springer
//     ),
//   ];

//   // ✅ Existing publications (from other users)
//   static final List<Publication> publications = [
//     Publication(
//       id: 101,
//       title: 'Artificial Intelligence in Healthcare: Current Trends and Future Prospects',
//       description: 'Comprehensive overview of AI applications in healthcare sector.',
//       type: 'Model Pembelajaran',
//       fileArticle: 'https://example.com/files/ai-healthcare.pdf',
//       videoUrl: 'https://www.youtube.com/watch?v=healthcare_ai',
//       publishedDate: DateTime.now().subtract(Duration(days: 5)),
//       readCount: 456,
//       likeCount: 89,
//       downloadCount: 234,
//       shareCount: 67,
//       isRecommended: false,
//       isBookmarked: false,
//       uploaderName: 'Dr. Jane Smith',
//       uploaderInstitutionName: 'Stanford University',
//       uploaderProfileUrl: 'https://picsum.photos/100/100?random=other1',
//       authors: [sampleAuthors[1], sampleAuthors[2]],
//       publishers: [samplePublishers[1]],
//     ),
//     // Add more publications as needed...
//   ];

//   // ✅ Methods untuk get user content
//   static List<Publication> getUserContent({int? limit}) {
//     if (limit != null && limit > 0) {
//       return userSubmittedContent.take(limit).toList();
//     }
//     return List.from(userSubmittedContent);
//   }

//   // ✅ Get content by type
//   static List<Publication> getContentByType(String type) {
//     return userSubmittedContent.where((pub) => pub.type.toLowerCase().contains(type.toLowerCase())).toList();
//   }
  
//   // ✅ Get bookmarked content
//   static List<Publication> getBookmarkedContent() {
//     return userSubmittedContent.where((pub) => pub.isBookmarked).toList();
//   }

//   // ✅ Get recommended content
//   static List<Publication> getRecommendedContent() {
//     return userSubmittedContent.where((pub) => pub.isRecommended).toList();
//   }

//   // ✅ Statistics for user content
//   static Map<String, dynamic> getUserContentStats() {
//     final totalReads = userSubmittedContent.fold(0, (sum, pub) => sum + pub.readCount);
//     final totalDownloads = userSubmittedContent.fold(0, (sum, pub) => sum + pub.downloadCount);
//     final totalLikes = userSubmittedContent.fold(0, (sum, pub) => sum + pub.likeCount);
//     final totalShares = userSubmittedContent.fold(0, (sum, pub) => sum + pub.shareCount);
    
//     return {
//       'totalContent': userSubmittedContent.length,
//       'totalReads': totalReads,
//       'totalDownloads': totalDownloads,
//       'totalLikes': totalLikes,
//       'totalShares': totalShares,
//       'totalBookmarked': getBookmarkedContent().length,
//       'totalRecommended': getRecommendedContent().length,
//       'contentTypes': _getContentTypesCount(),
//       'averageReads': userSubmittedContent.isNotEmpty ? (totalReads / userSubmittedContent.length).round() : 0,
//       'mostPopular': _getMostPopularContent(),
//     };
//   }

//   // ✅ Helper methods
//   static Map<String, int> _getContentTypesCount() {
//     final Map<String, int> typeCount = {};
//     for (var pub in userSubmittedContent) {
//       typeCount[pub.type] = (typeCount[pub.type] ?? 0) + 1;
//     }
//     return typeCount;
//   }

//   static Publication? _getMostPopularContent() {
//     if (userSubmittedContent.isEmpty) return null;
    
//     return userSubmittedContent.reduce((a, b) => 
//       (a.readCount + a.downloadCount + a.likeCount) > 
//       (b.readCount + b.downloadCount + b.likeCount) ? a : b
//     );
//   }

//   // ✅ Search content
//   static List<Publication> searchUserContent(String query) {
//     final lowerQuery = query.toLowerCase();
//     return userSubmittedContent.where((pub) => 
//       pub.title.toLowerCase().contains(lowerQuery) ||
//       pub.description.toLowerCase().contains(lowerQuery) ||
//       pub.type.toLowerCase().contains(lowerQuery) ||
//       pub.authors.any((author) => author.name.toLowerCase().contains(lowerQuery))
//     ).toList();
//   }

//   // ✅ Update publication stats (for testing purposes)
//   static void updatePublicationStats(int publicationId, {
//     int? readCount,
//     int? likeCount,
//     int? downloadCount,
//     int? shareCount,
//     bool? isBookmarked,
//     bool? isRecommended,
//   }) {
//     final index = userSubmittedContent.indexWhere((pub) => pub.id == publicationId);
//     if (index != -1) {
//       final pub = userSubmittedContent[index];
//       userSubmittedContent[index] = pub.copyWith(
//         readCount: readCount,
//         likeCount: likeCount,
//         downloadCount: downloadCount,
//         shareCount: shareCount,
//         isBookmarked: isBookmarked,
//         isRecommended: isRecommended,
//       );
//     }
//   }
// }
// // lib/data/datasources/home_mock_data.dart
// import '../models/publication.dart';

// class HomeMockData {
//   static const Duration networkDelay = Duration(milliseconds: 500);

//   static List<Publication> get publications => [
//     Publication(
//       id: '1',
//       title: 'Artificial Intelligence in Education: A Comprehensive Study',
//       description: 'This research explores the implementation of AI technologies in modern educational systems and their impact on learning outcomes.',
//       type: 'Laporan',
//       authors: ['Dr. Sarah Johnson', 'Prof. Michael Chen'],
//       imageUrl: 'https://via.placeholder.com/300x200/0066CC/FFFFFF?text=AI+Education',
//       publishedDate: DateTime.now().subtract(const Duration(days: 5)),
//       readCount: 1250,
//       likeCount: 89,
//       category: 'Technology',
//       institutionName: 'MIT',
//     ),
//     Publication(
//       id: '2',
//       title: 'Sustainable Development Goals in Higher Education',
//       description: 'Analyzing the integration of UN SDGs into university curricula and research programs across different institutions.',
//       type: 'Artikel',
//       authors: ['Prof. Emily Rodriguez', 'Dr. James Wilson'],
//       imageUrl: 'https://via.placeholder.com/300x200/009688/FFFFFF?text=SDG+Education',
//       publishedDate: DateTime.now().subtract(const Duration(days: 12)),
//       readCount: 890,
//       likeCount: 67,
//       category: 'Environment',
//       institutionName: 'Stanford University',
//     ),
//     Publication(
//       id: '3',
//       title: 'Machine Learning Applications in Healthcare Research',
//       description: 'A detailed study on how machine learning algorithms are revolutionizing medical research and patient care.',
//       type: 'Video',
//       authors: ['Dr. Ahmed Rahman', 'Dr. Lisa Chang'],
//       imageUrl: 'https://via.placeholder.com/300x200/FF5722/FFFFFF?text=ML+Healthcare',
//       publishedDate: DateTime.now().subtract(const Duration(days: 8)),
//       readCount: 2150,
//       likeCount: 156,
//       category: 'Healthcare',
//       institutionName: 'Harvard Medical School',
//     ),
//     Publication(
//       id: '4',
//       title: 'Climate Change Impact on Agricultural Sustainability',
//       description: 'Research findings on how climate change affects crop yields and farming practices in developing countries.',
//       type: 'Silabus',
//       authors: ['Prof. Maria Garcia', 'Dr. Robert Kim'],
//       imageUrl: 'https://via.placeholder.com/300x200/4CAF50/FFFFFF?text=Climate+Agriculture',
//       publishedDate: DateTime.now().subtract(const Duration(days: 3)),
//       readCount: 675,
//       likeCount: 43,
//       category: 'Agriculture',
//       institutionName: 'UC Davis',
//     ),
//     Publication(
//       id: '5',
//       title: 'Blockchain Technology in Supply Chain Management',
//       description: 'Exploring the potential of blockchain technology to improve transparency and efficiency in global supply chains.',
//       type: 'Jurnal',
//       authors: ['Dr. John Smith', 'Prof. Anna Thompson'],
//       imageUrl: 'https://via.placeholder.com/300x200/9C27B0/FFFFFF?text=Blockchain+Supply',
//       publishedDate: DateTime.now().subtract(const Duration(days: 15)),
//       readCount: 1580,
//       likeCount: 112,
//       category: 'Technology',
//       institutionName: 'Oxford University',
//     ),
//   ];

//   static List<String> get categories => [
//     'All',
//     'Technology', 
//     'Healthcare',
//     'Environment',
//     'Agriculture',
//     'Education',
//     'Business',
//   ];

//   static List<String> get popularTopics => [
//     'Artificial Intelligence',
//     'Machine Learning',
//     'Sustainability',
//     'Climate Change',
//     'Digital Transformation',
//     'Healthcare Innovation',
//   ];
// }

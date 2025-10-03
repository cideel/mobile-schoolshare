// lib/core/utils/publication_type_formatter.dart

extension PublicationTypeFormatter on String {
  String toTitleCaseType() {
    switch (toLowerCase()) {
      case 'report':
        return 'Report';
      case 'book':
        return 'Book';
      case 'article':
        return 'Article';
      case 'video':
        return 'Video';
      default:
        return this; // fallback, biar tidak error
    }
  }
}

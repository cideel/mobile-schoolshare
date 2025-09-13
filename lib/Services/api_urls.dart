class ApiUrls {
  static const String baseUrl = 'http://192.168.1.5:8000';
  static const String storageUrl = 'http://192.168.1.5:8000/storage';

  // Authentication
  static const String loginUrl = '$baseUrl/api/login';
  static const String registerUrl = '$baseUrl/api/register';

  static const String getInstitusion = '$baseUrl/api/institusi';
  static const String addInstitusion = '$baseUrl/api/institusi';

  // Profile User
  static const String getProfile = '$baseUrl/api/me';
  static const String updatePictureProfile = '$baseUrl/api/profileupdate';

  // Home
  static const String getHome = '$baseUrl/api/content';
  static String getDetail(int id) => '$baseUrl/api/content/$id';
}

class ApiUrls {
  static const String baseUrl = "http://192.168.1.4:8000/api";
  static const String storageUrl = "http://192.168.1.4:8000/storage";
  // Authentication APIs
  static const String login = "$baseUrl/login";
  static const String register = "$baseUrl/register";
  static const String fetchInstitution = "$baseUrl/institusi";
  static const String addInstitution = "$baseUrl/institusi";

  // Profile APIs
  static const String userProfile = "$baseUrl/me";
  static const String updateProfile = "$baseUrl/profileupdate";

  // Home APIs
  static const String contentList = "$baseUrl/content";

  // Download Share Bookmark APIs
  static String downloadContent(String contentId) =>
      "$baseUrl/content/$contentId/download";
  static String shareContent(String contentId) =>
      "$baseUrl/content/$contentId/share";
  static String recommendContent(String contentId) =>
      "$baseUrl/content/$contentId/recommend";
  static const String toggleBookmark = "$baseUrl/bookmark";

  // Detail Content APIs
  static String contentDetail(String contentId) =>
      "$baseUrl/content/$contentId";

  // List Bookmark APIs
  static String bookmarkList(String userId) => "$baseUrl/bookmark/list/$userId";

  // Search APIs
  static const String userSearch = "$baseUrl/users/search";
  static const String publicationSearch = "$baseUrl/content/search";
  static const String discussionSearch = "$baseUrl/forums/search";
}

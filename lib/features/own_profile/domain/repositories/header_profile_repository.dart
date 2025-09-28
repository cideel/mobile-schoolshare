abstract class HeaderProfileRepository {
  /// Mengambil data profil pengguna dari sumber data (misalnya API).
  Future<Map<String, dynamic>> getUserProfile();
  
  Future<void> updateProfilePicture(String filePath);
}

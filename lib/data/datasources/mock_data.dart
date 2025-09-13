// lib/features/auth/data/datasources/mock_data.dart
// MOCK DATA FOR AUTHENTICATION
class MockAuthData {
  static const Duration networkDelay = Duration(milliseconds: 800);
  
  static final Map<String, Map<String, dynamic>> predefinedUsers = {
    'dosen@ui.ac.id': {
      'password': 'dosen123',
      'user': {
        'id': 1001,
        'role_group_id': 2,
        'email': 'dosen@ui.ac.id',
        'name': 'Dr. Ahmad Rahman',
        'role': 'dosen',
        'profile': 'Dr. Ahmad Rahman',
        'profileImage': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
        'createdAt': '2023-06-15T00:00:00Z',
        'isEmailVerified': true,
        'phoneNumber': '+6281234567890',
        'phone': '+6281234567890',
        'university': 'Universitas Indonesia',
        'department': 'Teknik Informatika',
      }
    },
    'mahasiswa@itb.ac.id': {
      'password': 'student123',
      'user': {
        'id': 1002, 
        'role_group_id': 1, 
        'email': 'mahasiswa@itb.ac.id',
        'name': 'Siti Nurhaliza',
        'role': 'mahasiswa',
        'profile': 'Siti Nurhaliza', 
        'profileImage': 'https://images.unsplash.com/photo-1494790108755-2616b34cf816?w=150',
        'createdAt': '2023-09-01T00:00:00Z',
        'isEmailVerified': true,
        'phoneNumber': '+6281234567891',
        'phone': '+6281234567891', 
        'university': 'Institut Teknologi Bandung',
        'department': 'Sistem Informasi',
      }
    },
    'admin@schoolshare.com': {
      'password': 'admin123',
      'user': {
        'id': 1003, 
        'role_group_id': 3, 
        'email': 'admin@schoolshare.com',
        'name': 'Admin SchoolShare',
        'role': 'admin',
        'profile': 'Admin SchoolShare',
        'profileImage': 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150',
        'createdAt': '2023-01-01T00:00:00Z',
        'isEmailVerified': true,
        'phoneNumber': '+6281234567892',
        'phone': '+6281234567892', 
        'university': 'SchoolShare',
        'department': 'Administration',
      }
    },
    'guru@sdn1.sch.id': {
      'password': 'guru123',
      'user': {
        'id': 1004, 
        'role_group_id': 4, 
        'email': 'guru@sdn1.sch.id',
        'name': 'Ibu Sari Wulandari',
        'role': 'guru',
        'profile': 'Ibu Sari Wulandari',
        'profileImage': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150',
        'createdAt': '2023-08-01T00:00:00Z',
        'isEmailVerified': true,
        'phoneNumber': '+6281234567893',
        'phone': '+6281234567893', 
        'university': 'SDN 1 Jakarta',
        'department': 'Kelas 5',
      }
    },
  };

  static Map<String, dynamic> generateUserData(String email, String password) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return {
      'password': password,
      'user': {
        'id': timestamp, 
        'role_group_id': _determineRoleGroupId(email), 
        'email': email,
        'name': 'User ${email.split('@').first.toUpperCase()}',
        'role': _determineRoleFromEmail(email),
        'profile': 'User ${email.split('@').first.toUpperCase()}',
        'profileImage': null,
        'createdAt': DateTime.now().toIso8601String(),
        'isEmailVerified': false,
        'phoneNumber': null,
        'phone': null,
        'university': _extractUniversityFromEmail(email),
        'department': null,
      }
    };
  }

  static int _determineRoleGroupId(String email) {
    if (email.contains('mahasiswa')) return 1;
    if (email.contains('dosen')) return 2;
    if (email.contains('admin')) return 3;
    if (email.contains('guru')) return 4;
    return 1; 
  }

  static String _determineRoleFromEmail(String email) {
    if (email.contains('dosen')) return 'dosen';
    if (email.contains('guru')) return 'guru';
    if (email.contains('admin')) return 'admin';
    return 'mahasiswa';
  }

  static String _extractUniversityFromEmail(String email) {
    if (!email.contains('@')) return 'Unknown University';
    final domain = email.split('@')[1];
    final universityPart = domain.split('.').first;
    return universityPart.toUpperCase();
  }
}

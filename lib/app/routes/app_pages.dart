import 'package:get/get.dart';
import 'package:schoolshare/features/bookmark/bindings/bookmark_binding.dart';
import 'package:schoolshare/features/detail_content/presentation/bindings/content_detail_binding.dart';
import 'package:schoolshare/features/detail_content/presentation/pages/detail_content.dart';
import 'package:schoolshare/features/own_profile/bindings/header_profile_binding.dart';
import 'package:schoolshare/features/own_profile/bindings/profile_tab_profile_binding.dart';
import 'package:schoolshare/features/own_profile/bindings/statistic_tab_binding.dart';
import 'package:schoolshare/features/search/presentation/bindings/discussion_binding.dart';
import 'package:schoolshare/features/search/presentation/bindings/people_binding.dart';
import 'package:schoolshare/features/search/presentation/bindings/publication_binding.dart';
import 'package:schoolshare/features/search/presentation/pages/main_search/search_page.dart';
import '../../features/auth/bindings/auth_binding.dart';
import '../../features/home/bindings/home_binding.dart';
import '../../features/auth/presentation/pages/login.dart';
import '../../features/auth/presentation/pages/register.dart';
import '../../features/auth/presentation/pages/add_institution.dart';
import '../../core/widgets/splash_screen.dart';
import '../../core/widgets/navbart.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: AuthBinding(), // 🔥
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => const Register(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.ADD_INSTITUTION,
      page: () => const RegisterInstitution(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => NavBarScreen(),
      bindings: [
        AuthBinding(),
        HomeBinding(),
        HeaderProfileBinding(),
        ProfileTabBinding(),
        StatisticTabBinding(),
        PeopleBinding(),
      ],
    ),
    GetPage(
      name: Routes.DETAIL_CONTENT,
      page: () {
        // Mendapatkan contentId dari argumen saat navigasi
        final contentId = Get.arguments as String? ?? '';
        return DetailContent(contentId: contentId);
      },
      binding: ContentDetailBinding(),
    ),
    GetPage(
      name: Routes.BOOKMARK,
      page: () => NavBarScreen(),
      bindings: [
        BookmarkBinding(),
      ],
    ),
    GetPage(
      name: Routes.SEARCH,
      page: () => const SearchPage(),
      bindings: [
        PublicationBinding(),
        PeopleBinding(),
        DiscussionBinding(),
      ],
    ),
  ];
}

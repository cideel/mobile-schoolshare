import 'package:get/get.dart';
import '../../features/auth/bindings/auth_binding.dart';
import '../../features/home/bindings/home_binding.dart';
import '../../features/auth/presentation/pages/login.dart';
import '../../features/auth/presentation/pages/register.dart';
import '../../features/auth/presentation/pages/add_institution.dart';
import '../../features/notification/pages/notif.dart';
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
      page: () => const LoginPage(),
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
      ],
    ),
    GetPage(
      name: Routes.NOTIFICATION,
      page: () => const NotifPage(),
    ),
  ];
}
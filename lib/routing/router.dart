import 'package:fpaper/presentation/auth/ui/auth_page.dart';
import 'package:fpaper/presentation/device/ui/device_page.dart';
import 'package:fpaper/presentation/home/ui/home_page.dart';
import 'package:fpaper/routing/app_route.dart';
import 'package:fpaper/service/user_service.dart';
import 'package:go_router/go_router.dart';

GoRouter getAppRouter(UserService userService) => GoRouter(
      initialLocation: AppRoute.home.path,
      urlPathStrategy: UrlPathStrategy.hash,
      redirect: (state) {
        final isLoggedIn = userService.currentUser != null;
        final shouldRegisterDevice = userService.shouldRegisterDevice;
        final loginRoutePath = AppRoute.login.path;
        final homeRoutePath = AppRoute.home.path;
        final deviceRoutePath = AppRoute.device.path;

        if (isLoggedIn && state.location == loginRoutePath) {
          return homeRoutePath;
        } else if (shouldRegisterDevice && state.location != deviceRoutePath) {
          return deviceRoutePath;
        } else if (!isLoggedIn && state.location != loginRoutePath) {
          return loginRoutePath;
        }

        return null;
      },
      refreshListenable: GoRouterRefreshStream(userService.watchUser),
      routes: [
        GoRoute(
          path: AppRoute.login.path,
          name: AppRoute.login.name,
          builder: (context, state) => const AuthPage(),
        ),
        GoRoute(
          path: AppRoute.home.path,
          name: AppRoute.home.name,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: AppRoute.device.path,
          name: AppRoute.device.name,
          builder: (context, state) => const DevicePage(),
        ),
      ],
    );

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';

import '../../presenters/homepage.dart';
import '../../presenters/login_page.dart';
import '../../presenters/video_camera.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  // TODO: implement routes
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(
          page: HomeRoute.page,
        ),
        AutoRoute(page: VideoCameraRoute.page)
      ];
}

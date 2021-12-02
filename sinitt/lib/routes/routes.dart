import 'package:flutter/cupertino.dart';
import 'package:sinitt/screens/home.dart';
import 'package:sinitt/screens/splash_screen.dart';
import 'package:sinitt/utils/request_permission_page.dart';
import 'package:sinitt/widgets/drawer.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/splash'    : (_) => const SplashPage(),
  '/permission':(_) => const RequestPermissionPage(),
  '/home'      : (_) => const HomePage(),
  '/drawer'    : (_) => const AppDrawer()
};
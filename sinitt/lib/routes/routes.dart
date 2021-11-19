import 'package:flutter/cupertino.dart';
import 'package:sinitt/screens/home.dart';
import 'package:sinitt/widgets/drawer.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/'      : (context) => const HomePage(),
  '/drawer': (context) => const AppDrawer()
};
import 'package:get/get.dart';

import '../modules/Success/bindings/success_binding.dart';
import '../modules/Success/views/success_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SUCCESS,
      page: () => const SuccessView(),
      binding: SuccessBinding(),
    ),
  ];
}
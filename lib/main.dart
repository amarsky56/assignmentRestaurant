import 'package:assignment/services/storage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'app/routes/app_pages.dart';
//done
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initGetServices();
  runApp(
    Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        title: "Assignment",
        initialRoute: AppPages.INITIAL,
        debugShowCheckedModeBanner: false,
        getPages: AppPages.routes,
      );
    }),
  );
}

Future<void> initGetServices() async {
  await Get.putAsync<GetStorageService>(() => GetStorageService().initState());
}

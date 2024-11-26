import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mo_happ/bindings/doors_binding.dart';
import 'package:mo_happ/bindings/main_binding.dart';
import 'package:mo_happ/pages/doors/doors.dart';
import 'package:mo_happ/pages/main/main.dart';
import 'package:mo_happ/routes/routes.dart';

class MontyHall extends StatelessWidget {
  const MontyHall({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        // statusBarColor: Colors.black,
        // statusBarIconBrightness: Brightness.light,
      ),
    );
    return GetMaterialApp(
      getPages: [
        GetPage(
          name: Routes.main,
          page: () => const Main(),
          title: 'Monty Hall',
          binding: MainBinding(),
        ),
        GetPage(
          name: Routes.doors,
          page: () => const Doors(),
          title: 'Doors',
          binding: DoorsBinding(),
        ),
      ],
      initialRoute: Routes.main,
      initialBinding: MainBinding(),
      debugShowCheckedModeBanner: false,
      title: 'MoHapp',
    );
  }
}

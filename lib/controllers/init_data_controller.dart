import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import 'controllers.dart';

class InitDataController extends GetxController {
  final EventController eventController = Get.put(EventController());
  final ClubController clubController = Get.put(ClubController());

  Future<void> initAllData() {
    return Future.wait([
      eventController.fetchEvents(),
      clubController.fetchClubs(),
    ]).then((value) => FlutterNativeSplash.remove());
  }
}

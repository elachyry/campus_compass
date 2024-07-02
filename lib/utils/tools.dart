import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Tools{
    
    static confirmationDialog(
    String title,
    String icon,
    VoidCallback onTap,
    Color bg,
  ) {
    Get.defaultDialog(
      titleStyle: const TextStyle(fontSize: 0),
      titlePadding: const EdgeInsets.all(0),
      title: '',
      // backgroundColor: bg,
      middleText: title,
      content: Column(
        children: [
          Image.asset(
            icon,
            width: 100,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
          )
        ],
      ),
      cancel: SizedBox(
        width: 100,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(),
          onPressed: () {
            Get.back();
          },
          child: FittedBox(
            child: Text(
              'no'.tr,
              style: const TextStyle(
                fontSize: 18,
                // fontWeight: FontWeight.bold,
                // color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      confirm: SizedBox(
        width: 100,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(),
          onPressed: onTap,
          child: FittedBox(
            child: Text(
              'yes'.tr,
              style: const TextStyle(
                fontSize: 18,
                // fontWeight: FontWeight.bold,
                // color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      // textConfirm: 'yes'.tr,
      // confirmTextColor: Colors.white,
      // textCancel: 'no'.tr,
      // cancelTextColor: Colors.black,
      onConfirm: onTap,
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import '../models/models.dart';
import 'controllers.dart';

class EventController extends GetxController {
  final firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final SqfliteController sqfliteController = Get.put(SqfliteController());

  RxList<Event> events = <Event>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  Future<void> fetchEventsLocal() async {
    List<Event> localEvents = await sqfliteController.getEvents();
    events.assignAll(localEvents);
  }

  Future<void> fetchEvents() async {
    try {
      QuerySnapshot snapshot = await firestore.collection('events').get();
      List<Event> fetchedEvents = snapshot.docs.map((doc) {
        return Event.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      events.assignAll(fetchedEvents);

      // Insert fetched events into SQLite database
      for (Event event in fetchedEvents) {
        await sqfliteController.insertEventIfNotExists(event);
      }
    } catch (e) {
      // print('Error fetching events: $e');
    }
  }

  Future<void> addEvent(Event event) async {
    try {
      await firestore.collection('events').doc(event.id).set(event.toJson());
      events.add(event);
      await sqfliteController.insertEventIfNotExists(event);
    } catch (e) {
      // print('Error adding event: $e');
    }
  }


}

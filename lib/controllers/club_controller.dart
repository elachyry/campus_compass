import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compus_map/controllers/sqflite_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import '../models/models.dart';

class ClubController extends GetxController
{
   final firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final SqfliteController sqfliteController = Get.put(SqfliteController());

  RxList<Club> clubs = <Club>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchClubs();
  }

  Future<void> fetchClubsLocal() async {
    List<Club> localClubs = await sqfliteController.getClubs();
    clubs.assignAll(localClubs);
  }

  Future<void> fetchClubs() async {
    try {
      QuerySnapshot snapshot = await firestore.collection('clubs').get();
      List<Club> fetchedClubs = snapshot.docs.map((doc) {
        return Club.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      clubs.assignAll(fetchedClubs);

      // Insert fetched events into SQLite database
      for (Club club in fetchedClubs) {
        await sqfliteController.insertClubIfNotExists(club);
      }
    } catch (e) {
      // print('Error fetching events: $e');
    }
  }

  Future<void> addClub(Club club) async {
    try {
      await firestore.collection('clubs').doc(club.id).set(club.toJson());
      clubs.add(club);
      await sqfliteController.insertClubIfNotExists(club);
    } catch (e) {
      // print('Error adding event: $e');
    }
  }
}
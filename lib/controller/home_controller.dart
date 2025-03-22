import 'package:chat_app/services/firestore_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Stream<QuerySnapshot<Map<String, dynamic>>>? fetchUsers;
  void fetchUserData() {
    fetchUsers = FirestoreServices.firestoreServices.fetchUser();
    update();
  }
}

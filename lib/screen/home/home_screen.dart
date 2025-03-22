import 'package:chat_app/controller/home_controller.dart';
import 'package:chat_app/controller/login_controller.dart';
import 'package:chat_app/modals/user_modal.dart';
import 'package:chat_app/services/firestore_services.dart';
import 'package:chat_app/utils/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = Get.put(HomeController());
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              loginController.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      // backgroundColor: Colors.white,
      drawer: Drawer(
        child: Column(
          children: [
            FutureBuilder(
              future: FirestoreServices.firestoreServices.fetchSingleUser(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error : ${snapshot.error}"),
                  );
                } else if (snapshot.hasData) {
                  DocumentSnapshot<Map<String, dynamic>>? data = snapshot.data;
                  UserModel user = UserModel.fromJson(data?.data() ?? {});
                  return UserAccountsDrawerHeader(
                    accountName: Text(user.name),
                    accountEmail: Text(user.email),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(user.image),
                    ),
                  );
                }
                return Container();
              },
            ),
            ListTile(
              leading: const Icon(Icons.wallpaper),
              title: const Text('Wallpaper'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {},
            ),
            // ListTile(
            //   leading: const Icon(Icons.logout_outlined),
            //   title: const Text('Logout'),
            //   onTap: () {
            //     loginController.signOut();
            //   },
            // ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Chats"),
            Expanded(
              child: StreamBuilder(
                stream: FirestoreServices.firestoreServices.fetchUser(),
                builder: (context, snapshot) {
                  var data = snapshot.data;
                  var allData = data?.docs ?? [];
                  List<UserModel> allUsers =
                      allData.map((e) => UserModel.fromJson(e.data())).toList();
                  return ListView.builder(
                    itemCount: allUsers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Get.toNamed(AppRoutes.chatPage,
                              arguments: allUsers[index]);
                        },
                        onLongPress: () {
                          FirestoreServices.firestoreServices
                              .deleteUser(email: allUsers[index].email);
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(allUsers[index].image),
                        ),
                        title: Text(allUsers[index].name),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

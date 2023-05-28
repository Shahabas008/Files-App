import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_app/controller/homepage_controller.dart';
import 'package:file_app/controller/signup_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = Get.put(HomePagecontroller());
  final signUpController = Get.put(SignUpController());
  TextEditingController titleController = TextEditingController();
  User? currentuser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.isDarkMode
                  ? Get.changeTheme(
                      ThemeData.light(),
                    )
                  : Get.changeTheme(
                      ThemeData.dark(),
                    );
            },
            icon: const Icon(
              Icons.light_rounded,
            ),
          ),
          title: const Text(
            "Files App",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                signUpController.signOut();
              },
              icon: const Icon(
                Icons.logout_outlined,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //search bar
                TextFormField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 3, color: Colors.teal.shade100),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 3, color: Colors.teal.shade100),
                      ),
                      hintText: "Search..."),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Important Docs Section",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //important section

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //ADHAAR
                    InkWell(
                      onTap: () {
                        //uploading the files to the application
                        homeController.pickAdhaarFile();
                        homeController.uploadAdhaarFile();
                        homeController.uploadAdhaarDownloadUrl();
                      },
                      child:
                          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection("Users")
                            .doc(currentuser!.email)
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<
                                    DocumentSnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.teal[100]!,
                                  ),
                                ),
                                width: width / 4,
                                height: height * 0.1,
                                //make the text if the image is null
                                child:
                                    snapshot.data!.data()?["Adhaar File URL"] ==
                                            null
                                        ? const Align(
                                            alignment: Alignment.center,
                                            child: Text("Container for adhaar"))
                                        : Image.network(snapshot.data!
                                                .data()?["Adhaar File URL"] ??
                                            ""));
                          } else {
                            return const Text("Adhaar File URL");
                          }
                        },
                      ),
                    ),
                    //PAN
                    InkWell(
                      onTap: () {
                        //uploading the files to the application
                        homeController.pickPanFile();
                        homeController.uploadPanFile();
                        homeController.uploadPanDownloadUrl();
                      },
                      child:
                          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection("Users")
                            .doc(currentuser!.email)
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<
                                    DocumentSnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.teal[100]!,
                                  ),
                                ),
                                width: width / 4,
                                height: height * 0.1,
                                //make the text if the image is null
                                child: snapshot.data!.data()?["PAN File URL"] ==
                                        null
                                    ? const Align(
                                        alignment: Alignment.center,
                                        child: Text("Container for PAN"))
                                    : Image.network(snapshot.data!
                                            .data()?["PAN File URL"] ??
                                        ""));
                          } else {
                            return const Text("PAN File URL");
                          }
                        },
                      ),
                    ),
                    //LICENSE
                    InkWell(
                      onTap: () {
                        //uploading the files to the application
                        homeController.pickLicenseFile();
                        homeController.uploadLicenseFile();
                        homeController.uploadLicenseDownloadUrl();
                      },
                      child:
                          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection("Users")
                            .doc(currentuser!.email)
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<
                                    DocumentSnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.teal[100]!,
                                  ),
                                ),
                                width: width / 4,
                                height: height * 0.1,
                                //make the text if the image is null
                                child: snapshot.data!
                                            .data()?["License File URL"] ==
                                        null
                                    ? const Align(
                                        alignment: Alignment.center,
                                        child: Text("Container for license"))
                                    : Image.network(snapshot.data!
                                            .data()?["License File URL"] ??
                                        ""));
                          } else {
                            return const Text("License File URL");
                          }
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: height * 0.05,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Created Folders",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  height: 0.05,
                  thickness: 0.4,
                  color: Colors.black,
                ),
                SingleChildScrollView(
                  child: Obx(
                    () {
                      return homeController.cardList.isEmpty
                          ? Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                children: [
                                  Image.asset('assets/image/noimage.png'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "YOU HAVEN'T ADDED ANY FOLDERS",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ))
                          : SizedBox(
                              height: height,
                              child: ListView.builder(
                                itemCount: homeController.cardList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      homeController.cardList[index].navigateto;
                                    },
                                    child: SizedBox(
                                      width: width,
                                      height: height * 0.08,
                                      child: Card(
                                        color: Colors.teal[100],
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: Text(homeController
                                                .cardList[index].title)),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal[100],
          foregroundColor: Colors.black,
          child: const Text(
            "+",
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          onPressed: () {
            //creating a new folder on the page
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: TextFormField(
                    controller: titleController,
                    decoration:
                        const InputDecoration(hintText: "Enter Folder name"),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        homeController.createFolder(
                          title: titleController.text.trim(),
                          context: context,
                          navigateto: () {
                            // navigating to the page of the folder
                            homeController.createFolder(
                              title: titleController.text.trim(),
                              context: context,
                              navigateto: () {
                                //navigate each folder
                              },
                            );
                          },
                        );
                        Navigator.pop(context);
                      },
                      child: const Text("Create"),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

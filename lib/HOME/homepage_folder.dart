import 'dart:developer';

import 'package:file_app/HOME/homepage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePagefolder extends StatelessWidget {
  HomePagefolder({super.key});
  final folderName = Get.arguments["Folder Name"];
  final homeController = Get.put(HomePagecontroller());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(folderName)),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  log(folderName);
                  homeController.pickFolderFile();
                  homeController.uploadFolderFile();
                  homeController.uploadFolderDownloadUrl(
                      folderNames: folderName);
                },
                child: const Text("press the Button to upload the files"))
          ],
        ),
      ),
    );
  }
}

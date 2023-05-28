import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';

class HomePageFolderController extends GetxController {
  User? currentuser = FirebaseAuth.instance.currentUser;
  File? file;
  String? folderName;
  // uploading the files to the firestore from the desired folders
  pickFolderFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null && result.files.isNotEmpty) {
      file = File(result.files.single.path!);
      final fileName = Path.basename(file!.path);
      final destination = 'folders/$fileName';
      uploadFolderFile(destination: destination);
    }
  }

  uploadFolderFile({String? destination}) async {
    try {
      final uploadTask = FirebaseStorage.instance
          .ref(destination)
          .child('folders/')
          .putFile(file!);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      uploadFolderDownloadUrl(downloadUrl: downloadUrl);
      log('File Folder uploaded: $downloadUrl', name: downloadUrl);
    } on FirebaseException catch (e) {
      log('$e', name: 'Error while uploading the files');
    }
  }

  uploadFolderDownloadUrl({String? downloadUrl}) {
    log("you have uploaded the file");
    FirebaseFirestore.instance
        .collection("Users")
        .doc(currentuser!.email)
        .collection("Folders")
        .doc(folderName)
        .set(
      {
        "Folder File URL": downloadUrl,
      },
      SetOptions(merge: true),
    );
  }
}

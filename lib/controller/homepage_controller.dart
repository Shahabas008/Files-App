import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_app/model/card_model.dart';
import 'package:file_app/utils/snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePagecontroller extends GetxController {
  RxList<dynamic> cardList = [].obs;
  //function for creating of folders in the homepage
  createFolder({String? title, BuildContext? context, Function()? navigateto}) {
    cardList.add(CardModel(context!, () => navigateto, title!));
  }

  // function to Pick images for important doc section
  File? file;
  User? user;
  String downloadUrl = "";

  //picking and uploading the adhaar files
  pickAdhaarFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null && result.files.isNotEmpty) {
      file = File(result.files.single.path!);
      final fileName = Path.basename(file!.path);
      final destination = 'Files/$fileName';
      uploadAdhaarFile(destination: destination);
    }
  }

  uploadAdhaarFile({String? destination}) async {
    try {
      final uploadTask = FirebaseStorage.instance
          .ref(destination)
          .child('Files/')
          .putFile(file!);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      uploadAdhaarDownloadUrl(downloadUrl: downloadUrl);
      log('File Adhaar uploaded: $downloadUrl', name: downloadUrl);
    } on FirebaseException catch (e) {
      log('$e', name: 'Error while uploading the files');
    }
  }

  uploadAdhaarDownloadUrl({String? downloadUrl}) {
    User? curentuser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection("Users").doc(curentuser!.email).set({
      "Adhaar File URL": downloadUrl,
    }, SetOptions(merge: true));
  }

  //picking and uploading the PAN files

  pickPanFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null && result.files.isNotEmpty) {
      file = File(result.files.single.path!);
      final fileName = Path.basename(file!.path);
      final destination = 'Files/$fileName';
      uploadPanFile(destination: destination);
    }
  }

  uploadPanFile({String? destination}) async {
    try {
      final uploadTask = FirebaseStorage.instance
          .ref(destination)
          .child('Files/')
          .putFile(file!);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      uploadPanDownloadUrl(downloadUrl: downloadUrl);
      log('File License uploaded: $downloadUrl', name: downloadUrl);
    } on FirebaseException catch (e) {
      log('$e', name: 'Error while uploading the files');
    }
  }

  uploadPanDownloadUrl({String? downloadUrl}) {
    User? curentuser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection("Users").doc(curentuser!.email).set({
      "PAN File URL": downloadUrl,
    }, SetOptions(merge: true));
  }

//picking and uploading the License files

  pickLicenseFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null && result.files.isNotEmpty) {
      file = File(result.files.single.path!);
      final fileName = Path.basename(file!.path);
      final destination = 'Files/$fileName';
      uploadLicenseFile(destination: destination);
    }
  }

  uploadLicenseFile({String? destination}) async {
    try {
      final uploadTask = FirebaseStorage.instance
          .ref(destination)
          .child('Files/')
          .putFile(file!);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      uploadLicenseDownloadUrl(downloadUrl: downloadUrl);
      log('File License uploaded: $downloadUrl', name: downloadUrl);
    } on FirebaseException catch (e) {
      log('$e', name: 'Error while uploading the files');
    }
  }

  uploadLicenseDownloadUrl({String? downloadUrl}) {
    User? curentuser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection("Users").doc(curentuser!.email).set({
      "License File URL": downloadUrl,
    }, SetOptions(merge: true));
  }
}

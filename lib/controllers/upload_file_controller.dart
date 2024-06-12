import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class UploadFileController extends GetxController{

  //PlatformFile? pickedFile;
  //UploadTask? uploadTask;

  Rx<dynamic> pickedFile = Rx<dynamic>(null);
  Rx<dynamic> uploadTask = Rx<dynamic>(null);
  RxString urlImage = RxString("");
  RxDouble progress = RxDouble(0.0);

  Future uploadFile() async {
    final path = 'files/${pickedFile!.value.name}';
    final file = File(pickedFile!.value.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask.value = ref.putFile(file);

    final snapshot = await uploadTask!.value.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link: $urlDownload');
    urlImage.value = urlDownload.toString();
    uploadTask.value = null;
    pickedFile.value = null;
    update();
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    pickedFile.value = result.files.first;
    update();
    pickedFile.refresh();
  }

}
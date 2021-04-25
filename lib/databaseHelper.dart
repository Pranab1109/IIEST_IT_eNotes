import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:FirebasePdf/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:file_picker/file_picker.dart';

class DataBaseHelper {
  List<Model> items = [];
  String nameOfFile = '';
  int number;
  static String category;
  final mainReference = FirebaseDatabase.instance.reference().child(category);

  Future getPdfAndUpload() async {
    String fileName = '';
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File file = File(result.files.single.path);
      String fileN = result.paths.toString().split('/')[7];
      fileName = fileN.split('.')[0] + '.pdf';
      savePdf(file.readAsBytesSync(), fileName);
    }

    nameOfFile = fileName;
  }

  savePdf(List<int> asset, String name) async {
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref().child(name);
    firebase_storage.UploadTask uploadTask = ref.putData(asset);
    String url = await (await uploadTask).ref.getDownloadURL();
    documentFileUpload(url);
  }

  String createCryptoRandomString([int length = 32]) {
    final Random _random = Random.secure();
    var values = List<int>.generate(length, (index) => _random.nextInt(256));
    return base64Url.encode(values);
  }

  void documentFileUpload(String url) {
    var data = {
      "PDF": url,
      "FileName": nameOfFile,
    };
    mainReference.child(createCryptoRandomString()).set(data).then((value) {
      getPdfs();
      print("stored successfully");
    });
  }

  void getPdfs() {
    mainReference.once().then((DataSnapshot snapshot) {
      var data = snapshot.value;
      items.clear();
      data.forEach((key, value) {
        Model model = Model(link: value['PDF'], name: value['FileName']);
        items.add(model);
      });

      // setState(() {});
    });
  }
}

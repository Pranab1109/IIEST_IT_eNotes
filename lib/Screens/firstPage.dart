import 'dart:convert';
import 'dart:math';

import 'package:FirebasePdf/Models/model.dart';
import 'package:FirebasePdf/Screens/secondPage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';
import 'dart:io';

class FirstPage extends StatefulWidget {
  final Category category;
  int index;
  FirstPage(this.category, this.index);
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<Model> items = List();
  String nameOfFile = '';
  // Future getPdfAndUpload() async {
  //   String fileName = '';
  //   FilePickerResult result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf'],
  //   );

  //   if (result != null) {
  //     File file = File(result.files.single.path);
  //     String fileN = result.paths.toString().split('/')[7];
  //     fileName = fileN.split('.')[0] + '.pdf';
  //     savePdf(file.readAsBytesSync(), fileName);
  //   }

  //   nameOfFile = fileName;
  // }

  // savePdf(List<int> asset, String name) async {
  //   firebase_storage.Reference ref =
  //       firebase_storage.FirebaseStorage.instance.ref().child(name);
  //   firebase_storage.UploadTask uploadTask = ref.putData(asset);
  //   String url = await (await uploadTask).ref.getDownloadURL();
  //   documentFileUpload(url);
  // }

  // String createCryptoRandomString([int length = 32]) {
  //   final Random _random = Random.secure();
  //   var values = List<int>.generate(length, (index) => _random.nextInt(256));
  //   return base64Url.encode(values);
  // }

  // void documentFileUpload(String url) {
  //   var data = {
  //     "PDF": url,
  //     "FileName": nameOfFile,
  //   };
  //   mainReference.child(createCryptoRandomString()).set(data).then((value) {
  //     getPdfs();
  //     print("stored successfully");
  //   });
  // }

  String fileName;
  void getPdfs() {
    final mainReference = FirebaseDatabase.instance
        .reference()
        .child(widget.category.name)
        .child(widget.category.list[widget.index]);

    mainReference.once().then((DataSnapshot snapshot) {
      var data = snapshot.value;
      items.clear();
      data.forEach((key, value) {
        Model model = Model(link: value['PDF'], name: value['FileName']);
        items.add(model);
      });

      setState(() {});
    });
  }

  @override
  void initState() {
    getPdfs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1a1c20),
      appBar: AppBar(
        title: Text('Firebase Pdf'),
        backgroundColor: Color(0xff1a1c20),
      ),
      body: items.length == 0
          ? Text("Loading")
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: GestureDetector(
                      onTap: () {
                        String passData = items[index].link;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewPdf(),
                              settings: RouteSettings(arguments: passData),
                            ));
                      },
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: AssetImage('assets/art.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(50.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(50.0),
                                  child: Text(items[index].name),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          // String file = await getPdfAndUpload();

          // setState(() {
          //   fileName = file;
          // });
        },
      ),
    );
  }
}

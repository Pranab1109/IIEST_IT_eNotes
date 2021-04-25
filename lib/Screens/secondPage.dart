import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class ViewPdf extends StatefulWidget {
  @override
  _ViewPdfState createState() => _ViewPdfState();
}

class _ViewPdfState extends State<ViewPdf> {
  PDFDocument doc;
  @override
  Widget build(BuildContext context) {
    String data = ModalRoute.of(context).settings.arguments;

    viewNow() async {
      doc = await PDFDocument.fromURL(data).whenComplete(() {
        setState(() {});
      });
    }

    Widget loading() {
      viewNow();
      if (doc == null) {
        return Text('Loading');
      } else {
        return PDFViewer(document: doc);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('Retrieve pdf'),
      ),
      body: doc == null
          ? loading()
          : PDFViewer(
              document: doc,
            ),
    );
  }
}

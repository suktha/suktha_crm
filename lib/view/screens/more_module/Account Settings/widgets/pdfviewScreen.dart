import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:work_Force/Constants/colors.dart';

Future<File> downloadFile(String url, String fileName) async {
  final response = await http.get(Uri.parse(url));
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/$fileName');
  await file.writeAsBytes(response.bodyBytes);
  return file;
}

class PDFScreen extends StatefulWidget {
  final String url;

  PDFScreen({required this.url});

  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  int totalPages = 0;
  int currentPage = 0;
  bool _isReady = false;
  late PDFViewController pdfViewController;
  late File _pdfFile;

  @override
  void initState() {
    super.initState();
    _downloadAndLoadPDF();
  }

  Future<void> _downloadAndLoadPDF() async {
    try {
      _pdfFile = await downloadFile(widget.url, 'downloaded.pdf');
      setState(() {
        _isReady = true;
      });
    } catch (e) {
      print("Error downloading PDF: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("View PDF"),
          titleTextStyle: TextStyle(color: kColorblack, fontWeight: FontWeight.bold, fontSize: 20),
          centerTitle: true,
          backgroundColor: kColorwhite,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: kColorblack,
            ),
          )),
      body: _isReady
          ? Stack(
              children: <Widget>[
                PDFView(
                  filePath: _pdfFile.path,
                  autoSpacing: false,
                  swipeHorizontal: true,
                  pageSnap: false,
                  onRender: (pages) {
                    setState(() {
                      totalPages = pages!;
                    });
                  },
                  onViewCreated: (PDFViewController vc) {
                    pdfViewController = vc;
                  },
                  onPageChanged: (page, total) {
                    setState(() {
                      currentPage = page!;
                    });
                  },
                  onError: (error) {
                    print(error.toString());
                  },
                  onPageError: (page, error) {
                    print('$page: ${error.toString()}');
                  },
                ),
                !_isReady
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

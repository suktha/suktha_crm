import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';


class MyWebView extends StatefulWidget {
  final String url;

  const MyWebView({super.key, required this.url});
  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  GlobalKey _pdfKey = GlobalKey();

  void refreshPdf() {
    setState(() {
      _pdfKey = GlobalKey();
      print("url --${widget.url}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorwhite,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: kColorblack),
        title: Text(
          'Pdf',
          style: TextStyle(color: kColorblack),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: refreshPdf, // Refresh PDF when pressed
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(2.w),
        child: Column(
          children: [
            Expanded(
              key: _pdfKey,
              child: PDF().cachedFromUrl(
                widget.url,
                placeholder: (progress) => Center(
                  child: Text(
                    '$progress %',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
                errorWidget: (error) => Center(
                  child: Text(error.toString()),
                ),
              ),
            ),
            Container(
              height: 7.h,
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 221, 221, 221),
                borderRadius: BorderRadius.circular(3.w),
                boxShadow: kElevationToShadow[2],
              ),
              child: Row(
                children: [
                  Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("Back to App"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

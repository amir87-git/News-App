import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArtViw extends StatefulWidget {
  String blogUrl;
  ArtViw({required this.blogUrl});

  @override
  State<ArtViw> createState() => _ArtViwState();
}

class _ArtViwState extends State<ArtViw> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("Flutter"), Text("News", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)],
        ),
        centerTitle: true,
        elevation: 0.0,
        ),
      body: Container(
      child: WebView(
        initialUrl:widget.blogUrl,
        javaScriptMode: JavaScriptMode.unrestricted,
      ),
      ),
    );
  }
}
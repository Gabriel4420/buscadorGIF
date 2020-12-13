import 'package:flutter/material.dart';
import 'package:share/share.dart';

// ignore: must_be_immutable
class GifPage extends StatefulWidget {
  final Map _gifData;
  GifPage(this._gifData);
  @override
  _GifPageState createState() => _GifPageState(_gifData);
}

class _GifPageState extends State<GifPage> {
  final Map _gifData;
  _GifPageState(this._gifData);

  var colorx = Colors.white;

  void _defaultColorPage() {
    setState(() {
      colorx = Colors.white;
    });
  }

  void _darkColorPage() {
    setState(() {
      colorx = Colors.black87;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorx,
      appBar: AppBar(
        title: Text(_gifData["title"]),
        actions: [
          GestureDetector(
            child: IconButton(
              icon: Icon(Icons.flash_on, color: Colors.white),
              onPressed: () {
                _darkColorPage();
              },
            ),
            onTap: _darkColorPage,
            onDoubleTap: _defaultColorPage,
          ),
          GestureDetector(
              child: IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    Share.share(_gifData['images']['fixed_height']['url']);
                  }))
        ],
      ),
      body: Center(
          child: Image.network(_gifData['images']['fixed_height']['url'])),
    );
  }
}

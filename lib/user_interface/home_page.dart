import 'dart:convert';

import 'package:buscador_gif/user_interface/gif_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

String _search;
int _offset = 0;

class _HomePageState extends State<HomePage> {
  Future<Map> _getGiphys() async {
    http.Response response;

    _search == null || _search.isEmpty
        ? response = await http.get(
            "https://api.giphy.com/v1/gifs/trending?api_key=qTHfd7y7soxpyRHxNsetHewQkJcaauAG&limit=20&rating=g")
        : response = await http.get(
            "https://api.giphy.com/v1/gifs/search?api_key=qTHfd7y7soxpyRHxNsetHewQkJcaauAG&q=$_search&limit=19&offset=$_offset&rating=g&lang=en");
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    _getGiphys();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Image.network(
            'https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif'),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
              onSubmitted: (text) {
                setState(() {
                  _search = text;
                  _offset = 0;
                });
              },
              decoration: InputDecoration(
                  labelText: 'Pesquise Aqui',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      borderSide: BorderSide(
                          color: Colors.white, style: BorderStyle.solid))),
              style: TextStyle(
                  color: Colors.lightGreenAccent[200], fontSize: 18.0)),
        ),
        Expanded(
          child: FutureBuilder(
            future: _getGiphys(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return Container(
                      width: 200.0,
                      height: 200.0,
                      alignment: Alignment.center,
                      child: Center(
                          child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                        strokeWidth: 5.0,
                      )));
                default:
                  if (snapshot.hasError) {
                    return Container(
                      child: Text("Deu Ruim Parça",
                          style: TextStyle(color: Colors.lightGreenAccent)),
                    );
                  } else {
                    return _createGifTable(context, snapshot);
                  }
              }
            },
          ),
        ),
      ]),
    );
  }

  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
        padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10.0),
        itemCount: _getCount(snapshot.data["data"]),
        itemBuilder: (context, index) {
          if (_search == null || index < snapshot.data["data"].length)
            return GestureDetector(
                child: Image.network(
                  snapshot.data["data"][index]["images"]["fixed_height"]["url"],
                  height: 300.0,
                  fit: BoxFit.cover,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              GifPage(snapshot.data["data"][index])));
                },
                onLongPress: (){
                  Share.share(snapshot.data["data"][index]["images"]["fixed_height"]["url"]);
                },
                );
          else
            return Container(
              child: GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.add, color: Colors.lightGreenAccent, size: 70),
                    Text("Carregar Mais...",
                        style: TextStyle(color: Colors.white))
                  ],
                ),
                onTap: () {
                  setState(() {
                    _offset += 19;
                  });
                },
              ),
            );
        });
  }
}

int _getCount(List data) {
  if (_search == null) {
    return data.length;
  } else {
    return data.length + 1;
  }
}

import 'dart:convert';

import 'package:earthquake_app/src/screens/detail.dart';
import 'package:earthquake_app/src/utils/SampleData.dart';
import 'package:earthquake_app/src/widget/QuakeListCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widget/createProgressIndicator.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ListPage();
  }
}

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Map<String, dynamic> _dataUrls = {};
  void fetchSentence() async {
    final response = await http.get(Uri.parse(
        'https://ntool.online/api/earthquakeList'));
    if (response.statusCode == 200) {
      Map<String, dynamic> sentences =
      jsonDecode(utf8.decode(response.bodyBytes));
      Map<String, dynamic> datasUrls = {};
      Map<String, dynamic> datas = {};
      for (String dataUrl in sentences["lists"].toList().reversed) {
        List<String> dataSplit = dataUrl.split("/");
        String fileName = dataSplit[dataSplit.length-1];
        List<String> fileSplit = fileName.split("_");
        datasUrls[fileSplit[2]] = dataUrl;
        if (datasUrls.length > 10) break;
      }
      for (var entry in datasUrls.entries) {
        final response = await http.get(Uri.parse(
            entry.value));
        if (response.statusCode == 200) {
          Map<String, dynamic> data =
          jsonDecode(utf8.decode(response.bodyBytes));
          data["url"] = entry.value;
          datas[entry.key] = data;
        } else {
          throw Exception('Failed to load sentence');
        }
      }
      setState(() {
        _dataUrls = datas;
      });
    } else {
      throw Exception('Failed to load sentence');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSentence();
  }

  bool _longPressFlag = false;
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    if (_dataUrls.isEmpty) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("履歴"),
            elevation: 1,
          ),
          body: createProgressIndicator()
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text("履歴"),
          elevation: 1,
        ),
        body: ListView(
          children: <Widget>[
            for (var urlKey in _dataUrls.keys.toList())
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailScreen(dataUrl: _dataUrls[urlKey]["url"])),
                  );
                },
                onLongPress: () async {
                  _longPressFlag = true;
                  while (_longPressFlag) {
                    _counter++;
                    if (_counter > 5) {
                      setState(() {
                        _dataUrls["int3"] = getSampleInt3();
                        _dataUrls["int4"] = getSampleInt4();
                        _dataUrls["int5-"] = getSampleInt5M();
                        _dataUrls["int5+"] = getSampleInt5S();
                        _dataUrls["int6+"] = getSampleInt6S();
                      });
                    }
                    //目で追える速さで進行させる為待機処理を追加する
                    await Future.delayed(const Duration(milliseconds: 1000));
                  }
                },
                onLongPressEnd: (detail) {
                  setState((){
                    _counter = 0;
                    _longPressFlag = false;
                  });
                },
                child: QuakeListCard(_dataUrls[urlKey]),
              )
          ],
        ),
    );
  }
}
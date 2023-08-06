import 'dart:convert';

import 'package:earthquake_app/src/screens/detail.dart';
import 'package:earthquake_app/src/utils/SampleData.dart';
import 'package:earthquake_app/src/widget/QuakeListCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widget/QuakeEListCard.dart';
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
  List<dynamic> _dataList = [];
  void fetchSentence() async {
    final response = await http.get(Uri.parse(
        'https://earthquake-api-v2.nakn.jp/api/v2/list?limit=10'));
    if (response.statusCode == 200) {
      Map<String, dynamic> sentences =
      jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        _dataList = sentences["items"];
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
    if (_dataList.isEmpty) {
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
            for (var data in _dataList)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailScreen(dataUrl: data["lists"].last["url"])),
                  );
                },
                /*
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
                 */
                child: QuakeEListCard(data),
              )
          ],
        ),
    );
  }
}
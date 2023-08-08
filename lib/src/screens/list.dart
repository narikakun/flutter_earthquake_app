import 'dart:convert';

import 'package:earthquake_app/src/screens/detail.dart';
import 'package:earthquake_app/src/screens/listFilter.dart';
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
  Map<String, dynamic> _dataJson = {};
  String _minInt = "1";
  int _nowPage = 1;

  void fetchList() async {
    final response = await http.get(Uri.parse(
        'https://earthquake-api-v2.nakn.jp/api/v2/list?limit=10&minInt=$_minInt&page=$_nowPage'));
    if (response.statusCode == 200) {
      Map<String, dynamic> dataJson =
      jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        if (_dataJson.isEmpty) {
          _dataJson = dataJson;
        } else {
          _dataJson["items"].addAll(dataJson["items"]);
        }
      });
    } else {
      throw Exception('Failed to load dataJson');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchList();
  }

  @override
  Widget build(BuildContext context) {
    if (_dataJson.isEmpty) {
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
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () async {
              var result = await Navigator.push(
                context,
                  MaterialPageRoute(builder: (context) => ListFilterScreen(minIntStr: _minInt)),
                );
              _minInt = result["minInt"];
              _dataJson = {};
              _nowPage = 1;
              fetchList();
            },
          ),
        ],
      ),
      body: NotificationListener (
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollEndNotification) {
            final before = scrollNotification.metrics.extentBefore;
            final max = scrollNotification.metrics.maxScrollExtent;
            if (before == max) {
              _nowPage++;
              fetchList();
              return true;
            }
          }
          return false;
        },
        child: RefreshIndicator(
          onRefresh: () async {
            _dataJson = {};
            _nowPage = 1;
            fetchList();
          },
          child: ListView(
            children: <Widget>[
              for (var data in _dataJson["items"])
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailScreen(dataUrl: data["lists"].last["url"])),
                    );
                  },
                  child: QuakeEListCard(data),
                )
            ],
          ),
        ),
      ),
    );
  }
}
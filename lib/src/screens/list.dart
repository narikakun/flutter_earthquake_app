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
  List<dynamic> _dataList = [];
  void fetchSentence() async {
    final response = await http.get(Uri.parse(
        'https://earthquake-api-v2.nakn.jp/api/v2/list?limit=10'));
    if (response.statusCode == 200) {
      Map<String, dynamic> dataJson =
      jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        _dataList = dataJson["items"];
      });
    } else {
      throw Exception('Failed to load dataJson');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSentence();
  }

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
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () => {
              Navigator.push(
                context,
                  MaterialPageRoute(builder: (context) => ListFilterScreen()),
                )
              },
            ),
          ],
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
                child: QuakeEListCard(data),
              )
          ],
        ),
    );
  }
}
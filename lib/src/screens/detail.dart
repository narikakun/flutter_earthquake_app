import 'dart:convert';

import 'package:earthquake_app/src/widget/EarthquakeMap.dart';
import 'package:earthquake_app/src/widget/QuakeListCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widget/createProgressIndicator.dart';

class DetailScreen extends StatelessWidget {
  final String dataUrl;

  const DetailScreen({Key? key, required this.dataUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DetailPage(dataUrl: dataUrl);
  }
}

class DetailPage extends StatefulWidget {
  final String dataUrl;

  const DetailPage({Key? key, required this.dataUrl}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Map<String, dynamic> _data = {};
  late final String dataUrl;
  void fetchSentence() async {
    final response = await http.get(Uri.parse(dataUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> sentences =
      jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        _data = sentences;
      });
    } else {
      throw Exception('Failed to load sentence');
    }
  }

  @override
  void initState() {
    super.initState();
    dataUrl = widget.dataUrl;
    fetchSentence();
  }

  @override
  Widget build(BuildContext context) {
    if (_data.isEmpty) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("地震の詳細"),
            elevation: 1,
          ),
          body: createProgressIndicator()
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("地震の詳細"),
        elevation: 1,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          QuakeListCard(_data),
          Expanded(
            child: EarthquakeMap(data: _data),
          ),
        ],
      ),
    );
  }
}
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widget/EarthquakeMap.dart';
import '../widget/QuakeListCard.dart';
import '../widget/createProgressIndicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> _earthquakeData = {};

  late Timer fetchTimer;

  void fetchLastEarthquake() async {
    if (!mounted) {
      fetchTimer.cancel();
      return;
    }
    final response = await http.get(Uri.parse(
        'https://dev.narikakun.net/webapi/earthquake/post_data.json'));
    if (response.statusCode == 200) {
      Map<String, dynamic> sentences =
      jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        _earthquakeData = sentences;
      });
    } else {
      throw Exception('Failed to load sentence');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchLastEarthquake();
    fetchTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      fetchLastEarthquake();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_earthquakeData.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("最新の地震情報"),
          elevation: 1,
        ),
        body: createProgressIndicator()
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("最新の地震情報"),
        elevation: 1,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          QuakeListCard(_earthquakeData),
          Expanded(
            child: EarthquakeMap(data: _earthquakeData),
          ),
        ],
      ),
    );
  }
}
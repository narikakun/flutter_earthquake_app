import 'dart:convert';

import 'package:flutter/material.dart';

class ListFilterScreen extends StatelessWidget {
  const ListFilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ListFilterPage();
  }
}


class ListFilterPage extends StatefulWidget {
  const ListFilterPage({Key? key}) : super(key: key);

  @override
  State<ListFilterPage> createState() => _ListFilterPage();
}

class _ListFilterPage extends State<ListFilterPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("履歴絞り込み画面"),
        elevation: 1,
      ),
      body: const Text("a")
    );
  }
}
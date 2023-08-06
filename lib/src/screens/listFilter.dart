import 'dart:convert';

import 'package:flutter/material.dart';

import '../widget/createProgressIndicator.dart';

class ListFilterScreen extends StatelessWidget {
  final String minIntStr;

  const ListFilterScreen({Key? key, required this.minIntStr}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListFilterPage(minIntStr: minIntStr);
  }
}


class ListFilterPage extends StatefulWidget {
  final String minIntStr;
  const ListFilterPage({Key? key, required this.minIntStr}) : super(key: key);

  @override
  State<ListFilterPage> createState() => _ListFilterPage();
}

enum MinIntCharacter { min1, min2, min3, min4, min5m, min5p, min6m, min6p, min7 }

class _ListFilterPage extends State<ListFilterPage> {
  MinIntCharacter? _minIntCharacter;
  String? minIntStr1;

  @override
  void initState() {
    super.initState();
    minIntStr1 = widget.minIntStr;
  }

  @override
  Widget build(BuildContext context) {
    switch (minIntStr1) {
      case "1":
        _minIntCharacter = MinIntCharacter.min1;
        break;
      case "2":
        _minIntCharacter = MinIntCharacter.min2;
        break;
      case "3":
        _minIntCharacter = MinIntCharacter.min3;
        break;
      case "4":
        _minIntCharacter = MinIntCharacter.min4;
        break;
      case "5m":
        _minIntCharacter = MinIntCharacter.min5m;
        break;
      case "5p":
        _minIntCharacter = MinIntCharacter.min5p;
        break;
      case "6m":
        _minIntCharacter = MinIntCharacter.min6m;
        break;
      case "6p":
        _minIntCharacter = MinIntCharacter.min6p;
        break;
      case "7":
        _minIntCharacter = MinIntCharacter.min7;
        break;
    }
    return WillPopScope(
        onWillPop: () {
        Navigator.pop(context, { "minInt": minIntStr1 });
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("履歴絞り込み画面"),
          elevation: 1,
        ),
        body: Column(
          children: <Widget>[
            ListTile(
              title: const Text('震度1'),
              leading: Radio<MinIntCharacter>(
                value: MinIntCharacter.min1,
                groupValue: _minIntCharacter,
                onChanged: (MinIntCharacter? value) {
                  setState(() {
                    _minIntCharacter = MinIntCharacter.min1;
                    minIntStr1 = "1";
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('震度2'),
              leading: Radio<MinIntCharacter>(
                value: MinIntCharacter.min2,
                groupValue: _minIntCharacter,
                onChanged: (MinIntCharacter? value) {
                  setState(() {
                    _minIntCharacter = MinIntCharacter.min2;
                    minIntStr1 = "2";
                  });
                },
              ),
            ),ListTile(
              title: const Text('震度3'),
              leading: Radio<MinIntCharacter>(
                value: MinIntCharacter.min3,
                groupValue: _minIntCharacter,
                onChanged: (MinIntCharacter? value) {
                  setState(() {
                    _minIntCharacter = MinIntCharacter.min3;
                    minIntStr1 = "3";
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('震度4'),
              leading: Radio<MinIntCharacter>(
                value: MinIntCharacter.min4,
                groupValue: _minIntCharacter,
                onChanged: (MinIntCharacter? value) {
                  setState(() {
                    _minIntCharacter = MinIntCharacter.min4;
                    minIntStr1 = "4";
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('震度5弱'),
              leading: Radio<MinIntCharacter>(
                value: MinIntCharacter.min5m,
                groupValue: _minIntCharacter,
                onChanged: (MinIntCharacter? value) {
                  setState(() {
                    _minIntCharacter = MinIntCharacter.min5m;
                    minIntStr1 = "5m";
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('震度5強'),
              leading: Radio<MinIntCharacter>(
                value: MinIntCharacter.min5p,
                groupValue: _minIntCharacter,
                onChanged: (MinIntCharacter? value) {
                  setState(() {
                    _minIntCharacter = MinIntCharacter.min5p;
                    minIntStr1 = "5p";
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('震度6弱'),
              leading: Radio<MinIntCharacter>(
                value: MinIntCharacter.min6m,
                groupValue: _minIntCharacter,
                onChanged: (MinIntCharacter? value) {
                  setState(() {
                    _minIntCharacter = MinIntCharacter.min6m;
                    minIntStr1 = "6m";
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('震度6強'),
              leading: Radio<MinIntCharacter>(
                value: MinIntCharacter.min6p,
                groupValue: _minIntCharacter,
                onChanged: (MinIntCharacter? value) {
                  setState(() {
                    _minIntCharacter = MinIntCharacter.min6p;
                    minIntStr1 = "6p";
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('震度7'),
              leading: Radio<MinIntCharacter>(
                value: MinIntCharacter.min7,
                groupValue: _minIntCharacter,
                onChanged: (MinIntCharacter? value) {
                  setState(() {
                    _minIntCharacter = MinIntCharacter.min7;
                    minIntStr1 = "7";
                  });
                },
              ),
            ),
          ],
        )
      )
    );
  }
}
import 'package:flutter/material.dart';

import '../utils/ParseIntImage.dart';
import '../utils/timeFormat.dart';

Widget QuakeEListCard(data) {
  String intStr = '${(!data["int"].isEmpty?data["int"]:"不明")}';
  return Container(
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                title: (!data["hypoName"].isEmpty)?Text('発生時間:  ${timeFormat(data["originTime"])}'):Text('発表時間: ${timeFormat(data["lists"]["datetime"])}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('震源地 : ${(!data["hypoName"].isEmpty?data["hypoName"]:"調査中")}'),
                        const SizedBox(
                          width: 20,
                        ),
                        Text('M${(!data["magnitude"].isEmpty?data["magnitude"]:"調査中")}'),
                        const SizedBox(
                          width: 20,
                        ),
                        Text('${(!data["depth"].isEmpty?data["depth"]+"km":"")}'),
                      ],
                    )
                  ],
                ),
              ),
            ),
            CircleAvatar(
              backgroundColor: ParseIntColor(intStr),
              child: Center(
                child: Text(
                  intStr,
                  style: TextStyle(color: ParseTextIntColor(intStr)),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    ),
  );
}
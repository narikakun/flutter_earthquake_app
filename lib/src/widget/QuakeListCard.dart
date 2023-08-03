import 'package:flutter/material.dart';

import '../utils/ParseIntImage.dart';
import '../utils/timeFormat.dart';

Widget QuakeListCard(data) {
  String intStr = '${(!data["Body"]["Intensity"].isEmpty?data["Body"]["Intensity"]["Observation"]["MaxInt"]:"不明")}';
  return Container(
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                title: (!data["Body"]["Earthquake"].isEmpty)?Text('発生時間:  ${timeFormat(data["Body"]["Earthquake"]["OriginTime"])}'):Text('検知時間: ${timeFormat(data["Head"]["TargetDateTime"])}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('震源地 : ${(!data["Body"]["Earthquake"].isEmpty?data["Body"]["Earthquake"]["Hypocenter"]["Name"]:"調査中")}'),
                        const SizedBox(
                          width: 20,
                        ),
                        Text('M${(!data["Body"]["Earthquake"].isEmpty?data["Body"]["Earthquake"]["Magnitude"]:"調査中")}'),
                        const SizedBox(
                          width: 20,
                        ),
                        Text('${(!data["Body"]["Earthquake"].isEmpty?data["Body"]["Earthquake"]["Hypocenter"]["Depth"]+"km":"")}'),
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
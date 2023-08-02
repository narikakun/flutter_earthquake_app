import 'package:flutter/material.dart';

import '../utils/timeFormat.dart';

Widget QuakeListCard(data) {
  return Container(
    child: Card(
      child: ListTile(
        title: (!data["Body"]["Earthquake"].isEmpty)?Text('発生時間:  ${timeFormat(data["Body"]["Earthquake"]["OriginTime"])}'):Text('検知時間: ${timeFormat(data["Head"]["TargetDateTime"])}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('震源地 : ${(!data["Body"]["Earthquake"].isEmpty?data["Body"]["Earthquake"]["Hypocenter"]["Name"]:"調査中")}'),
            Row(
              children: [
                Text('最大震度 : ${(!data["Body"]["Intensity"].isEmpty?data["Body"]["Intensity"]["Observation"]["MaxInt"]:"調査中")}'),
                const SizedBox(
                  width: 20,
                ),
                Text('M${(!data["Body"]["Earthquake"].isEmpty?data["Body"]["Earthquake"]["Magnitude"]:"調査中")}'),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
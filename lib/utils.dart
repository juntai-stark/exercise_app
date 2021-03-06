// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';
import 'package:exercise_dashboard/DB/db_helper.dart';
import 'package:table_calendar/table_calendar.dart';

/// Example event class.
class Event {
  final String title;
  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
var kEvents;

getExerciseDate() {
  kEvents = LinkedHashMap<DateTime, List<Event>>(
    equals: isSameDay,
    hashCode: getHashCode,
  )..addAll(_kEventSource);

  return kEvents ?? [];
}

// 이벤트 추가 방식
var _events = {
  DateTime.utc(2022, 2, 24): [
    Event('운동 시간: 30분'),
    Event('운동 시간: 10분'),
  ],
  DateTime.utc(2022, 2, 23): [
    Event('운동 시간: 10분'),
  ],
};

var _kEventSource;

runEvent() async {
  DBHelper sd = DBHelper();
  //sd.makeList();
  var eventList = await sd.makeList();

  // _eventSource = await Map<DateTime, List<Event>>.fromIterable(
  //   List.generate(3, (index) => index),
  //   key: (index) => DateTime.utc(
  //     eventList[1][index],
  //     eventList[2][index],
  //   ),
  //   value: (item) => List.generate(
  //     1,
  //     ((index) => Event(
  //           eventList[0][index],
  //         )),
  //   ),
  // );

  //print(await _eventSource);

  _kEventSource = Map<DateTime, List<Event>>.fromIterable(
    List.generate(eventList[0].length, (index) => index),
    key: (index) => DateTime.utc(
      eventList[1][index],
      eventList[2][index],
      eventList[3][index],
    ),
    value: (item) => List.generate(
      1,
      (index) => Event(eventList[0][item]),
    ),
  );

  print(_kEventSource);
}

//callEvent() {}

// final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
//     key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
//     value: (item) => List.generate(
//         item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
//   ..addAll({
//     kToday: [
//       Event('Today\'s Event 1'),
//       Event('Today\'s Event 2'),
//     ],
//   });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

import 'package:exercise_dashboard/DB/db_helper.dart';
import 'package:exercise_dashboard/DB/memo.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text(
              "Speed: ",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const Text(
              "3 km/h",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text(
              "Time: ",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const Text(
              "30 mins",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text(
              "Calories: ",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const Text(
              "100 kcal",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            DBHelper sd = DBHelper();
            //데이터 입력 방식
            var fido = Memo(
              title: "13분",
              year: 2022,
              month: 3,
              day: 15,
              date: "2022.03.15",
            );
            sd.insertMemo(fido);
          },
          child: const Text("Save"),
        )
      ],
    );
  }
}

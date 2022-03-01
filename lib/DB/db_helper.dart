import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'memo.dart';

final String TableName = 'memos';

class DBHelper {
  // ignore: prefer_typing_uninitialized_variables
  var _db;

  Future<Database> get database async {
    if (_db != null) return _db;
    _db = openDatabase(
      // 데이터베이스 경로를 지정합니다. 참고: `path` 패키지의 `join` 함수를 사용하는 것이
      // 각 플랫폼 별로 경로가 제대로 생성됐는지 보장할 수 있는 가장 좋은 방법입니다.
      join(await getDatabasesPath(), 'memos.db'),
      // 데이터베이스가 처음 생성될 때, dog를 저장하기 위한 테이블을 생성합니다.
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE memos(title TEXT, year INTEGER, month INTEGER, day INTEGER, date TEXT PRIMARY KEY)",
        );
      },
      // 버전을 설정하세요. onCreate 함수에서 수행되며 데이터베이스 업그레이드와 다운그레이드를
      // 수행하기 위한 경로를 제공합니다.
      version: 1,
    );
    return _db;
  }

  Future<void> insertMemo(Memo memo) async {
    final db = await database;
    // Memo를 올바른 테이블에 추가하세요. 또한
    // `conflictAlgorithm`을 명시할 것입니다. 본 예제에서는
    // 만약 동일한 memo가 여러번 추가되면, 이전 데이터를 덮어쓸 것입니다.
    await db.insert(
      TableName,
      memo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    //toString();
    //print(database);
    //print(db);
    //Memo();
  }

  Future<List<Memo>> memos() async {
    final db = await database;
    //db.delete();

    // 모든 Memo를 얻기 위해 테이블에 질의합니다.
    final List<Map<String, dynamic>> maps = await db.query('memos');

    // List<Map<String, dynamic>를 List<Memo>으로 변환합니다.
    return List.generate(maps.length, (i) {
      return Memo(
        title: maps[i]['title'],
        year: maps[i]['year'],
        month: maps[i]['month'],
        day: maps[i]['day'],
        date: maps[i]['date'],
      );
    });
  }

  Future<void> updateMemo(Memo memo) async {
    final db = await database;

    // 주어진 Memo를 수정합니다.
    await db.update(
      TableName,
      memo.toMap(),
      // Memo의 id가 일치하는 지 확인합니다.
      where: "date = ?",
      // Memo의 id를 whereArg로 넘겨 SQL injection을 방지합니다.
      whereArgs: [memo.date],
    );
  }

  Future<void> deleteMemo(String _date) async {
    final db = await database;

    // 데이터베이스에서 Memo를 삭제합니다.
    await db.delete(
      TableName,
      // 특정 memo를 제거하기 위해 `where` 절을 사용하세요
      where: " date = ?",
      // Memo의 id를 where의 인자로 넘겨 SQL injection을 방지합니다.
      whereArgs: [_date],
    );
  }

  Future makeList() async {
    final db = await database;
    List<String> _temTitle = [];
    List<int> _temYear = [];
    List<int> _temMonth = [];
    List<int> _temDay = [];
    List<List> _temTime = [];
    // 데이터베이스에서 Memo를 삭제합니다.
    final List<Map<String, dynamic>> maps = await db.query('memos');
    maps.forEach((element) {
      _temTitle.add(element["title"]);
      _temYear.add(element["year"]);
      _temMonth.add(element["month"]);
      _temDay.add(element["day"]);
    });
    //print(_temTitle);

    _temTime.add(_temTitle);
    _temTime.add(_temYear);
    //print(_temTime);
    _temTime.add(_temMonth);
    _temTime.add(_temDay);

    return _temTime;
    //print(_temTime);
    //return _temTime;
    //_temTitle;
  }

  Future<bool> searchDB(String date) async {
    final db = await database;
    //db.delete();

    // 모든 Memo를 얻기 위해 테이블에 질의합니다.
    final List<Map<String, dynamic>> maps = await db.query('memos');
    bool _i = false;

    maps.forEach((element) {
      //print(element);
      if (element["year"] == date) {
        _i = true;
        //print("Answer " + element["text"]);
        //bootType!.add("True");
      }
    });
    return _i;
  }

  Future searchDBList(List textList) async {
    List<bool> rememOrNot = [];

    final db = await database;
    //db.delete();
    List _tem = [];

    //print(textList);
    //print(textList.length);
    // 모든 Memo를 얻기 위해 테이블에 질의합니다.
    final List<Map<String, dynamic>> maps = await db.query('memos');
    maps.forEach((element) {
      _tem.add(element["id"]);
      //print("word in List " + element["text"]);

      // if (textList.contains == element["text"]) {
      //   rememOrNot.add(true);
      // } else {
      //   rememOrNot.add(false);
      // }
      //print(textList[_k]);
      //print(textList.length);
      // for (_k = 0; _k < textList.length; _k++) {
      //   if (element["text"] == textList[_k]) {
      //     print(textList[_k]);
      //     rememOrNot!.add(true);
      //     //print("Answer " + element["text"]);
      //     //bootType!.add("True");
      //   } else {
      //     rememOrNot!.add(false);
      //   }
      // }
    });
    int _k = 0;

    for (_k; _k < textList.length; _k++) {
      if ((_tem.contains(textList[_k]))) {
        rememOrNot.add(true);
      } else {
        //print(textList[_k]);
        rememOrNot.add(false);
      }
    }
    //print(rememOrNot);
    return rememOrNot;

    //print(maps[0]["text"]);
    //print(maps[1]);

    // if (maps.isNotEmpty) {
    //   print(maps);
    //   return true;
    // } else {
    //   print(maps);
    //   return false;
    // }
  }
}

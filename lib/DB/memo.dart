class Memo {
  final String? title;
  final int? year;
  final int? month;
  final int? day;
  final String? date;
  //final String? title;
  // final String? imtitle;
  // final String? imYomi;
  // final String? imMean;

  //Memo({this.id, this.title, this.title, this.createTime, this.editTime});
  //title에 운동 내용, datetime에 시간 정리하기
  Memo({
    this.title,
    this.year,
    this.month,
    this.day,
    this.date,

    // this.imtitle,
    // this.imYomi,
    // this.imMean,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      "year": year,
      "month": month,
      "day": day,
      "date": date,
      //'createTime': createTime,
      //'editTime': editTime,
    };
  }

  // 각 memo 정보를 보기 쉽도록 print 문을 사용하여 toString을 구현하세요
  @override
  String toString() {
    return 'Memo{$title, $year, $month, $day}';

    //return 'Memo{id: $id, title: $title, title: $title, createTime: $createTime, editTime: $editTime}';
  }
}

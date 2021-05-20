import 'dart:convert';

class Constant {

  static  List<String> personalIncomeOption = [
    '≤ Rp 5.000.000', '≤ Rp 10.000.000', '≥ Rp 20.000.000'

  ];
  static  List<String> personalGoalOption = [
    'Life Style', 'Saving', 'Equity'
  ];
  static  List<String> personalExpensesOption = [
    '≤ Rp 5.000.000', '≤ Rp 10.000.000', '≥ Rp 20.000.000'
  ];

  static  String dateFormatter(DateTime date) {
    dynamic dayData =
        '{ "1" : "Senin", "2" : "Selasa", "3" : "Rabu", "4" : "Kamis", "5" : "Jumat", "6" : "Sabtu", "7" : "Minggu" }';

    dynamic monthData =
        '{ "1" : "Jan", "2" : "Feb", "3" : "Mar", "4" : "Apr", "5" : "Mei", "6" : "Jun", "7" : "Jul", "8" : "Agu", "9" : "Sep", "10" : "Okt", "11" : "Nov", "12" : "Des" }';

    return json.decode(dayData)['${date.weekday}'] +
        ", " +
        date.day.toString() +
        " " +
        json.decode(monthData)['${date.month}'] +
        " " +
        date.year.toString();
  }

  static String timeFormatter(DateTime time) {
    return time.hour.toString() + ":" + time.minute.toString();
  }
}
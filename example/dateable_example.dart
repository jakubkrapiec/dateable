import 'package:dateable/dateable.dart';

void main() {
  // The most basic constructor.
  final date = Date(21, 3, 2002);

  // You can also use [fromDateTime] constructor...
  if (date == Date.fromDateTime(DateTime(2002, 3, 21))) {
    print('True!');
  }
  // ...or use an extension...
  if (date == DateTime(2002, 3, 21).toDate()) {
    print('Also true!');
  }
  // ...or parse from [String] ddmmyyyy...
  if (date == Date.parse('21032002')) {
    print('This is awesome.');
  }
  // ...or even parse from an ISO8601 [String]!
  if (date == Date.parseIso8601('2002-03-21T14:35:26.896')) {
    print('Very useful.');
  }

  // Do subtractDays and operator- have the same meaning?
  if (Date(1, 1, 2020) - 2 == Date(1, 1, 2020).subtractDays(2)) {
    print('Yes, they do!');
  }
  // The same with addDays and operator+.
  if (Date(31, 12, 2021) + 18 == Date(1, 1, 2022).addDays(17)) {
    print(':)');
  }
  // You can also use operators >, <, >=, <= and ==...
  if (Date(21, 3, 2002) < Date(21, 9, 2004)) {
    print('Spoiler: it is true.');
  }
  // ...as well as isAfter() and isBefore()!
  if (Date(21, 3, 2002).isBefore(Date(21, 9, 2004))) {
    print('This is also true.');
  }
  // Checking if [DateTime] is on the same day as your [Date]
  // is incredibly easy.
  if (DateTime(2002, 3, 11, 14, 6).isTheSameDate(Date(11, 3, 2002))) {
    print('A really nice extension.');
  }
  // Checking if the [Date] is today, tomorrow or yesterday is even easier.
  if (date.isToday() || date.isTomorrow() || date.isYesterday()) {
    print('The star is born.');
  }
  // There are also some nice conversions:
  if (Date(21, 3, 2002).toDateTime() == DateTime(2002, 3, 21)) {
    print('Nice.');
  }
  if (Date(21, 3, 2002).toIso8601() == '2002-03-21T00:00:00.000') {
    print('Nice!');
  }
  if (Date(21, 3, 2002).toString() == '21032002') {
    print('<3');
  }

  // You can enjoy the copyWith function!
  if (Date(11, 3, 2002).copyWith(day: 21, month: 9) == Date(21, 9, 2002)) {
    print('Useful for short, idiomatic mutations.');
  }

  // Finally, due to the implementation of [Comparable] interface,
  // you can sort easily:
  final result = [Date(21, 9, 2004), Date(24, 12, 2006), Date(11, 3, 2002)];
  result.sort((a, b) => a.compareTo(b));
  print(result); // Prints [11032002, 21092004, 24122006]
}

import 'package:dateable/dateable.dart';
import 'package:test/test.dart';

void main() {
  group('Constructor tests', () {
    test('Date.fromDateTime(DateTime) constructor test', () {
      expect(Date.fromDateTime(DateTime(2002, 3, 11)), equals(Date(11, 3, 2002)));
    });
    test('Date(int, int, int) date validation test', () {
      expect(Date(50, 40, 2000), equals(Date(20, 5, 2003)));
    });
    test('Date.parseIso8601(String) constructor test', () {
      expect(Date.parseIso8601('2002-03-11T14:33:21.125'), equals(Date(11, 3, 2002)));
    });
    test('Date.parse(String) constructor test', () {
      expect(Date.parse('11032002'), equals(Date(11, 3, 2002)));
    });
    test('Date.parse(String) constructor exception test', () {
      dynamic exception;
      try {
        Date.parse('1103207X');
      } catch (e) {
        exception = e;
      }
      expect(exception, isFormatException);
    });
    test('today constructor test', () {
      expect(Date.today(), equals(DateTime.now().toDate()));
    });
    test('tomorrow constructor test', () {
      expect(Date.tomorrow(), equals(DateTime.now().add(const Duration(days: 1)).toDate()));
    });
    test('yesterday constructor test', () {
      expect(Date.yesterday(), equals(DateTime.now().subtract(const Duration(days: 1)).toDate()));
    });
  });
  group('Comparision tests', () {
    test('compareTo(Date) test: negative', () {
      expect(Date(11, 3, 2002).compareTo(Date(21, 9, 2004)), equals(-1));
    });
    test('compareTo(Date) test: zero', () {
      expect(Date(11, 3, 2002).compareTo(Date(11, 3, 2002)), equals(0));
    });
    test('compareTo(Date) test: positive', () {
      expect(Date(21, 9, 2004).compareTo(Date(11, 3, 2002)), equals(1));
    });
    test('hashCode equality test', () {
      expect(Date(11, 3, 2002).hashCode, equals(Date(11, 3, 2002).hashCode));
    });
    test('operator== equality test', () {
      expect(Date(11, 3, 2002) == Date(11, 3, 2002), equals(true));
    });
    test('operator== inequality test', () {
      expect(Date(11, 3, 2002) == Date(21, 9, 2004), equals(false));
    });
    test('operator> positive test', () {
      expect(Date(21, 9, 2004) > Date(11, 3, 2002), equals(true));
    });
    test('operator> negative test', () {
      expect(Date(11, 3, 2002) > Date(21, 9, 2004), equals(false));
    });
    test('operator< positive test', () {
      expect(Date(11, 3, 2002) < Date(21, 9, 2004), equals(true));
    });
    test('operator< negative test', () {
      expect(Date(21, 9, 2004) < Date(11, 2, 2002), equals(false));
    });
    test('operator>= positive test', () {
      expect(Date(11, 3, 2002) >= Date(11, 3, 2002), equals(true));
    });
    test('operator>= negative test', () {
      expect(Date(11, 3, 2002) >= Date(21, 9, 2004), equals(false));
    });
    test('operator<= positive test', () {
      expect(Date(11, 3, 2002) <= Date(21, 9, 2004), equals(true));
    });
    test('operator<= negative test', () {
      expect(Date(21, 9, 2004) <= Date(11, 3, 2002), equals(false));
    });
    test('isBefore(Date) positive test', () {
      expect(Date(11, 3, 2002).isBefore(Date(21, 9, 2004)), equals(true));
    });
    test('isBefore(Date) negative test,', () {
      expect(Date(11, 3, 2002).isBefore(Date(11, 3, 2002)), equals(false));
    });
    test('isAfter(Date) positive test', () {
      expect(Date(21, 9, 2004).isAfter(Date(11, 3, 2002)), equals(true));
    });
    test('isAfter(Date) negative test', () {
      expect(Date(11, 3, 2002).isAfter(Date(11, 3, 2002)), equals(false));
    });
    test('copyWith test', () {
      expect(Date(11, 3, 2002).copyWith(day: 21, month: 9), equals(Date(21, 9, 2002)));
    });
    test('isTheSameDate(Date) DateTime extension positive test', () {
      expect(DateTime(2002, 3, 11, 14, 32, 56).isTheSameDate(Date(11, 3, 2002)), equals(true));
    });
    test('isTheSameDate(Date) DateTime extension negative test', () {
      expect(DateTime(2004, 9, 21, 18, 26).isTheSameDate(Date(11, 3, 2002)), equals(false));
    });
    test('isTheSameDate(Date) positive test', () {
      expect(Date(11, 3, 2002).isTheSameDate(Date(11, 3, 2002)), equals(true));
    });
    test('isTheSameDate(Date) negative test', () {
      expect(Date(11, 3, 2002).isTheSameDate(Date(21, 9, 2004)), equals(false));
    });
    test('isToday() positive test', () {
      expect(DateTime.now().toDate().isToday(), equals(true));
    });
    test('isToday() negative test', () {
      expect(DateTime.now().add(const Duration(days: 1)).toDate().isToday(), equals(false));
    });
    test('isTomorrow() positive test', () {
      expect(DateTime.now().add(const Duration(days: 1)).toDate().isTomorrow(), equals(true));
    });
    test('isTomorrow() negative test', () {
      expect(DateTime.now().toDate().isTomorrow(), equals(false));
    });
    test('isYesterday() positive test', () {
      expect(DateTime.now().subtract(const Duration(days: 1)).toDate().isYesterday(), equals(true));
    });
    test('isYesterday() negative test', () {
      expect(DateTime.now().toDate().isYesterday(), equals(false));
    });
  });
  group('Conversion tests', () {
    test('toDateTime() test', () {
      expect(Date(11, 3, 2002).toDateTime(), equals(DateTime(2002, 3, 11)));
    });
    test('toIso8601() test', () {
      expect(Date(11, 3, 2002).toIso8601(), equals('2002-03-11T00:00:00.000'));
    });
    test('toString() test', () {
      expect(Date(2, 3, 104).toString(), equals('02030104'));
    });
    test('toDate() DateTime extension test', () {
      expect(DateTime(2002, 3, 11).toDate(), equals(Date(11, 3, 2002)));
    });
  });
  group('Addition and subtraction tests', () {
    test('operator+ test', () {
      expect(Date(29, 02, 2020) + 1, equals(Date(1, 3, 2020)));
    });
    test('operator- test', () {
      expect(Date(1, 1, 2020) - 1, equals(Date(31, 12, 2019)));
    });
    test('addDays(int) test', () {
      expect(Date(29, 02, 2020).addDays(3), equals(Date(3, 3, 2020)));
    });
    test('subtractDays(int) test', () {
      expect(Date(7, 6, 2020).subtractDays(7), equals(Date(31, 5, 2020)));
    });
  });
}

import 'package:dateable/dateable.dart';
import 'package:test/test.dart';

void main() {
  group('Null checks', () {
    test('fromDateTime constructor null check test', () {
      expect(() {
        Date.fromDateTime(null);
      }, throwsA(isA<AssertionError>()));
    });
    test('Default constructor null check test: day', () {
      expect(() {
        Date(null, 3, 2002);
      }, throwsA(isA<AssertionError>()));
    });
    test('Default constructor null check test: month', () {
      expect(() {
        Date(11, null, 2002);
      }, throwsA(isA<AssertionError>()));
    });
    test('Default constructor null check test: year', () {
      expect(() {
        Date(11, 3, null);
      }, throwsA(isA<AssertionError>()));
    });
    test('parseIso8601 conctructor null check test', () {
      expect(() {
        Date.parseIso8601(null);
      }, throwsA(isA<AssertionError>()));
    });
    test('parse conctructor null check test', () {
      expect(() {
        Date.parse(null);
      }, throwsA(isA<AssertionError>()));
    });
    test('subtractDays method null check test', () {
      expect(() {
        Date(11, 3, 2002).subtractDays(null);
      }, throwsA(isA<AssertionError>()));
    });
    test('addDays method null check test', () {
      expect(() {
        Date(11, 3, 2002).addDays(null);
      }, throwsA(isA<AssertionError>()));
    });
    test('operator+ null check test', () {
      expect(() {
        Date(11, 3, 2002) + null;
      }, throwsA(isA<AssertionError>()));
    });
    test('operator- null check test', () {
      expect(() {
        Date(11, 3, 2002) - null;
      }, throwsA(isA<AssertionError>()));
    });
    test('operator> null check test', () {
      expect(() {
        Date(11, 3, 2002) > null;
      }, throwsA(isA<AssertionError>()));
    });
    test('operator< null check test', () {
      expect(() {
        Date(11, 3, 2002) < null;
      }, throwsA(isA<AssertionError>()));
    });
    test('operator>= null check test', () {
      expect(() {
        Date(11, 3, 2002) >= null;
      }, throwsA(isA<AssertionError>()));
    });
    test('operator<= null check test', () {
      expect(() {
        Date(11, 3, 2002) <= null;
      }, throwsA(isA<AssertionError>()));
    });
    test('isBefore method null check test', () {
      expect(() {
        Date(11, 3, 2002).isBefore(null);
      }, throwsA(isA<AssertionError>()));
    });
    test('isTheSameDate method null check test', () {
      expect(() {
        Date(11, 3, 2002).isTheSameDate(null);
      }, throwsA(isA<AssertionError>()));
    });
    test('format method null check test', () {
      expect(() {
        Date(11, 3, 2002).format(null);
      }, throwsA(isA<AssertionError>()));
    });
    test('isTheSameDate DateTime extension null check test', () {
      expect(() {
        DateTime(2002, 3, 11).isTheSameDate(null);
      }, throwsA(isA<AssertionError>()));
    });
  });
}

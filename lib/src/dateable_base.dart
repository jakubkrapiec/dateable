import 'package:meta/meta.dart';

/// A class that stores and manages day, month and year.
@immutable
class Date implements Comparable<Date> {
  /// Converts a [DateTime] to a [Date].
  Date.fromDateTime(DateTime dateTime) : _date = _truncateTimeOfDay(dateTime);

  /// Returns [DateTime] object with the date of [this] and time values at 00:00.
  DateTime toDateTime() {
    return _date;
  }

  /// Returns [0] if [this] is at the same date as [other], [1] if [this] is
  /// after [other] and [-1] if [this] is before [other].
  @override
  int compareTo(Date other) {
    if (this == other) {
      return 0;
    } else {
      if (_date.isBefore(other.toDateTime())) {
        return -1;
      } else {
        return 1;
      }
    }
  }

  static DateTime _truncateTimeOfDay(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  /// Creates a [Date] object from day, month and year values.
  /// Performs validation.
  Date(int day, int month, int year) : _date = DateTime(year, month, day);

  /// Parses given [String] to a new [Date] object. Besides ISO 8601 works with
  /// every format of [String] that [DateTime.parse] would work with.
  /// Performs validation.
  Date.parseIso8601(String dateString)
      : _date = _truncateTimeOfDay(DateTime.parse(dateString));

  /// Returns an ISO8601 [String] representing [this].
  /// ISO8601 in this case means: yyyy-mm-ddT00:00:00.000000
  String toIso8601() {
    return _date.toIso8601String();
  }

  final DateTime _date;

  /// Parses [String] to [Date] object. [String] must be formatted as ddmmyyyy.
  /// Performs validation. Throws [FormatException] when argument contains non-numbers.
  Date.parse(String dateString)
      : _date = DateTime(
            int.parse(dateString.substring(4, 8)),
            int.parse(dateString.substring(2, 4)),
            int.parse(dateString.substring(0, 2)));

  /// Returns a new [Date] with given amount of days subtracted from [this].
  Date subtractDays(int days) {
    return _date.subtract(Duration(days: days)).toDate();
  }

  /// Returns a new [Date] with given amount of days added to [this].
  Date addDays(int days) {
    return _date.add(Duration(days: days)).toDate();
  }

  /// Returns a new [Date] with given amount of days added to [this].
  Date operator +(int days) {
    return addDays(days);
  }

  /// Returns a new [Date] with given amount of days subtracted from [this].
  Date operator -(int days) {
    return subtractDays(days);
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  bool operator ==(dynamic other) {
    return other is Date &&
        other.day == _date.day &&
        other.month == _date.month &&
        other.year == _date.year;
  }

  /// Checks if [this] is after [other].
  bool operator >(Date other) {
    return _date.isAfter(other.toDateTime());
  }

  /// Checks if [this] is before [other].
  bool operator <(Date other) {
    return _date.isBefore(other.toDateTime());
  }

  /// Checks if [this] is after or at the same day as [other].
  bool operator >=(Date other) {
    return this == other || this > other;
  }

  /// Checks if [this] is before or at the same day as [other].
  bool operator <=(Date other) {
    return this == other || this < other;
  }

  /// Checks if [this] is before [other].
  bool isBefore(Date other) {
    return this < other;
  }

  /// Checks if [this] is after [other].
  bool isAfter(Date other) {
    return this > other;
  }

  /// Checks if [this] is the same date as [other].
  bool isTheSameDate(Date other) {
    return _date.isTheSameDate(other);
  }

  /// Returns day of the date represented by this object. Always in range [1; 31].
  int get day => _date.day;

  /// Returns month of the date represented by this object. Always in range [1; 12].
  int get month => _date.month;

  /// Returns year of the date represented by this object.
  int get year => _date.year;

  /// Returns this [Date]'s object representations as [String], with
  /// format ddmmyyyy.
  @override
  String toString() {
    var day = _date.day.toString();
    var month = _date.month.toString();
    var year = _date.year.toString();
    if (day.length == 1) {
      day = '0$day';
    }
    if (month.length == 1) {
      month = '0$month';
    }
    while (year.length < 4) {
      year = '0$year';
    }
    return '$day$month$year';
  }

  /// Returns new [Date] modified with given input.
  Date copyWith({int day, int month, int year}) {
    return Date(day ?? _date.day, month ?? _date.month, year ?? _date.year);
  }
}

/// A set of extensions to work with [DateTime]s more seamlessly.
extension DateExtensions on DateTime {
  /// Converts [this] to a corresponding [Date] object.
  Date toDate() {
    return Date.fromDateTime(this);
  }

  /// Checks is [this] is on the same date as the [Date] in an argument.
  bool isTheSameDate(Date date) {
    return toDate() == date;
  }
}

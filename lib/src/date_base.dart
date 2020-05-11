import 'package:meta/meta.dart';

/// A class that stores and manages day, month and year.
@immutable
class Date implements Comparable<Date> {
  /// Converts a [DateTime] to a [Date].
  Date.fromDateTime(DateTime dateTime)
      : _day = dateTime.day,
        _month = dateTime.month,
        _year = dateTime.year;

  /// Returns [DateTime] object with the date of [this] and time values at 00:00.
  DateTime toDateTime() {
    return DateTime(_year, _month, _day);
  }

  /// Returns [0] if [this] is at the same date as [other], [1] if [this] is
  /// after [other] and [-1] if [this] is before [other].
  @override
  int compareTo(Date other) {
    if (this == other) {
      return 0;
    } else {
      if (toDateTime().isBefore(other.toDateTime())) {
        return -1;
      } else {
        return 1;
      }
    }
  }

  /// Creates a [Date] object from day, month and year values.
  /// Performs validation.
  Date(int day, int month, int year)
      : _day = DateTime(year, month, day).day,
        _month = DateTime(year, month, day).month,
        _year = DateTime(year, month, day).year;

  /// Parses given [String] to a new [Date] object. Besides ISO 8601 works with
  /// every format of [String] that [DateTime.parse] would work with.
  /// Performs validation.
  Date.parseIso8601(String dateString)
      : _day = DateTime.parse(dateString).day,
        _month = DateTime.parse(dateString).month,
        _year = DateTime.parse(dateString).year;

  /// Returns an ISO8601 [String] representing [this].
  /// ISO8601 in this case means: yyyy-mm-ddT00:00:00.000000
  String toIso8601() {
    return toDateTime().toIso8601String();
  }

  final int _day, _month, _year;

  /// Parses [String] to [Date] object. [String] must be formatted as ddmmyyyy.
  /// Performs validation. Throws [FormatException] when argument contains non-numbers.
  Date.parse(String dateString)
      : _day = DateTime(
                int.parse(dateString.substring(4, 8)),
                int.parse(dateString.substring(2, 4)),
                int.parse(dateString.substring(0, 2)))
            .day,
        _month = DateTime(
                int.parse(dateString.substring(4, 8)),
                int.parse(dateString.substring(2, 4)),
                int.parse(dateString.substring(0, 2)))
            .month,
        _year = DateTime(
                int.parse(dateString.substring(4, 8)),
                int.parse(dateString.substring(2, 4)),
                int.parse(dateString.substring(0, 2)))
            .year;

  /// Returns a new [Date] with given amount of days subtracted from [this].
  Date subtractDays(int days) {
    return toDateTime().subtract(Duration(days: days)).toDate();
  }

  /// Returns a new [Date] with given amount of days added to [this].
  Date addDays(int days) {
    return toDateTime().add(Duration(days: days)).toDate();
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
        other.day == _day &&
        other.month == _month &&
        other.year == _year;
  }

  /// Checks if [this] is after [other].
  bool operator >(Date other) {
    return toDateTime().isAfter(other.toDateTime());
  }

  /// Checks if [this] is before [other].
  bool operator <(Date other) {
    return toDateTime().isBefore(other.toDateTime());
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

  /// Returns day of the date represented by this object. Always in range [1; 31].
  int get day => _day;

  /// Returns month of the date represented by this object. Always in range [1; 12].
  int get month => _month;

  /// Returns year of the date represented by this object.
  int get year => _year;

  /// Returns this [Date]'s object representations as [String], with
  /// format ddmmyyyy.
  @override
  String toString() {
    var day = _day.toString();
    var month = _month.toString();
    var year = _year.toString();
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
}

/// A set of extensions to work with [DateTime]s more seamlessly.
extension DateExtensions on DateTime {
  /// Converts [this] to a corresponding [Date] object.
  Date toDate() {
    return Date.fromDateTime(this);
  }
}

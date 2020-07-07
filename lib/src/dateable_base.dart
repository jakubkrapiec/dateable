import 'package:meta/meta.dart';

/// A class that stores and manages day, month and year.
@immutable
class Date implements Comparable<Date> {
  /// Converts a [DateTime] to a [Date].
  /// [dateTime] must not be [null].
  Date.fromDateTime(final DateTime dateTime)
      : assert(dateTime != null),
        _date = _truncateTimeOfDay(dateTime);

  /// Returns [DateTime] object with the date of [this] and time values at 00:00.
  DateTime toDateTime() {
    return _date;
  }

  /// Returns [0] if [this] is at the same date as [other], [1] if [this] is
  /// after [other] and [-1] if [this] is before [other].
  @override
  int compareTo(final Date other) {
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

  static DateTime _truncateTimeOfDay(final DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  /// Creates a [Date] object from day, month and year values.
  /// Performs validation. [day], [month] and [year] must not be [null].
  Date(final int day, final int month, final int year)
      : assert(day != null),
        assert(month != null),
        assert(year != null),
        _date = DateTime(year, month, day);

  /// Parses given [String] to a new [Date] object. Besides ISO 8601 works with
  /// every format of [String] that [DateTime.parse] would work with.
  /// Performs validation. Throws [FormatException] when the input can't be parsed.
  /// [dateString] must not be [null].
  Date.parseIso8601(final String dateString)
      : assert(dateString != null),
        _date = _truncateTimeOfDay(DateTime.parse(dateString));

  /// Returns an ISO8601 [String] representing [this].
  /// ISO8601 in this case means: yyyy-mm-ddT00:00:00.000000
  String toIso8601() {
    return _date.toIso8601String();
  }

  final DateTime _date;

  /// Parses [String] to [Date] object. [String] must be formatted as ddmmyyyy.
  /// Performs validation. Throws [FormatException] when argument contains non-numbers.
  /// [dateString] must not be null.
  Date.parse(final String dateString)
      : assert(dateString != null),
        _date = DateTime(int.parse(dateString.substring(4, 8)), int.parse(dateString.substring(2, 4)), int.parse(dateString.substring(0, 2)));

  /// Returns a new [Date] with given amount of days subtracted from [this].
  /// [days] can be negative, in this case addition will happen. [days] must not be [null].
  Date subtractDays(final int days) {
    assert(days != null);
    return _date.subtract(Duration(days: days)).toDate();
  }

  /// Returns a new [Date] with given amount of days added to [this].
  /// [days] can be negative, in this case subtraction will happen. [days] must not be [null].
  Date addDays(final int days) {
    assert(days != null);
    return _date.add(Duration(days: days)).toDate();
  }

  /// Returns a new [Date] with given amount of days added to [this].
  /// [days] can be negative, in this case subtraction will happen. [days] must not be [null].
  Date operator +(final int days) {
    assert(days != null);
    return addDays(days);
  }

  /// Returns a new [Date] with given amount of days subtracted from [this].
  /// [days] can be negative, in this case addition will happen. [days] must not be [null].
  Date operator -(final int days) {
    assert(days != null);
    return subtractDays(days);
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  bool operator ==(final dynamic other) {
    return other is Date && other.day == _date.day && other.month == _date.month && other.year == _date.year;
  }

  /// Checks if [this] is after [other].
  /// [other] must not be [null].
  bool operator >(final Date other) {
    assert(other != null);
    return _date.isAfter(other.toDateTime());
  }

  /// Checks if [this] is before [other].
  /// [other] must not be [null].
  bool operator <(final Date other) {
    assert(other != null);
    return _date.isBefore(other.toDateTime());
  }

  /// Checks if [this] is after or at the same day as [other].
  /// [other] must not be [null].
  bool operator >=(final Date other) {
    assert(other != null);
    return this == other || this > other;
  }

  /// Checks if [this] is before or at the same day as [other].
  /// [other] must not be [null].
  bool operator <=(final Date other) {
    assert(other != null);
    return this == other || this < other;
  }

  /// Checks if [this] is before [other].
  /// [other] must not be [null].
  bool isBefore(final Date other) {
    assert(other != null);
    return this < other;
  }

  /// Checks if [this] is after [other].
  /// [other] must not be [null].
  bool isAfter(final Date other) {
    assert(other != null);
    return this > other;
  }

  /// Checks if [this] is the same date as [other].
  /// [other] must not be [null].
  bool isTheSameDate(final Date other) {
    assert(other != null);
    return _date.isTheSameDate(other);
  }

  /// Returns today's date.
  Date.today() : _date = _truncateTimeOfDay(DateTime.now());

  /// Returns tomorrow's date.
  Date.tomorrow() : _date = _truncateTimeOfDay(DateTime.now().add(Duration(days: 1)));

  /// Returns yesterday's date.
  Date.yesterday() : _date = _truncateTimeOfDay(DateTime.now().subtract(Duration(days: 1)));

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
    return '${_modifyLength(day, 2)}${_modifyLength(month, 2)}${_modifyLength(year, 4)}';
  }

  String _modifyLength(final String digits, final int designatedLength) {
    final difference = designatedLength - digits.length;
    if (difference < 0) {
      return digits.substring(difference.abs());
    } else {
      return ('0' * difference) + digits;
    }
  }

  /// Returns new [Date] modified with given input.
  Date copyWith({final int day, final int month, final int year}) {
    return Date(day ?? _date.day, month ?? _date.month, year ?? _date.year);
  }

  /// Checks if [this] is today.
  bool isToday() {
    return _date.isTheSameDate(DateTime.now().toDate());
  }

  /// Checks if [this] is yesterday.
  bool isYesterday() {
    return _date.isTheSameDate(DateTime.now().toDate() - 1);
  }

  /// Checks if [this] is tomorrow.
  bool isTomorrow() {
    return _date.isTheSameDate(DateTime.now().toDate() + 1);
  }

  /// Formats [this] with a given input.
  /// I.e. to get the [String] `"11-03-2002"`, you want to call `Date(11, 3, 2002).format([dd, '-', mm, '-', yyyy])`.
  /// Available date modifiers are:
  /// * yyyy - 4 digit year, i.e. 2002.
  /// * yy - 2 digit year, i.e. 02.
  /// * mm - 2 digit month, i.e. 03.
  /// * dd - 2 digit day, i.e. 11.
  ///
  /// Everything else will be left without change.
  /// You can use all of them both as "dd" and dd.
  /// [formats] and all of its content must not be [null].
  String format(final List<String> formats) {
    assert(formats != null);
    assert(!formats.contains(null));
    final result = StringBuffer();
    for (final format in formats) {
      switch (format) {
        case 'yyyy':
          result.write(_modifyLength(_date.year.toString(), 4));
          break;
        case 'yy':
          result.write(_modifyLength(_date.year.toString(), 2));
          break;
        case 'dd':
          result.write(_modifyLength(_date.day.toString(), 2));
          break;
        case 'mm':
          result.write(_modifyLength(_date.month.toString(), 2));
          break;
        default:
          result.write(format);
          break;
      }
    }
    return result.toString();
  }
}

/// 2 digit month representation, i.e. 03.
const String mm = 'mm';

/// 2 digit day representation, i.e. 11.
const String dd = 'dd';

///2 digit year representation, i.e. 02.
const String yy = 'yy';

/// 4 digit year representation, i.e. 2002.
const String yyyy = 'yyyy';

/// A set of extensions to work with [DateTime]s more seamlessly.
extension DateExtensions on DateTime {
  /// Converts [this] to a corresponding [Date] object.
  Date toDate() {
    return Date.fromDateTime(this);
  }

  /// Checks is [this] is on the same date as [other].
  /// [other] must not be [null].
  bool isTheSameDate(final Date other) {
    assert(other != null);
    return toDate() == other;
  }
}

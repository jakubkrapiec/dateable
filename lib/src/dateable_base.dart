import 'package:meta/meta.dart';

/// A class that stores and manages day, month and year.
@immutable
class Date implements Comparable<Date> {
  /// Converts a [DateTime] to a [Date].
  Date.fromDateTime(final DateTime dateTime)
      : _date = _truncateTimeOfDay(dateTime);

  /// Returns [DateTime] object with the date of [this] and time values at 00:00.
  DateTime toDateTime() => _date;

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

  /// Get rid of the given [DateTime]'s time of day data, leaving it all zeroes.
  static DateTime _truncateTimeOfDay(final DateTime dateTime) =>
      DateTime(dateTime.year, dateTime.month, dateTime.day);

  /// Creates a [Date] object from day, month and year values. Performs validation.
  Date(final int day, final int month, final int year)
      : _date = DateTime(year, month, day);

  /// Parses given [String] to a new [Date] object. Besides ISO 8601 works with
  /// every format of [String] that [DateTime.parse] would work with.
  /// Performs validation. Throws [FormatException] when the input can't be parsed.
  Date.parseIso8601(final String dateString)
      : _date = _truncateTimeOfDay(DateTime.parse(dateString));

  /// Returns an ISO8601 [String] representing [this].
  /// ISO8601 in this case means: yyyy-mm-ddT00:00:00.000000
  String toIso8601() => _date.toIso8601String();

  /// The [DateTime] object holding the state of [this].
  final DateTime _date;

  /// Parses [String] to [Date] object. [String] must be formatted as ddmmyyyy.
  /// Performs validation. Throws [FormatException] when argument contains non-numbers.
  Date.parse(final String dateString)
      : _date = DateTime(
            int.parse(dateString.substring(4, 8)),
            int.parse(dateString.substring(2, 4)),
            int.parse(dateString.substring(0, 2)));

  /// Returns a new [Date] with given amount of days subtracted from [this].
  /// [days] can be negative, in this case addition will happen.
  Date subtractDays(final int days) =>
      _date.subtract(Duration(days: days)).toDate();

  /// Returns a new [Date] with given amount of days added to [this].
  /// [days] can be negative, in this case subtraction will happen.
  Date addDays(final int days) => _date.add(Duration(days: days)).toDate();

  /// Returns a new [Date] with given amount of days added to [this].
  /// [days] can be negative, in this case subtraction will happen.
  Date operator +(final int days) => addDays(days);

  /// Returns a new [Date] with given amount of days subtracted from [this].
  /// [days] can be negative, in this case addition will happen.
  Date operator -(final int days) => subtractDays(days);

  @override
  int get hashCode => toString().hashCode;

  @override
  bool operator ==(final dynamic other) =>
      other is Date &&
      other.day == _date.day &&
      other.month == _date.month &&
      other.year == _date.year;

  /// Checks if [this] is after [other].
  bool operator >(final Date other) => _date.isAfter(other.toDateTime());

  /// Checks if [this] is before [other].
  bool operator <(final Date other) => _date.isBefore(other.toDateTime());

  /// Checks if [this] is after or at the same day as [other].
  bool operator >=(final Date other) => this == other || this > other;

  /// Checks if [this] is before or at the same day as [other].
  bool operator <=(final Date other) => this == other || this < other;

  /// Checks if [this] is before [other].
  bool isBefore(final Date other) => this < other;

  /// Checks if [this] is after [other].
  bool isAfter(final Date other) => this > other;

  /// Checks if [this] is the same date as [other].
  bool isTheSameDate(final Date other) => _date.isTheSameDate(other);

  /// Returns today's date.
  Date.today() : _date = _truncateTimeOfDay(DateTime.now());

  /// Returns tomorrow's date.
  Date.tomorrow()
      : _date = _truncateTimeOfDay(DateTime.now().add(const Duration(days: 1)));

  /// Returns yesterday's date.
  Date.yesterday()
      : _date = _truncateTimeOfDay(
            DateTime.now().subtract(const Duration(days: 1)));

  /// Returns day of the date represented by this object. Always in range [1; 31].
  int get day => _date.day;

  /// Returns month of the date represented by this object. Always in range [1; 12].
  int get month => _date.month;

  /// Returns year of the date represented by this object.
  int get year => _date.year;

  /// Returns this [Date]'s object representations as [String], with
  /// format ddmmyyyy. For other formatting options, use [format] method.
  @override
  String toString() {
    final day = _date.day.toString();
    final month = _date.month.toString();
    final year = _date.year.toString();
    return '${_modifyLength(day, 2)}${_modifyLength(month, 2)}${_modifyLength(year, 4)}';
  }

  /// Modified the length of the [digits]. If original length is shorter than [designatedLength],
  /// appropriate amount of 0s are added at the beginning. If original length is shorter than
  /// [designatedLength], front digits of [digits] are truncated.
  String _modifyLength(final String digits, final int designatedLength) {
    final difference = designatedLength - digits.length;
    if (difference < 0) {
      return digits.substring(difference.abs());
    } else {
      return ('0' * difference) + digits;
    }
  }

  /// Returns new [Date] modified with given input.
  Date copyWith({final int? day, final int? month, final int? year}) =>
      Date(day ?? _date.day, month ?? _date.month, year ?? _date.year);

  /// Checks if [this] is today.
  bool isToday() => _date.isTheSameDate(Date.today());

  /// Checks if [this] is yesterday.
  bool isYesterday() => _date.isTheSameDate(Date.today() - 1);

  /// Checks if [this] is tomorrow.
  bool isTomorrow() => _date.isTheSameDate(Date.today() + 1);

  /// Formats [this] with a given input.
  /// I.e. to get the [String] `"11-03-2002"`, you want to call `Date(11, 3, 2002).format([dd, '-', mm, '-', yyyy])`.
  /// Available date modifiers are:
  /// * `yyyy` - 4 digit year, i.e. 2002.
  /// * `yy` - 2 digit year, i.e. 02.
  /// * `mm` - 2 digit month, i.e. 03.
  /// * `dd` - 2 digit day, i.e. 11.
  ///
  /// Everything else will be left without change.
  /// You can use all of them both as "dd" and dd.
  String format(final List<String> formats) {
    final result = StringBuffer();
    for (final format in formats) {
      switch (format) {
        case yyyy:
          result.write(_modifyLength(_date.year.toString(), 4));
          break;
        case yy:
          result.write(_modifyLength(_date.year.toString(), 2));
          break;
        case dd:
          result.write(_modifyLength(_date.day.toString(), 2));
          break;
        case mm:
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
  Date toDate() => Date.fromDateTime(this);

  /// Checks is [this] is on the same date as [other].
  bool isTheSameDate(final Date other) => toDate() == other;
}

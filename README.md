# 📆 Dateable

[![Pub](https://img.shields.io/pub/v/dateable.svg)](https://pub.dartlang.org/packages/dateable)
<a href="https://www.buymeacoffee.com/jakubkrapiec" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-blue.png" alt="Buy Me A Coffee" height="20"  width="85" style="height: 20px !important;width: 85px !important;"></a>

A Dart package to help you with managing dates easily. Can be used to store, format, convert, construct, parse and serialise dates. Calendar correctness is guaranteed by the usage of `DateTime`'s system under the hood.

## ⚙️ Import

In your `.dart` files:

```dart
import 'package:dateable/dateable.dart';
```

## ⚗️ Usage

### 👷 Constructors

Variety of different constructors allows for great flexibility and interoperability with other types.

```dart
final date = Date(31, 12, 2019);
final date = Date.fromDateTime(DateTime(2019, 12, 31, 19, 1)); // Time of day is truncated
final date = Date.parseIso8601('2019-12-31T18:23:48.956871'); // Time of day is truncated
final date = Date.parse('31122019');
final date = Date.today();
final date = Date.yesterday();
final date = Date.tomorrow();
```

And a handy `DateTime` extension:

```dart
final date = DateTime(2019, 12, 31, 13, 26).toDate(); // Time of day is truncated
```

All of the above result in the same `date` object!

### 📅 Getters

There are three getters. Simple and easy.

```dart
final date = Date(11, 3, 2002);
print(date.day); // Prints 11
print(date.month); // Prints 3
print(date.year); // Prints 2002
```

### ↔️ Conversion methods

`Date` allows for seamless and easy conversions to most commonly used representations!

```dart
final date = Date(11, 3, 2002);
final dateTime = date.toDateTime(); // Time of day is set to zeros
print(date.toIso8601()); // Prints 2002-03-11T00:00:00.000
print(date.toString()); // Prints 11032002
```

### 📊 Comparisions

Comparisions work just like in your well-known `DateTime` objects!

```dart
final earlier = Date(11, 3, 2002);
final later = Date(21, 9, 2004);
print(earlier.isBefore(later)); // True
print(later.isAfter(earlier)); // Also true
```

On top of this, there are also operators `>` (is after) , `<` (is before), `<=`, `>=` and `==`.

Here comes another handy `DateTime` extension:

```dart
DateTime(2002, 3, 11, 14, 56, 28).isTheSameDate(Date(11, 3, 2002));
```

But if all you want is to check if your `Date` is nearby, here you are.

```dart
final date = Date(11, 3, 2002);
date.isToday();
date.isYesterday();
date.isTomorrow();
```

### 📰 Formatting

You can format your `Date`s to `String`s both with top-level constants and with `String` literals:

- `yyyy` - 4 digit year, i.e. 1997
- `yy` - 2 digit year, i.e. 97
- `mm` - 2 digit month, i.e. 03
- `dd` - 2 digit day, i.e. 11

Both of the below options are correct:

```dart
Date(11, 3, 2002).format([dd, '-', mm, '-', yyyy])
```

```dart
Date(11, 3, 2002).format(['dd', '-', 'mm', 'yyyy'])
```

### 🔨 Modifiers

Last but not least, there is a set of useful modifiers. Every `Date` object is immutable by default, so each of them creates a new `Date` object.

```dart
date.addDays(2) == date + 2 // Always true
date.subtractDays(7) == date - 7 // Also always true
```

You can also use the idiomatic copyWith function.

```dart
date.copyWith(day: 21, month: 9);
```

Sorting an `Iterable` of `Date`s chronologically is even easier:

```dart
[Date(21, 9, 2004), Date(24, 12, 2006), Date(11, 3, 2002)].sort((a, b) => a.compareTo(b));
```

Now the list is `[Date(11, 3, 2002), Date(21, 9, 2004), Date(24, 12, 2006)]`.

## 🐛 Contributing / bug reporting

Contributions and bug reports are welcome! Feel free to [open an issue](https://github.com/SugaR256/dateable/issues) or [create a pull request](https://github.com/SugaR256/dateable/pulls).

## 📖 License

This package is distributed under [MIT license](https://github.com/SugaR256/dateable/blob/master/LICENSE).

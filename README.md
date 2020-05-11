
# 📆 Date
A Dart package to help you with managing dates easily. Calendar correctness is guaranteed by the usage of `DateTime` 's system under the hood.
## ⚙️ Import
In your `.dart` files:
```dart
import 'package:date/date.dart';
```
## ⚗️ Usage
### 👷 Constructors:
Variety of different constructors allows for great flexibility and interoperability with other types.
```dart
final date = Date(31, 12, 2019);
final date = Date.fromDateTime(DateTime(2019, 12, 31, 19, 12)); // Time of day is truncated
final date = Date.parseIso8601('2019-12-31T18:23:48.956871'); // Time of day is truncated
final date = Date.parse('31122019');
```
And a handy `DateTime` extension:
```dart
final date = DateTime(2019, 12, 31, 13, 26).toDate(); // Time of day is truncated
```
All of the above result in the same `date` object!
### 📅 Getters:
There are three getters. Simple and easy.
```dart
final date = Date(11, 3, 2002);
print(date.day); // Prints 11
print(date.month); // Prints 3
print(date.year); // Prints 2002
```
### ↔️ Conversion methods:
`Date` allows for seamless and easy conversions to most commonly used representations!
```dart
final date = Date(11, 3, 2002);
final dateTime = date.toDateTime(); // Time of day is set to zeros
print(date.toIso8601()); // Prints 2002-03-11T00:00:00.000
print(date.toString()); // Prints 11032002
```
### 📊 Comparisions:
Comparisions work just like in your well-known `DateTime` objects!
```dart
final earlier = Date(11, 3, 2002);
final later = Date(21, 9, 2004);
print(earlier.isBefore(later)); // True
print(later.isAfter(earlier)); // Also true
```
On top of this, there are also operators `>` (is after) , `<` (is before), `<=`, `>=` and `==`.
### 🔨 Modifiers:
Last but not least, there is a set of useful modifiers. Every `Date` object is immutable by default, so each of them creates a new `Date` object.
```dart
date.addDays(2) == date + 2 // Always true
date.subtractDays(7) == date - 7 // Also always true
```
Sorting an `Iterable` of `Date`s is even easier:
```dart
[Date(21, 9, 2004), Date(24, 12, 2006), Date(11, 3, 2002)].sort((a, b) => a.compareTo(b));
```
Now the list is `Date(11, 3, 2002), [Date(21, 9, 2004), Date(24, 12, 2006)]`.
## 🐛 Contributing / bug reporting
Contributions and bug reports are welcome! Feel free to open an issue or create a pull request.
## 📖 License
This package is distributed under MIT license.

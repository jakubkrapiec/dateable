import 'package:dateable/dateable.dart';
import 'package:test/test.dart';

void main() {
  group('Format tests - predefined constants', () {
    final date = Date(11, 3, 2002);
    test('Format test 1', () {
      expect(date.format([dd, mm, yyyy]), equals('11032002'));
    });
    test('Format test 2', () {
      expect(date.format([dd, '-', mm, '-', yyyy]), equals('11-03-2002'));
    });
    test('Format test 3', () {
      expect(date.format([dd, ' - ', mm, ' - ', yy]), equals('11 - 03 - 02'));
    });
  });
  group('Format tests - by literals', () {
    final date = Date(21, 9, 2004);
    test('Literal test', () {
      expect(date.format(['dd', '/', 'mm', '/', 'yy']), equals('21/09/04'));
    });
    test('Filtering test', () {
      expect(date.format(['mmmayyddayyyy, it is ', 'dd', '.', 'mm', '.', 'yyyy']), equals('mmmayyddayyyy, it is 21.09.2004'));
    });
  });
}

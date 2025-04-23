
import 'package:ansicolor/ansicolor.dart';

class CustomPrint {
  static void printSuccess(String message) {
    AnsiPen pen = AnsiPen(
      
    )..green(bold: true);
    print(pen(message));
  }

  static void printError(String message) {
    AnsiPen pen = AnsiPen()..red(bold: true);
    print(pen(message));
  }
}

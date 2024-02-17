import 'package:flutter/services.dart' show rootBundle;


Future<Set<String>> readLines(String path) async {
    final lines = await rootBundle.loadString(path);

    return lines.split("\n").toSet();
}
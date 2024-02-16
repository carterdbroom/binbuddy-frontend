import 'dart:io';

Future<Set<String>> readLines(String path) async {
    final file = File(path);
    final lines = await file.readAsLines();

    return lines.toSet();
}
import 'dart:io';
import 'dart:convert';

Future<List<String>> readFile() async {
  var path = 'lib/input.txt';

  List<String> lines = [];
  await File(path)
      .openRead()
      .map(utf8.decode)
      .transform(
        LineSplitter(),
      )
      .forEach(
    (l) {
      lines.add(l);
    },
  );

  return lines;
}

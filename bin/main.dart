import 'package:number_four/7.dart';
import 'package:number_four/read_file.dart';

Future<void> main(List<String> arguments) async {
  final lines = await readFile();
  seven7(lines);
}

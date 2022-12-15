import 'package:number_four/8/eight_part_two.dart';
import 'package:number_four/read_file.dart';

Future<void> main(List<String> arguments) async {
  final lines = await readFile();
  eightPartTwo(lines);
}

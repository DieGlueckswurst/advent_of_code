import 'package:number_four/9/nine_part_one.dart';
import 'package:number_four/read_file.dart';

Future<void> main(List<String> arguments) async {
  final lines = await readFile();
  NinePartOne(lines).run();
}

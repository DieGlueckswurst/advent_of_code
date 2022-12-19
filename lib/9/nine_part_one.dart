import 'package:collection/collection.dart';

class NinePartOne {
  final List<String> lines;

  NinePartOne(this.lines);

  List<List<int>> tailCordinates = [
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    // [0, 0],
  ];

  List<List<int>> visitedCordinates = [
    [0, 0]
  ];

  Map<String, int> directionValues = {
    'L': -1,
    'U': 1,
    'R': 1,
    'D': -1,
  };

  List<int> head = [0, 0];

  run() {
    print(isTouching(cordinate: [-1, 8], cordinateToCompare: [1, 8]));

    late String currDir;

    int currStepsToGo = 0;

    for (String line in lines) {
      currDir = getDir(line);
      currStepsToGo = getStepsToGo(line);
      print('----------NEW DIRECTION:  $currDir-----------');

      for (int i = 0; i < currStepsToGo; i++) {
        moveHead(
          directionChar: currDir,
        );
        moveTail(
          curDirr: currDir,
        );

        print('move head: $head');
        print(tailCordinates);
      }
      // currStepsToGo = 0;
    }

    print(visitedCordinates.length);
  }

  bool isTouching({
    required List<int> cordinate,
    required List<int> cordinateToCompare,
  }) {
    // print('--------------------------');
    // print('cordinate: $cordinate');
    // print('cordinateToCompare: $cordinateToCompare');
    // print('horizontally:');
    // print((cordinate[0].abs() - cordinateToCompare[0].abs()).abs());
    // print('vertically:');
    // print((cordinate[1].abs() - cordinateToCompare[1].abs()).abs());
    // print('diagonally:');
    // print((cordinate[0].abs() -
    //         cordinateToCompare[0].abs() +
    //         (cordinate[1].abs() - cordinateToCompare[1].abs()))
    //     .abs());
    final int xDiff = (cordinate[0] - cordinateToCompare[0]).abs();
    bool touchingHorizontally = xDiff < 2;

    final int yDiff = (cordinate[1] - cordinateToCompare[1]).abs();
    bool touchingVertically = yDiff < 2;

    // bool notTouchingDiagonally = xDiff + yDiff >= 2;
    // print(
    //     'touching: ${touchingHorizontally && touchingVertically && touchingDiagonally}');
    return touchingHorizontally && touchingVertically;
  }

  int getStepsToGo(String line) {
    return int.parse(line.split(' ')[1]);
  }

  String getDir(String line) {
    return line.split(' ')[0];
  }

  void moveHead({
    required String directionChar,
  }) {
    switch (directionChar) {
      case 'L':
      case 'R':
        head[0] += directionValues[directionChar]!;
        return;
      case 'U':
      case 'D':
        head[1] += directionValues[directionChar]!;
        return;
      default:
        print('UNKOWN DIRECTION: $directionChar');
    }
  }

  void moveTail({
    required String curDirr,
  }) {
    for (int i = 0; i < tailCordinates.length; i++) {
      bool isFirstElement = i == 0;

      List<int> currentTailCordinate = tailCordinates[i];
      List<int> elementBefore = isFirstElement ? head : tailCordinates[i - 1];
      bool touching = isTouching(
        cordinate: currentTailCordinate,
        cordinateToCompare: elementBefore,
      );

      if (touching) {
        // nothing
        return;
      } else {
        int xDiff = (elementBefore.first - currentTailCordinate.first);
        int yDiff = (elementBefore.last - currentTailCordinate.last);

        if (xDiff.abs() > 0) {
          if (xDiff < 0) {
            currentTailCordinate[0] -= 1;
          } else {
            currentTailCordinate[0] += 1;
          }
        }
        if (yDiff.abs() > 0) {
          if (yDiff < 0) {
            currentTailCordinate[1] -= 1;
          } else {
            currentTailCordinate[1] += 1;
          }
        }

        if (i == tailCordinates.length - 1) {
          bool visited = false;

          for (var cordinate in visitedCordinates) {
            visited = ListEquality().equals(
              cordinate,
              currentTailCordinate,
            );
            if (visited) {
              return;
            }
          }
          print(
            'new visited cordinate: ${currentTailCordinate[0]} ${currentTailCordinate[1]}',
          );
          visitedCordinates.add(
            [
              currentTailCordinate[0],
              currentTailCordinate[1],
            ],
          );
        }
      }
    }
  }
}

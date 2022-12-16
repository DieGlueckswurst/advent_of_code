import 'package:collection/collection.dart';

List<int> currCordinate = [0, 0];

List<List<int>> visitedCordinates = [
  [0, 0]
];
int stepCounter = 0;

ninePartOne(List<String> lines) {
  PosDiff posDiff = PosDiff();
  late Direction currDir;

  int currStepsToGo = 0;

  for (String line in lines) {
    if (currStepsToGo == 0) {
      currDir = getDir(line);
      currStepsToGo = getStepsToGo(line);
    }

    for (int i = 0; i < currStepsToGo; i++) {
      if (isTouching(posDiff)) {
        posDiff = moveHead(
          currDir: currDir,
          posDiff: posDiff,
        );
      }
      if (!isTouching(posDiff)) {
        posDiff = moveTail(
          posDiff: posDiff,
          curDirr: currDir,
        );
      }
    }
    currStepsToGo = 0;
  }

  print(visitedCordinates.length);
}

bool isTouching(PosDiff posDiff) {
  return posDiff.left < 2 &&
      posDiff.top < 2 &&
      posDiff.right < 2 &&
      posDiff.bottom < 2;
}

int getStepsToGo(String line) {
  return int.parse(line.split(' ')[1]);
}

Direction getDir(String line) {
  final String directionString = line.split(' ')[0];
  switch (directionString) {
    case 'L':
      return Direction.left;
    case 'U':
      return Direction.top;
    case 'R':
      return Direction.right;
    case 'D':
      return Direction.bottom;

    default:
      print('UNKOWN DIRECTION: $line');
      return Direction.unkown;
  }
}

PosDiff moveHead({
  required Direction currDir,
  required PosDiff posDiff,
}) {
  PosDiff posDiffToReturn = posDiff;
  switch (currDir) {
    case Direction.left:
      if (posDiff.right > 0) {
        posDiffToReturn.right -= 1;
      } else {
        posDiffToReturn.left += 1;
      }
      break;
    case Direction.top:
      if (posDiff.bottom > 0) {
        posDiffToReturn.bottom -= 1;
      } else {
        posDiffToReturn.top += 1;
      }
      break;
    case Direction.right:
      if (posDiff.left > 0) {
        posDiffToReturn.left -= 1;
      } else {
        posDiffToReturn.right += 1;
      }
      break;
    case Direction.bottom:
      if (posDiff.top > 0) {
        posDiffToReturn.top -= 1;
      } else {
        posDiffToReturn.bottom += 1;
      }
      break;
    case Direction.unkown:
      print('UNKOWN DIRECTION');
      break;
  }
  return posDiffToReturn;
}

PosDiff moveTail({
  required PosDiff posDiff,
  required Direction curDirr,
}) {
  PosDiff posDiffToReturn = posDiff;

  // print('-------- TAIL MOVE -----------');
  if (posDiff.left > 0) {
    posDiffToReturn.left -= 1;
    currCordinate[0] -= 1;
    // print('left');
  }
  if (posDiff.top > 0) {
    posDiffToReturn.top -= 1;
    currCordinate[1] += 1;

    // print('top');
  }
  if (posDiff.right > 0) {
    posDiffToReturn.right -= 1;
    currCordinate[0] += 1;

    // print('right');
  }
  if (posDiff.bottom > 0) {
    posDiffToReturn.bottom -= 1;
    currCordinate[1] -= 1;

    // print('bottom');
  }

  bool visited = false;
  for (var cordinate in visitedCordinates) {
    visited = ListEquality().equals(cordinate, currCordinate);
    if (visited) {
      return posDiffToReturn;
    }
  }
  stepCounter += 1;
  visitedCordinates.add([currCordinate[0], currCordinate[1]]);

  // print(currCordinate);
  // print(visitedCordinates);

  // print('------------------');

  return posDiffToReturn;
}

enum Direction {
  left,
  top,
  right,
  bottom,
  unkown,
}

class PosDiff {
  int left = 0;
  int top = 0;
  int right = 0;
  int bottom = 0;
}

// class Cordinate {
//   int x;
//   int y;

//   Cordinate(this.x, this.y);
// }

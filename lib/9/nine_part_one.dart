import 'package:collection/collection.dart';

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
  [0, 0],
];

List<List<int>> visitedCordinates = [
  [0, 0]
];

Map<String, int> directionValue = {
  'L': -1,
  'U': 1,
  'R': 1,
  'D': -1,
};

List<int> head = [0, 0];

ninePartOne(List<String> lines) {
  late String currDir;

  int currStepsToGo = 0;

  for (String line in lines) {
    if (currStepsToGo == 0) {
      currDir = getDir(line);
      currStepsToGo = getStepsToGo(line);
    }

    for (int i = 0; i < currStepsToGo; i++) {
      if (isTouching2(
          tailCordinates.first[0], tailCordinates.first[1], head[0], head[1])) {
        moveHead(
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

bool isTouching2(int dx1, int dy1, int dx2, int dy2) {
  (dx1.abs() - dx2.abs()) < 2;
  (dy1.abs() - dy2.abs()) < 2;

  return (dx1.abs() - dx2.abs()) < 2 &&
      (dy1.abs() - dy2.abs()) < 2 &&
      (dx1.abs() - dx2.abs() + (dy1.abs() - dy2.abs())) < 2;
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

String getDir(String line) {
  return line.split(' ')[0];
}

PosDiff moveHead({
  required String currDir,
}) {
  switch (currDir) {
    case Direction.left:
      if (head[1] > 0) {
        head[1] -= 1;
      } else {
        head[1] += 1;
      }
      break;
    case Direction.top:
      if (posDiff.bottom > 0) {
        head[1] -= 1;
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

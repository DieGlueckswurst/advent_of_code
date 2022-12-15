eightPartTwo(List<String> lines) {
  List<List<int>> forest = getForest(lines);

  int scenicScore = 0;

  for (int x = 0; x < lines.length; x++) {
    for (int y = 0; y < forest[x].length; y++) {
      int scenicScoreToCheck = getScenicScore(forest, x, y);
      if (scenicScoreToCheck > scenicScore) {
        scenicScore = scenicScoreToCheck;
      }
    }
  }

  print(scenicScore);
}

final Map<List<int>, List<int>> treePositionPointsMap = {};

int getScenicScore(List<List<int>> forest, int posX, int posY) {
  final currentTreeHeight = forest[posX][posY];

  bool visibleFromTop = true;
  int scenicScoreTop = 0;

  bool visibleFromBottom = true;
  int scenicScoreBottom = 0;

  for (int x = 0; x < forest.length; x++) {
    if (x < posX && visibleFromTop) {
      int hightToCompare = forest[posX - x - 1][posY];

      visibleFromTop = currentTreeHeight > hightToCompare;
      scenicScoreTop += 1;
    }
    if (x == posX) {
      // nothing
    }

    if (x > posX && visibleFromBottom) {
      int hightToCompare = forest[x][posY];

      visibleFromBottom = currentTreeHeight > hightToCompare;
      scenicScoreBottom += 1;
    }
  }

  bool visibleFromLeft = true;
  int scenicScoreLeft = 0;

  bool visibleFromRight = true;
  int scenicScoreRight = 0;

  for (int y = 0; y < forest[posX].length; y++) {
    if (y < posY && visibleFromLeft) {
      int hightToCompare = forest[posX][posY - y - 1];

      visibleFromLeft = currentTreeHeight > hightToCompare;
      scenicScoreLeft += 1;
    }

    if (y == posY) {
      // nothing
    }

    if (y > posY && visibleFromRight) {
      int hightToCompare = forest[posX][y];

      visibleFromRight = currentTreeHeight > hightToCompare;
      scenicScoreRight += 1;
    }
  }

  final int scenicScore =
      scenicScoreLeft * scenicScoreRight * scenicScoreTop * scenicScoreBottom;

  treePositionPointsMap[[posX, posY]] = [
    scenicScoreLeft,
    scenicScoreTop,
    scenicScoreRight,
    scenicScoreBottom
  ];

  return scenicScore;
}

List<List<int>> getForest(List<String> lines) {
  List<List<int>> forest = [];

  for (String line in lines) {
    List<int> row = [];
    for (String char in line.split('')) {
      row.add(int.parse(char));
    }
    forest.add(row);
  }
  return forest;
}

bool isEdge(List<List<int>> forest, int x, int y) {
  if (x == 0) {
    return true;
  } else if (y == 0) {
    return true;
  } else if (x == forest.length - 1) {
    return true;
  } else if (y == forest[x].length - 1) {
    return true;
  } else {
    return false;
  }
}

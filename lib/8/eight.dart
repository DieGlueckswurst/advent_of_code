eight(List<String> lines) {
  List<List<int>> forest = getForest(lines);

  int visibleTrees = 0;

  // print(isInsideAndVisible(forest, 1, 1));

  for (int x = 0; x < lines.length; x++) {
    for (int y = 0; y < forest[x].length; y++) {
      if (isEdge(forest, x, y)) {
        print('visible edget: ${forest[x][y]}');
        visibleTrees += 1;
      } else if (isInsideAndVisible(forest, x, y)) {
        print('visible inside: ${forest[x][y]}');

        visibleTrees += 1;
      } else {
        print('not visible: ${forest[x][y]}');
      }
    }
  }

  print(visibleTrees);
}

bool isInsideAndVisible(List<List<int>> forest, int posX, int posY) {
  final currentTreeHeight = forest[posX][posY];

  bool visibleFromLeft = true;
  bool visibleFromRight = true;
  for (int x = 0; x < forest.length; x++) {
    if (x < posX && visibleFromLeft) {
      visibleFromLeft = currentTreeHeight > forest[x][posY];
    }
    if (x == posX) {}

    if (x > posX && visibleFromRight) {
      visibleFromRight = currentTreeHeight > forest[x][posY];
    }
  }

  bool visibleFromTop = true;
  bool visibleFromBottom = true;

  for (int y = 0; y < forest[posX].length; y++) {
    if (y < posY && visibleFromTop) {
      visibleFromTop = currentTreeHeight > forest[posX][y];
    }

    if (y == posY) {}

    if (y > posY && visibleFromBottom) {
      visibleFromBottom = currentTreeHeight > forest[posX][y];
    }
  }

  return visibleFromLeft ||
      visibleFromRight ||
      visibleFromTop ||
      visibleFromBottom;
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

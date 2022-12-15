seven7(List<String> lines) {
  /*
  - / (dir)
  - a (dir)
    - e (dir)
      - i (file, size=584)
    - f (file, size=29116)
    - g (file, size=2557)
    - h.lst (file, size=62596)
  - b.txt (file, size=14848514)
  - c.dat (file, size=8504156)
  - d (dir)
    - j (file, size=4060174)
    - d.log (file, size=8033020)
    - d.ext (file, size=5626152)
    - k (file, size=7214296)
  */

  /*
    $ cd /
    $ ls
    dir a
    14848514 b.txt
    8504156 c.dat
    dir d
    $ cd a
    $ ls
    dir e
    29116 f
    2557 g
    62596 h.lst 
    $ cd e
    $ ls
    584 i
    $ cd ..
    $ cd ..
    $ cd d
    $ ls
    4060174 j
    8033020 d.log
    5626152 d.ext
    7214296 k
  */
  print('Hello');

  // Answer 977799

  Map<Dir, int> directoriesWithFileSize = {};

  List<Dir> dirList = [];

  for (String line in lines) {
    LineType lineType = getLineType(line);
    // print(lineType);

    switch (lineType) {
      case LineType.dir:
        // directoriesWithFileSize[getDirectoryName(line)] = 0;
        break;
      case LineType.file:
        for (Dir dir in dirList) {
          directoriesWithFileSize[dir] =
              directoriesWithFileSize[dir]! + getFileSize(line);
        }
        break;
      case LineType.listing:
        // print('listing: $line');
        break;
      case LineType.goingIntoDir:
        Dir dir = Dir(name: getDirectoryName(line), level: dirList.length);
        directoriesWithFileSize[dir] = 0;

        dirList.add(dir);
        break;
      case LineType.goingOutOfDir:
        dirList.removeLast();
        break;
      case LineType.unknown:
        print(line);
        break;
    }
  }

  // int totalSize = 0;
  // directoriesWithFileSize.forEach((key, value) {
  //   if (value < 100000) {
  //     totalSize += value;
  //   }
  // });

  // Teil 2

  final int totalSpace = 70000000;

  final int spaceNeededForUpdate = 30000000;

  final int freeSpace =
      totalSpace - directoriesWithFileSize[directoriesWithFileSize.keys.first]!;

  int smallestFileSizeToDelete = totalSpace;
  directoriesWithFileSize.forEach((key, size) {
    if (freeSpace + size >= spaceNeededForUpdate) {
      if (size < smallestFileSizeToDelete) {
        smallestFileSizeToDelete = size;
      }
    }
  });

  print(smallestFileSizeToDelete);
}

enum LineType {
  dir,
  file,
  listing,
  goingIntoDir,
  goingOutOfDir,
  unknown,
}

LineType getLineType(String line) {
  if (isDir(line)) {
    return LineType.dir;
  }
  if (isFile(line)) {
    return LineType.file;
  }
  if (_isListing(line)) {
    return LineType.listing;
  }
  if (isGoingIntoDirectory(line)) {
    return LineType.goingIntoDir;
  }
  if (isGoingOutOfDirectory(line)) {
    return LineType.goingOutOfDir;
  }

  return LineType.unknown;
}

bool isDir(String line) {
  return line.startsWith('dir');
}

int getFileSize(String line) {
  return int.parse(line.split(' ')[0]);
}

bool isFile(String line) {
  return RegExp(r'^[0-9]+$').hasMatch(
    line.split(' ')[0],
  );
}

/// '$ cd e'
/// returns e
String getDirectoryName(String line) {
  return line.split(' ')[2];
}

bool isGoingIntoDirectory(String line) {
  return line.startsWith('\$ cd') && !isGoingOutOfDirectory(line);
}

bool isGoingOutOfDirectory(String line) {
  return line.startsWith('\$ cd ..');
}

bool _isListing(String line) {
  return line.startsWith('\$ ls');
}

class Dir {
  final String name;
  final int level;

  Dir({
    required this.name,
    required this.level,
  });
}

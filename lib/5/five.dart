five5(List<String> lines) {
  /*

    [H]         [H]         [V]    
    [V]         [V] [J]     [F] [F]
    [S] [L]     [M] [B]     [L] [J]
    [C] [N] [B] [W] [D]     [D] [M]
[G] [L] [M] [S] [S] [C]     [T] [V]
[P] [B] [B] [P] [Q] [S] [L] [H] [B]
[N] [J] [D] [V] [C] [Q] [Q] [M] [P]
[R] [T] [T] [R] [G] [W] [F] [W] [L]
 1   2   3   4   5   6   7   8   9 
  */

  final cratesMap = <int, List<String>>{
    1: ['R', 'N', 'P', 'G'],
    2: ['T', 'J', 'B', 'L', 'C', 'S', 'V', 'H'],
    3: ['T', 'D', 'B', 'M', 'N', 'L'],
    4: ['R', 'V', 'P', 'S', 'B'],
    5: ['G', 'C', 'Q', 'S', 'W', 'M', 'V', 'H'],
    6: ['W', 'Q', 'S', 'C', 'D', 'B', 'J'],
    7: ['F', 'Q', 'L'],
    8: ['W', 'M', 'H', 'T', 'D', 'L', 'F', 'V'],
    9: ['L', 'P', 'B', 'V', 'M', 'J', 'F'],
  };

  for (int i = 10; i < lines.length; i++) {
    final line = lines[i];

    int move = int.parse(line.split(' ')[1]);
    int from = int.parse(line.split(' ')[3]);
    int to = int.parse(line.split(' ')[5]);

    List<String> cratesToMove = cratesMap[from]!.sublist(
      cratesMap[from]!.length - move,
    );

    cratesMap[from]!.removeRange(
      cratesMap[from]!.length - move,
      cratesMap[from]!.length,
    );
    // 1
    List<String> cratesToMoveReversed = cratesToMove.reversed.toList();

    // 2
    cratesToMoveReversed = cratesToMove;

    cratesMap[to]!.addAll(cratesToMoveReversed);
  }

  String result = '';

  for (var list in cratesMap.values) {
    result += list.last;
  }
  print(result);
}

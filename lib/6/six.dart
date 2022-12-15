day6(List<String> lines) {
  final String signal = lines.first;

  /*


mjqjpqmgbljsphdztnvjfqwrcgsmlb: first marker after character 19
bvwbjplbgvbhsrlpgdmjqwftvncz: first marker after character 23
nppdvjthqldpwncqszvftbrmjlhg: first marker after character 23
nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg: first marker after character 29
zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw: first marker after character 26
  */

  int charCount = 0;

  bool signalCharFound = false;

  for (int i = 0; i < signal.length; i++) {
    charCount++;

    List<String> lettersToCheckForDuplicates = [];

    for (int k = 1; k < 14; k++) {
      lettersToCheckForDuplicates.add(signal[i + k]);
    }

    List<String> dupLetters = [];

    for (int j = 0; j < lettersToCheckForDuplicates.length; j++) {
      signalCharFound = true;
      if (dupLetters.contains(lettersToCheckForDuplicates[j])) {
        signalCharFound = false;

        break;
      } else {
        dupLetters.add(lettersToCheckForDuplicates[j]);
      }
    }
    if (signalCharFound == true) {
      break;
    }
  }

  print(charCount + 14);
}

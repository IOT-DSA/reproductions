List<List<int>> lists;

main() {
  print("Creating 1 million lists.");

  lists = new List<List<int>>();
  for (var listCount = 1; listCount <= 1000000; listCount++) {
    lists.add(new List<int>.generate(2000, (i) => null));
  }

  print("Clearing lists.");
  for (var list in lists) {
    list.clear();
  }

  print("Lists cleared. ");
}

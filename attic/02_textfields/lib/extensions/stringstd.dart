extension Trimmer on String {
  // * Remove all zeros at beginning.
  String removeZerosFromStart() {
    if (length == 1) {
      return this;
    }

    List<String> arr = split("");

    int countOfZeros = 0;

    for (var i = 0; i < arr.length; i++) {
      if (int.tryParse(arr[i]) != null && arr[i] == "0") {
        countOfZeros += 1;
      } else {
        break;
      }
    }

    List<String> newArr = arr.sublist(countOfZeros);
    String numbers = newArr.join();

    // * Avoid string contains numbers at return of the function.
    String result = numbers.replaceAll(RegExp(r'^[a-zA-Z]$'), '');

    return result;
  }
}

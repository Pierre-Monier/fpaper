extension ReverseCompareTo on DateTime {
  int reverseCompareTo(DateTime other) {
    final regularCompareTo = compareTo(other);

    switch (regularCompareTo) {
      case -1:
        return 1;
      case 1:
        return -1;
      default:
        return 0;
    }
  }
}

extension FlagCopy on String {
  String flagCopy() => toLowerCase().substring(0, length - 1);
}

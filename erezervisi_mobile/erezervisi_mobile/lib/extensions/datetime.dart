extension DateTimeExtensions on DateTime {
  int daysBetween(DateTime to) {
    DateTime from = DateTime(year, month, day);
    DateTime target = DateTime(to.year, to.month, to.day);
    return (target.difference(from).inHours / 24).round();
  }
}

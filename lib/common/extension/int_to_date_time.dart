

extension IntToDateTime on int {
  
  DateTime toDateTime() => DateTime.fromMillisecondsSinceEpoch(
    this * 1000,
    isUtc: true,
  );
}
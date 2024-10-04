String padNumberWith0(int n, {int length = 2}) {
  return n.toString().padLeft(length, '0');
}

String timestampToDateString(int timestamp) {
  final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  final now = DateTime.now();

  if (date.year == now.year && date.month == now.month && date.day == now.day) {
    return '${padNumberWith0(date.hour)}:${padNumberWith0(date.minute)}';
  } else {
    return '${padNumberWith0(date.day)}-${padNumberWith0(date.month)}-${date.year}';
  }
}

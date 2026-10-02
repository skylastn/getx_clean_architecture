extension StringExt on String {
  DateTime get toDateTime {
    return DateTime.tryParse(this) ?? DateTime.now();
  }

  double get toDouble {
    return double.tryParse(this) ?? 0;
  }

  String get capitalizeFirst {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  bool get isEmail {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  String get getExt {
    if (isEmpty) return '';
    if (!contains('.')) return '';
    return split('.').last;
  }

  int get toInt {
    return int.tryParse(this) ?? 0;
  }
}

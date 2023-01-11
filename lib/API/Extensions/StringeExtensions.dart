extension StringNumberExtension on String {
  String spaceSeparateNumbers() {
    final result = this.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ');
    return result;
  }
}
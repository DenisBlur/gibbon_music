import 'package:gibbon_music/constants/app_consts.dart';

extension StringNumberExtension on String {
  String spaceSeparateNumbers() {
    final result = replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ');
    return result;
  }

  String linkImage(int size) {
    if (isEmpty) return AppConsts.imageEmptyLink;
    final result = substring(0, indexOf("%"));
    return "https://$result${size}x$size";
  }
}

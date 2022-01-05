part of 'extensions.dart';

extension StringExtension on String {
  bool isDigit(int index) =>
      this.codeUnitAt(index) >= 48 &&
      this.codeUnitAt(index) <=
          57; //fungsi untuk ngeccek karakter dalam string itu angka atau bukan, maka butuh index
  //48-57 index code ascii
}

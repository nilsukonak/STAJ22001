//edittask ve newtaskta titlenin boş olup olmadığını kontrol etmek için helper func
String? validateNotEmpty(String? value, String fieldName) {
  if (value == null || value.isEmpty) {
    return '$fieldName bos donemez';
    //return Error();
  }
  return null;
}

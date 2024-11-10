import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
class CurrencyPtBrFormatter extends TextInputFormatter {
  CurrencyPtBrFormatter({this.maxDigits});
  final int maxDigits;
  double _uMaskValue;
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    if (maxDigits != null && newValue.selection.baseOffset > maxDigits) {
      return oldValue;
    }
    double value = double.parse(newValue.text);
    final formatter = new NumberFormat("#,##0", "en");
    String newText = formatter.format(value);
    //String newText = formatter.format(value) + " جنية مصري";
    //setting the umasked value
    _uMaskValue = value;
    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
  //here the method
  double getUnmaskedDouble() {
    return _uMaskValue;
  }
  int getIntOnly(String number) {
    String integerValue = "";
    for(int i = 0; i< number.length; i++)
      {
          if(number[i] != ",")
            {
              integerValue = integerValue + number[i];
            }
      }
    return int.parse(integerValue);
  }

  String getStringOnly(String number) {
    String integerValue = "";
    for(int i = 0; i< number.length; i++)
    {
      if(number[i] != ",")
      {
        integerValue = integerValue + number[i];
      }
    }
    return integerValue;
  }
}
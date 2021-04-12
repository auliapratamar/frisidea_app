import 'dart:math';

import 'package:frisidea_app/base/base_view_model.dart';

class MainViewModel extends BaseModel {

  String _firstInputValue ;
  String get firstInputValue => _firstInputValue;
  set firstInputValue(String value) {
    _firstInputValue = value;
    notifyListeners();
  }

  String _secondInputValue ;
  String get secondInputValue => _secondInputValue;
  set secondInputValue(String value) {
    _secondInputValue = value;
    notifyListeners();
  }

  List<String> _primeList = [];
  List<String> get primeList => _primeList;
  set primeList(List<String> value) {
    _primeList = value;
    notifyListeners();
  }

  resetValue({Function(bool) isDone}){
    primeList.clear();
    firstInputValue = null;
    secondInputValue = null;
    isDone(true);
  }

  calculate({Function(bool) isPrimeNumber}) async {
    setBusy();
    if (firstInputValue == null || secondInputValue == null){
      print(firstInputValue);
      print(secondInputValue);
      setIdle();
      isPrimeNumber(false);
      return;
    }
    if (int.parse(firstInputValue) > int.parse(secondInputValue)){
      setIdle();
      isPrimeNumber(false);
      return;
    }
    for (int index = int.parse(firstInputValue); index < int.parse(secondInputValue); index++){
      if (isPrime(index)){
        print(index);
        primeList.add(index.toString());
      }
    }
    isPrimeNumber(true);
    setIdle();
  }

  bool isPrime(int number){
    if (number <= 1) return false;
    int lowerBound = sqrt(number).floor();
    int divisorFound = 0;
    for (int divisor = 1; divisor <= lowerBound; divisor++){
      if (number % divisor == 0) divisorFound++;
      if (divisorFound > 1) return false;
    }
    return true;
  }
}
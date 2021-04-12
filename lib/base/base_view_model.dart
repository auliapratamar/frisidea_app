import 'package:flutter/material.dart';

class BaseModel extends ChangeNotifier {
  bool _isLoadingSubject = false;

  bool get loadingStatus => _isLoadingSubject;

  void setBusy(){
    _isLoadingSubject = true;
    notifyListeners();
  }

  void setIdle(){
    _isLoadingSubject = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _isLoadingSubject = false;
    notifyListeners();
    super.dispose();
  }
}
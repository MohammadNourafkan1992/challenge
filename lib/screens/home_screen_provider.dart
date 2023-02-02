import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/model/tour.dart';

class HomeScreenProvider extends ChangeNotifier {
  List<Tour> _favorritsList = [];

  List<Tour> get favorritsList => _favorritsList;

  set favorritsList(List<Tour> value) {
    if (value != _favorritsList) {
      _favorritsList = value;
      notifyListeners();
    }
  }
}

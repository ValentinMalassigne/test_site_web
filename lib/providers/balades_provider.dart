import 'package:flutter/cupertino.dart';

import '../models/balade.dart';

class BaladeProvider extends ChangeNotifier {
  List<Balade> allBalade;
  BaladeProvider({
    required this.allBalade,
  });
  void clear() {
    allBalade = [];
    notifyListeners();
  }

  void updateBalades(List<Balade> data) {
    allBalade = data;
    notifyListeners();
  }
}

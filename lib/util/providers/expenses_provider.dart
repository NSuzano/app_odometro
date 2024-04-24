import 'package:app_odometro/models/expenses.dart';
import 'package:app_odometro/models/user.dart';
import 'package:app_odometro/pages/expenses/util/util_expenses.dart';
import 'package:flutter/material.dart';

class ExpenseProvider with ChangeNotifier {
  List<Expenses> _expenses = [];
  int _currentPage = 1;
  bool _hasMore = true;

  List<Expenses> get expenses => _expenses;
  bool get hasMore => _hasMore;
  int get currentPage => _currentPage;

  Future fetchExpenses(User user, int page) async {
    List<Expenses> newExpenses = await ExpensesUtil.getExpenses(user, page);
    if (newExpenses.length < 10) {
      _hasMore = false;
    }
    _expenses.addAll(newExpenses);
    _currentPage++;

    print("HAS MORE : $_hasMore");

    notifyListeners();
  }

  void addExpenses(Expenses expenses) {
    _expenses.add(expenses);
    notifyListeners();
  }

  void removeExpenses(Expenses expenses) {
    _expenses.remove(expenses);
    notifyListeners();
  }

  void clearExpenses() {
    _expenses.clear();
    _currentPage = 1;
    _hasMore = true;
    notifyListeners();
  }
}

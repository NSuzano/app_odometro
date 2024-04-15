import 'package:app_odometro/models/expenses.dart';
import 'package:app_odometro/models/user.dart';
import 'package:app_odometro/pages/expenses/util_expenses.dart';
import 'package:flutter/material.dart';

class ExpenseProvider with ChangeNotifier {
  List<Expenses> _expenses = [];

  List<Expenses> get expenses => _expenses;

  Future fetchExpenses(User user) async {
    _expenses = await ExpensesUtil.getExpenses(user);
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

  void setExpenses(List<Expenses> expenses) {
    _expenses = expenses;
    notifyListeners();
  }
}

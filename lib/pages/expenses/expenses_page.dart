import 'package:app_odometro/constraint/constraint.dart';
import 'package:app_odometro/models/categories.dart';
import 'package:app_odometro/models/driver.dart';
import 'package:app_odometro/models/expenses.dart';
import 'package:app_odometro/models/payment.dart';
import 'package:app_odometro/models/user.dart';
import 'package:app_odometro/pages/expenses/expenses_card.dart';
import 'package:app_odometro/util/providers/expenses_provider.dart';
import 'package:app_odometro/util/snackbar.dart';
import 'package:app_odometro/util/util_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  late User user;
  List<Expenses> expenses = [];
  late ScrollController _scrollController;
  bool _isButtonVisible = true;

  late Driver driver;
  late List<Payment> paymentList;
  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _scrollController.addListener(_handleScrollDirectionChange);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final expenseProvider =
          Provider.of<ExpenseProvider>(context, listen: false);
      if (expenseProvider.hasMore) {
        expenseProvider.fetchExpenses(user, expenseProvider.currentPage);
      }
    }
  }

  void _handleScrollDirectionChange() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_isButtonVisible) {
        setState(() {
          _isButtonVisible = false;
        });
      }
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!_isButtonVisible) {
        setState(() {
          _isButtonVisible = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    final args = ModalRoute.of(context)!.settings.arguments as Map;

    user = args['user'];
    expenses = expenseProvider.expenses;
    driver = args['driver'];
    paymentList = args['payment-list'];

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
            ),
          ),
          title: const Text(
            "Lista de Despesas",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                "Todos os Registros",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kDefaultColors,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              expenses.isNotEmpty
                  ? Flexible(
                      child: ListView.builder(
                          controller: _scrollController,
                          itemCount: expenses.length +
                              (expenseProvider.hasMore ? 1 : 0),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (index == expenses.length &&
                                expenseProvider.hasMore) {
                              // Renderiza um widget de carregamento no final
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            Expenses? expense;
                            expense = expenses[index];

                            return ExpensesCard(
                              expenses: expense,
                            );
                          }))
                  : const SizedBox(
                      height: 600,
                      child: Center(
                          child: Text(
                        "Sem registros",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    )
            ],
          ),
        ),
        floatingActionButton: _isButtonVisible
            ? FloatingActionButton.extended(
                backgroundColor: kDefaultColors,
                foregroundColor: kDefaultColorWhite,
                onPressed: () async {
                  List<Categories> listCategories = [];
                  List<Categories> listCategoriesGas = [];
                  try {
                    listCategories = await CategoriesUtil.getCategories(
                        user, "center_of_cost");
                    listCategoriesGas =
                        await CategoriesUtil.getCategories(user, "category");
                    // listCategoriesGroupTax =
                    //     await CategoriesUtil.getCategories(user, "group_taxa");

                    if (context.mounted) {
                      Navigator.pushNamed(context, 'expensives', arguments: {
                        "user": user,
                        "categories-list": listCategories,
                        "categories-gas": listCategoriesGas,
                        "driver": driver,
                        "payment-list": paymentList
                      });
                    }

                    // Get.toNamed('expensives', arguments: {
                    //   "user": user,
                    //   "categories-list": listCategories,
                    //   "categories-gas": listCategoriesGas,
                    //   "driver": driver,
                    //   "payment-list": paymentList
                    // });
                  } catch (e) {
                    if (!context.mounted) return;
                    ReusableSnackbar.showSnackbar(context, "$e", Colors.red);
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text("Nova Dispesa"),
                shape: const StadiumBorder(
                  side: BorderSide(
                    color: Colors.white, // Cor da borda
                    width: 2.0, // Espessura da borda
                  ),
                ),
              )
            : null);
  }
}

import 'package:app_odometro/constraint/constraint.dart';
import 'package:app_odometro/models/car.dart';
import 'package:app_odometro/models/user.dart';
import 'package:app_odometro/pages/car/car_card.dart';
import 'package:app_odometro/util/providers/car_provider.dart';
import 'package:app_odometro/util/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CarPage extends StatefulWidget {
  const CarPage({super.key});

  @override
  State<CarPage> createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  late User user;
  late ScrollController _scrollController;
  bool _isButtonVisible = true;
  List<Car> cars = [];

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
      final expenseProvider = Provider.of<CarProvider>(context, listen: false);
      if (expenseProvider.hasMore) {
        expenseProvider.fetchCars(user, expenseProvider.currentPage);
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
    final carProvider = Provider.of<CarProvider>(context);
    user = Provider.of<UserProvider>(context).user;
    cars = carProvider.cars;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Registro de Carros",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                "Lista de Carros",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kDefaultColors,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              cars.isNotEmpty
                  ? Flexible(
                      child: ListView.builder(
                          controller: _scrollController,
                          itemCount:
                              cars.length + (carProvider.hasMore ? 1 : 0),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (index == cars.length && carProvider.hasMore) {
                              // Renderiza um widget de carregamento no final
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            Car? car;
                            car = cars[index];

                            print(index);

                            return CarCard(
                              car: car,
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
                  Get.toNamed('expensives', arguments: {"user": user});
                },
                icon: const Icon(Icons.add),
                label: const Text("Novo Carro"),
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

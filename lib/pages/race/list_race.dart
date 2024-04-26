import 'package:app_odometro/constraint/constraint.dart';
import 'package:app_odometro/models/categories.dart';
import 'package:app_odometro/models/driver.dart';
import 'package:app_odometro/models/race.dart';
import 'package:app_odometro/models/user.dart';
import 'package:app_odometro/pages/race/race_card.dart';
import 'package:app_odometro/util/providers/races_provider.dart';
import 'package:app_odometro/util/snackbar.dart';
import 'package:app_odometro/util/util_categories.dart';
import 'package:app_odometro/widgets/label_races.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ListRace extends StatefulWidget {
  const ListRace({super.key});

  @override
  State<ListRace> createState() => _ListRaceState();
}

class _ListRaceState extends State<ListRace> {
  late User user;
  late Driver driver;
  List<Race> races = [];
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final raceProvider = Provider.of<RaceProvider>(context, listen: false);
      if (raceProvider.hasMore) {
        raceProvider.fetchRaces(user, raceProvider.currentPage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final raceProvider = Provider.of<RaceProvider>(context);

    final data = Get.arguments;
    user = data['user'];
    driver = data['driver'];
    races = raceProvider.races;

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
            "Lista de Registros",
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
              const LabelRace(),
              const SizedBox(
                height: 20,
              ),
              races.isNotEmpty
                  ? Flexible(
                      child: ListView.builder(
                          controller: _scrollController,
                          itemCount: raceProvider.races.length +
                              (raceProvider.hasMore ? 1 : 0),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            Race? race;

                            if (index < raceProvider.races.length) {
                              race = races[index];

                              print(index);
                              return RaceCard(
                                race: race,
                              );
                            } else {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 32),
                                child: Center(
                                    child: raceProvider.hasMore
                                        ? const CircularProgressIndicator(
                                            color: kDefaultColors,
                                          )
                                        : const Text("")),
                              );
                            }
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
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: kDefaultColors,
          foregroundColor: kDefaultColorWhite,
          onPressed: () async {
            List<Categories> listCategories = [];

            try {
              listCategories =
                  await CategoriesUtil.getCategories(user, "route");
              Get.toNamed('race', arguments: {
                "user": user,
                "driver": driver,
                "categories-list": listCategories
              });
            } catch (e) {
              ReusableSnackbar.showSnackbar(context, "$e", Colors.red);
            }
          },
          icon: const Icon(Icons.add),
          label: const Text("Nova corrida"),
          shape: const StadiumBorder(
            side: BorderSide(
              color: Colors.white, // Cor da borda
              width: 2.0, // Espessura da borda
            ),
          ),
        ));
  }
}

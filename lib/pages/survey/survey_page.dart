import 'package:app_odometro/models/survey.dart';
import 'package:app_odometro/models/user.dart';
import 'package:app_odometro/pages/survey/survey_card.dart';
import 'package:app_odometro/util/providers/survey_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../constraint/constraint.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({super.key});

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  late ScrollController _scrollController;
  late User user;
  List<Survey> surveys = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final raceProvider = Provider.of<SurveyProvider>(context, listen: false);
      if (raceProvider.hasMore) {
        raceProvider.fetchSurvey(user, raceProvider.currentPage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final surveyProvider = Provider.of<SurveyProvider>(context);

    final data = Get.arguments;
    user = data['user'];
    surveys = surveyProvider.survey;

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
            "Vistoria",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Todos as Vistorias",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kDefaultColors,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            surveys.isNotEmpty
                ? Flexible(
                    child: ListView.builder(
                        controller: _scrollController,
                        itemCount: surveyProvider.survey.length +
                            (surveyProvider.hasMore ? 1 : 0),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Survey? survey;

                          if (index < surveyProvider.survey.length) {
                            survey = surveys[index];
                            return SurveyCard(survey: survey);
                          } else {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 32),
                              child: Center(
                                  child: surveyProvider.hasMore
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
    );
  }
}

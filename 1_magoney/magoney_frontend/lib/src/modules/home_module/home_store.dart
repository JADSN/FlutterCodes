import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:magoney_frontend/src/modules/fc_info_module/fc_info_entity.dart';

import 'home_state.dart';

class HomeStore extends ValueNotifier<HomeState> {
  HomeStore() : super(HomeInitialState()) {
    readCountFc();
  }

  Future<void> readCountFc() async {
    try {
      value = HomeLoadingState(label: "CARREGANDO");

      await Future.delayed(const Duration(seconds: 2));

      value = HomeSuccessState(payload: 2);
    } catch (e) {
      value = HomeErrorState(errorMessage: e.toString());
    }
  }

  Future<void> createFc({required FcInfoEntity payload}) async {
    try {
      value = HomeLoadingState(label: "CARREGANDO");

      await Future.delayed(const Duration(seconds: 2));

      var response = await http.post(
        Uri.parse('http://0.0.0.0:3000/api/fc'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'congregation_name': payload.congregationName,
          'state_name': payload.stateName,
          'city_name': payload.cityName,
          'month': payload.indexMonth,
          'year': payload.year,
        }),
      );

      int responseBodyAffectedRows = int.parse(response.body);
      value = HomeSuccessState(payload: responseBodyAffectedRows);
    } catch (e) {
      log("[ERROR]: ${e.toString()}");
      value = HomeErrorState(errorMessage: e.toString());
    }
  }
}

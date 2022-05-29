import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:magoney_frontend/src/modules/fc_papers_accounts/fc_papers_accounts_state.dart';

import '../fc_info_module/fc_info_entity.dart';

class FcPapersAccountsStore extends ValueNotifier<FcPapersAccountsState> {
  FcPapersAccountsStore() : super(FcPapersAccountsInitialState()) {
    readAll();
  }

  Future<void> readAll() async {
    try {
      value = FcPapersAccountsLoadingState(label: "CARREGANDO");

      await Future.delayed(const Duration(seconds: 2));

      var response = await http.get(
        Uri.parse('http://0.0.0.0:3000/api/fc'),
      );

      var fcs = jsonDecode(response.body) as List<dynamic>;

      var fcsString = fcs
          .map(
            (fc) => fc.toString(),
          )
          .toList();

      log(fcsString.toString());

      value = FcPapersAccountsSuccessState(payload: fcsString);
    } catch (e) {
      log("[ERROR]: ${e.toString()}");
      value = FcPapersAccountsErrorState(errorMessage: e.toString());
    }
  }

  Future<void> createFc({required FcInfoEntity payload}) async {
    try {
      value = FcPapersAccountsLoadingState(label: "CRIANDO");

      await Future.delayed(const Duration(seconds: 2));

      var _ = await http.post(
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

      // int responseBodyAffectedRows = int.parse(response.body);
      await readAll();
    } catch (e) {
      log("[ERROR]: ${e.toString()}");
      value = FcPapersAccountsErrorState(errorMessage: e.toString());
    }
  }
}

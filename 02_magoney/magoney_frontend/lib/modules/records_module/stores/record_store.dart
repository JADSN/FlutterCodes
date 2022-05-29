import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:magoney_frontend/modules/records_module/entities/record_entity.dart';
import 'package:magoney_frontend/modules/records_module/states/record_state.dart';

const String host = "http://0.0.0.0:4000/api";

class RecordStore extends ValueNotifier<RecordState> {
  RecordStore() : super(RecordInitialState()) {
    getAll();
  }

  Future<void> getAll() async {
    value = RecordLoadingState(label: "CARREGANDO");
    await Future.delayed(const Duration(seconds: 1));

    try {
      final response = await http.get(Uri.parse('$host/records'));

      final String responseBody = response.body;
      final reponseJson = jsonDecode(responseBody) as List<dynamic>;
      final List<RecordReadAllEntity> payload =
          reponseJson.map(RecordReadAllEntity.fromMap).toList();

      value = RecordSuccessState(payload: payload.toList());
    } catch (error) {
      value = RecordErrorState(errorMessage: error.toString());
    }
  }

  Future<void> createOne({
    required RecordCreateEntity payload,
  }) async {
    value = RecordLoadingState(label: "CRIANDO");

    await Future.delayed(const Duration(seconds: 1));

    log("[PAYLOAD]: $payload");

    try {
      final bodyEncoded = jsonEncode({
        'record_date': payload.recordDate,
        'description': payload.description,
        'donate_input': payload.donateInput,
        'donate_output': payload.donateOutput,
        'bank_account_input': payload.bankAccountInput,
        'bank_account_output': payload.bankAccountOutput,
        'other_input': payload.otherInput,
        'other_output': payload.otherOutput,
        'symbol': payload.symbol,
      });

      await http.post(
        Uri.parse('$host/records'),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: bodyEncoded,
      );

      await getAll();
    } catch (error) {
      log(error.toString());
      value = RecordErrorState(errorMessage: error.toString());
    }
  }

  Future<void> deleteOneByCode({
    required String code,
  }) async {
    value = RecordLoadingState(label: "DELETANDO");

    await Future.delayed(const Duration(seconds: 1));

    try {
      final response = await http.delete(
        Uri.parse('$host/records/$code'),
      );

      final responseBodyAffectedRows = response.body;
      log(responseBodyAffectedRows.toString());
    } catch (error) {
      log(error.toString());
      value = RecordErrorState(errorMessage: error.toString());
    }
  }

  Future<void> updateOneByCode({
    required String code,
    required RecordUpdateEntity payload,
  }) async {
    value = RecordLoadingState(label: "ATUALIZANDO");

    await Future.delayed(const Duration(seconds: 1));

    final bodyEncoded = jsonEncode({
      'record_date': payload.recordDate,
      'description': payload.description,
      'donate_input': payload.donateInput,
      'donate_output': payload.donateOutput,
      'bank_account_input': payload.bankAccountInput,
      'bank_account_output': payload.bankAccountOutput,
      'other_input': payload.otherInput,
      'other_output': payload.otherOutput,
      'symbol': payload.symbol,
    });

    try {
      final response = await http.put(
        Uri.parse('$host/records/$code'),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: bodyEncoded,
      );

      final responseBodyAffectedRows = response.body;
      log(responseBodyAffectedRows.toString());

      await getAll();
    } catch (error) {
      log(error.toString());
      value = RecordErrorState(errorMessage: error.toString());
    }
  }
}

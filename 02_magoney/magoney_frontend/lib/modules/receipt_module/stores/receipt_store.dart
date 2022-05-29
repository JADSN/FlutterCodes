import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:magoney_frontend/modules/receipt_module/entities/receipt_entity.dart';

import 'package:magoney_frontend/modules/receipt_module/states/receipt_state.dart';

const String host = "http://0.0.0.0:4000/api";

class ReceiptStore extends ValueNotifier<ReceiptState> {
  ReceiptStore() : super(ReceiptInitialState());

  Future<void> getAll() async {
    value = ReceiptLoadingState(label: "CARREGANDO");
    await Future.delayed(const Duration(seconds: 1));

    try {
      final response = await http.get(Uri.parse('$host/receipts'));

      final String responseBody = response.body;
      final reponseJson = jsonDecode(responseBody) as List<dynamic>;
      final List<ReceiptReadAllEntity> payload =
          reponseJson.map(ReceiptReadAllEntity.fromMap).toList();

      value = ReceiptSuccessState(payload: payload.toList());
    } catch (error) {
      value = ReceiptErrorState(errorMessage: error.toString());
    }
  }

  Future<void> getOneByCode({
    required String code,
  }) async {
    // value = ReceiptLoadingState(label: "CARREGANDO");
    await Future.delayed(const Duration(seconds: 1));

    try {
      final response = await http.get(Uri.parse('$host/receipts/$code'));

      final String responseBody = response.body;
      final reponseJson = jsonDecode(responseBody);
      final ReceiptReadOneEntity payload =
          ReceiptReadOneEntity.fromMap(reponseJson);

      log(payload.toString());

      value = ReceiptSuccessReadOneState(payload: payload);
    } catch (error) {
      // value = ReceiptErrorState(errorMessage: error.toString());
    }
  }

  Future<void> createOne({
    required ReceiptCreateEntity payload,
  }) async {
    value = ReceiptLoadingState(label: "CRIANDO");

    await Future.delayed(const Duration(seconds: 1));

    log("[PAYLOAD]: $payload");

    log(payload.toString());

    try {
      final bodyEncoded = jsonEncode({
        'collection_date': payload.collectionDate,
        'donate_world_work': payload.donateWorldWork,
        'local_congregation_expenses': payload.localCongregationExpenses,
        'receipt_type': payload.receiptType,
      });

      final response = await http.post(
        Uri.parse('$host/receipts'),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: bodyEncoded,
      );

      final responseBodyAffectedRows = int.parse(response.body);
      value = ReceiptPayloadInserted(isInserted: responseBodyAffectedRows == 1);
    } catch (error) {
      log(error.toString());
      value = ReceiptErrorState(errorMessage: error.toString());
    }
  }

  Future<void> deleteOneByCode({
    required String code,
  }) async {
    value = ReceiptLoadingState(label: "DELETANDO");

    await Future.delayed(const Duration(seconds: 1));

    try {
      final response = await http.delete(
        Uri.parse('$host/receipts/$code'),
      );

      final responseBodyAffectedRows = response.body;
      log(responseBodyAffectedRows.toString());
    } catch (error) {
      log(error.toString());
      value = ReceiptErrorState(errorMessage: error.toString());
    }
  }

  Future<void> updateOneByCode({
    required String code,
    required ReceiptUpdateEntity payload,
  }) async {
    value = ReceiptLoadingState(label: "ATUALIZANDO");

    await Future.delayed(const Duration(seconds: 1));

    final bodyEncoded = jsonEncode({
      'collection_date': payload.collectionDate,
      'donate_world_work': payload.donateWorldWork,
      'local_congregation_expenses': payload.localCongregationExpenses,
      'receipt_type': payload.receiptType,
    });

    try {
      final response = await http.put(
        Uri.parse('$host/receipts/$code'),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: bodyEncoded,
      );

      final responseBodyAffectedRows = response.body;
      log(responseBodyAffectedRows.toString());
    } catch (error) {
      log(error.toString());
      value = ReceiptErrorState(errorMessage: error.toString());
    }
  }
}

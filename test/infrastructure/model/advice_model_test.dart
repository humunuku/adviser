import 'dart:convert';

import 'package:adviser/domain/entities/advice_entity.dart';
import 'package:adviser/infrastructure/models/advice_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final testAdviceModel = AdviceModel(id: 1, advice: "Test");

  test("adviceModel should be subclass of adviceEntity", () {
    // assert:
    expect(testAdviceModel, isA<AdviceEntity>());
  });

  group("fromJson factory", () {
    test("should return a valid entity if the json advice is correct", () {
      // arrange:
      final Map<String, dynamic> jsonMap = json.decode(fixture("advice.json"));
      // act:
      final result = AdviceModel.fromJson(jsonMap);
      // assert:
      expect(result, testAdviceModel);
    });
  });
}

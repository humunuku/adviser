import 'dart:convert';

import 'package:adviser/domain/entities/advice_entity.dart';
import 'package:adviser/infrastructure/exceptions/exceptions.dart';
import 'package:adviser/infrastructure/models/advice_model.dart';
import 'package:http/http.dart' as http;

abstract class AdviserRemoteDatasource {
  /// Requests a random advice from free api and throws server exception if respond code is not 200.
  Future<AdviceEntity> getRandomAdviceFromApi();
}

class AdviserRemoteDatasourceImpl implements AdviserRemoteDatasource {
  AdviserRemoteDatasourceImpl({required this.client});

  final http.Client client;

  @override
  Future<AdviceEntity> getRandomAdviceFromApi() async {
    final response = await client.get(
      Uri.parse("https://api.adviceslip.com/advice"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      final responseBody = json.decode(response.body);
      return AdviceModel.fromJson(responseBody["slip"]);
    }
  }
}

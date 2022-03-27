import 'package:adviser/infrastructure/datasources/adviser_remote_datasource.dart';
import 'package:adviser/infrastructure/exceptions/exceptions.dart';
import 'package:adviser/infrastructure/models/advice_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';
import 'advice_remote_datasource_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late AdviserRemoteDatasource adviserRemoteDatasource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    adviserRemoteDatasource = AdviserRemoteDatasourceImpl(client: mockClient);
  });

  void setupMockClientSuccess200() async {
    // arrange:
    when(mockClient.get(any, headers: anyNamed("headers"))).thenAnswer(
      (_) async => http.Response(
          fixture(
            "advice_http_response.json",
          ),
          200),
    );
  }

  void setupMockClientFailure404() async {
    // arrange:
    when(mockClient.get(any, headers: anyNamed("headers"))).thenAnswer(
      (_) async => http.Response("Something went wrong.", 404),
    );
  }

  group("getRandomAdviceFromApi", () {
    final testAdviceModel = AdviceModel(id: 1, advice: "Test");

    test(
        "should perform a get request on a URL with advice being the endpoint and header application/json.",
        () {
      // arrange:
      setupMockClientSuccess200();

      // act:
      adviserRemoteDatasource.getRandomAdviceFromApi();

      // assert:
      verify(mockClient.get(
        Uri.parse("https://api.adviceslip.com/advice"),
        headers: {"Content-Type": "application/json"},
      ));
    });

    test("should return a valid advice when response is a success 200.",
        () async {
      // arrange:
      setupMockClientSuccess200();

      // act:
      final result = await adviserRemoteDatasource.getRandomAdviceFromApi();

      // assert:
      verify(mockClient.get(
        Uri.parse("https://api.adviceslip.com/advice"),
        headers: {"Content-Type": "application/json"},
      ));

      expect(result, testAdviceModel);
    });

    test("should throw an exception when response status code is not 200.", () {
      // arrange:
      setupMockClientFailure404();

      // act:
      final call = adviserRemoteDatasource.getRandomAdviceFromApi;

      // assert:
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}

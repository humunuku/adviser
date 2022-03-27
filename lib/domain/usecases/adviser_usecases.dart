import 'package:adviser/domain/entities/advice_entity.dart';
import 'package:adviser/domain/failures/failures.dart';
import 'package:adviser/domain/repositories/adviser_repository.dart';
import 'package:dartz/dartz.dart';

class AdviserUseCases {
  AdviserUseCases(this.adviserRepository);

  final AdviserRepository adviserRepository;

  Future<Either<Failure, AdviceEntity>> getAdviceUseCase() async {
    // Man könnte hier auch die Daten zwischenspeichern,
    // manipulieren und eventuell andere Fehler zurückgeben.
    return adviserRepository.getAdviceFromApi();
  }
}

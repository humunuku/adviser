import 'package:adviser/domain/entities/advice_entity.dart';
import 'package:adviser/domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AdviserRepository {
  Future<Either<Failure, AdviceEntity>> getAdviceFromApi();
}

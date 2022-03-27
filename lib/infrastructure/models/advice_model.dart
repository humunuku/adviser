import 'package:adviser/domain/entities/advice_entity.dart';
import 'package:equatable/equatable.dart';

class AdviceModel extends AdviceEntity with EquatableMixin {
  AdviceModel({required id, required advice}) : super(advice: advice, id: id);

  factory AdviceModel.fromJson(Map<String, dynamic> json) {
    return AdviceModel(
      id: json["id"],
      advice: json["advice"],
    );
  }

  @override
  List<Object?> get props => [id, advice];
}

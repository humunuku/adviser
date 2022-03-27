import 'package:adviser/domain/entities/advice_entity.dart';

class AdviceModel extends AdviceEntity {
  AdviceModel({required id, required advice}) : super(advice: advice, id: id);

  factory AdviceModel.fromJson(Map<String, dynamic> json) {
    return AdviceModel(
      id: json["id"],
      advice: json["advice"],
    );
  }
}

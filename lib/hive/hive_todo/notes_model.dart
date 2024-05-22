
import 'package:hive/hive.dart';
part 'notes_model.g.dart';
@HiveType(typeId:0)
class NotesModel extends HiveObject {
  @HiveField(0)
  String type;
  @HiveField(1)
  String description;
  @HiveField(2)
  String Price;
  @HiveField(3)
  String age;
  @HiveField(4)
  String Color;

  NotesModel({required this.type, required this.description, required this.age,
  required this.Color, required this.Price
  });
}
//flutter packages pub run build_runner build
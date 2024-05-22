
import 'package:hive/hive.dart';

import '../notes_model.dart';

class BoxesNotes {
  static Box<NotesModel> getData()=> Hive.box<NotesModel>('farmapp');

}
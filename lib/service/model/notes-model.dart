// ignore_for_file: file_names

import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/service/model/tasks-model.dart';

@HiveType(typeId: 1)
class Notes {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;

  Notes(this.id, this.title, this.description);
}

class NotesAdapter extends TypeAdapter<Notes> {
  @override
  final int typeId = 1;

  @override
  Notes read(BinaryReader reader) {
    return Notes(reader.readString(), reader.readString(), reader.readString());
  }

  @override
  void write(BinaryWriter writer, Notes obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.description);
  }
}

registerAdapters() {
  Hive.registerAdapter(TasksAdapter());
  Hive.registerAdapter(NotesAdapter());
  Hive.registerAdapter(SingleTaskAdapter());
}

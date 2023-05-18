// ignore_for_file: file_names, camel_case_types

import 'package:hive/hive.dart';

@HiveType(typeId: 2)
class Tasks {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String time;
  @HiveField(3)
  List<singleTask> task;

  Tasks(this.id, this.title, this.time, this.task);

  List<singleTask> get tasks => task;
}

@HiveType(typeId: 5)
class singleTask {
  @HiveField(0)
  String name;
  @HiveField(1)
  bool isDone;

  singleTask(this.name, this.isDone);
}

class SingleTaskAdapter extends TypeAdapter<singleTask> {
  @override
  final typeId =
      5; // Make sure this typeId matches the one specified in the @HiveType annotation

  @override
  singleTask read(BinaryReader reader) {
    final name = reader.read() as String;
    final isDone = reader.read() as bool;
    return singleTask(name, isDone);
  }

  @override
  void write(BinaryWriter writer, singleTask obj) {
    writer.write(obj.name);
    writer.write(obj.isDone);
  }
}

class TasksAdapter extends TypeAdapter<Tasks> {
  @override
  final typeId = 2; // Unique identifier for the Tasks class

  @override
  Tasks read(BinaryReader reader) {
    final id = reader.readString();
    final title = reader.readString();
    final time = reader.readString();
    final taskCount = reader.readInt();

    final tasks = <singleTask>[];
    for (var i = 0; i < taskCount; i++) {
      final name = reader.readString();
      final isDone = reader.readBool();
      tasks.add(singleTask(name, isDone));
    }

    return Tasks(id, title, time, tasks);
  }

  @override
  void write(BinaryWriter writer, Tasks obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.time);
    writer.writeInt(obj.task.length);

    for (final task in obj.task) {
      writer.writeString(task.name);
      writer.writeBool(task.isDone);
    }
  }
}

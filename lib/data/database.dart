import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 50)();
  BoolColumn get isCompleted => boolean().withDefault(Constant(false))();
}

@DriftDatabase(tables: [Tasks])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Task>> getAllTasks() => select(tasks).get();
  Future<int> insertTask(TasksCompanion task) => into(tasks).insert(task);
  Future<int> deleteTask(int id) =>
      (delete(tasks)..where((tbl) => tbl.id.equals(id))).go();

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'task_manage');
  }
}
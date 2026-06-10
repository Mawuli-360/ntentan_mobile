import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

// ── Table: User Profiles ──────────────────────────────────────────────────────

class UserProfiles extends Table {
  TextColumn get uid => text()();
  TextColumn get profileJson => text()();

  @override
  Set<Column> get primaryKey => {uid};
}

// ── Table: MedicationCache ────────────────────────────────────────────────────

/// Caches a user's medication list for offline use.
/// Each row is a single [Medication] JSON blob tied to [ownerUid].
class MedicationCache extends Table {
  /// The unique ID of the medication (matches `Medication.id`).
  TextColumn get id => text()();

  /// The Firebase UID of the user who owns this medication.
  TextColumn get ownerUid => text()();

  /// Full JSON of the `Medication` entity.
  TextColumn get data => text()();

  @override
  Set<Column> get primaryKey => {id, ownerUid};
}

// ── Database ──────────────────────────────────────────────────────────────────

@DriftDatabase(tables: [UserProfiles, MedicationCache])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from == 1) {
            await customStatement('DROP TABLE IF EXISTS users;');
            await m.createTable(userProfiles);
          }
          if (from < 3) {
            await m.createTable(medicationCache);
          }
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../entity/image_entity.dart';

final isarDbProvider = Provider<IsarDb>((ref) {
  return IsarDb();
});


final class IsarDb {

  Future<void> openDb() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {

      await Isar.open(
        [
          ImageEntitySchema,
        ], 
        directory: dir.path,
      );
    }
  }
}
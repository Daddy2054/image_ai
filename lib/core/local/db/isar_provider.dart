
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

final isarProvider = Provider<Isar?>((ref) {
  
  if (Isar.instanceNames.isNotEmpty) {
    return Isar.getInstance();
  }

  return null;
  
});
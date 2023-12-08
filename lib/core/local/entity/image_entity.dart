
import 'package:isar/isar.dart';

part 'image_entity.g.dart';


@collection
final class ImageEntity {
  Id id = Isar.autoIncrement;
  String? image;
  String? dateTime;
  DateTime? timeStamp;
}
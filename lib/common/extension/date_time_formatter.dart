import 'package:jiffy/jiffy.dart';

extension DateTimeFormatter on DateTime {

  String toDateTimeString() => Jiffy.parseFromDateTime(this)
    .format(pattern: 'dd/MM/yyyy h:mm a');
    
}
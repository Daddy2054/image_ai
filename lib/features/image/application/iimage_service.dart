import 'package:multiple_result/multiple_result.dart';

import '../../../common/exception/failure.dart';
import '../domain/image_model.dart';

abstract interface class IIMageService {
  Future<Result<ImageModel, Failure>> generateImage(Map<String, dynamic> body);

  Future<int?> writeToDb<T>(T value);

  Stream<List<ImageModel>> listenImageEntity();
}

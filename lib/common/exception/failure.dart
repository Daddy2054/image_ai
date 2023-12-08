// ignore_for_file: public_member_api_docs, sort_constructors_first


final class Failure implements Exception {

  final String message;
  final int? statusCode;
  final Exception? exception;
  final StackTrace stackTrace;

  Failure({
    required this.message,
    this.statusCode,
    this.exception,
    this.stackTrace = StackTrace.empty
  });
  

  @override
  String toString() {
    return 'Failure(message: $message, statusCode: $statusCode, exception: $exception, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(covariant Failure other) {
    if (identical(this, other)) return true;
  
    return 
      other.message == message &&
      other.statusCode == statusCode &&
      other.exception == exception &&
      other.stackTrace == stackTrace;
  }

  @override
  int get hashCode {
    return message.hashCode ^
      statusCode.hashCode ^
      exception.hashCode ^
      stackTrace.hashCode;
  }
}
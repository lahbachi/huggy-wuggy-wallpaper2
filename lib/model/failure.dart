abstract class Failure {}

class SoketFailure implements Failure {
  SoketFailure(this.message);
  final String? message;

  @override
  String toString() {
    return message ?? "Error SoketExceprion";
  }
}

class HttpFailure implements Failure {
  HttpFailure(this.message);
  String? message;

  @override
  String toString() {
    return message ?? "Error HttpFailure";
  }
}

class FormatFailure implements Failure {
  FormatFailure(this.message);
  String? message;

  @override
  String toString() {
    return message ?? "Error FormatFailure";
  }
}

class OrdersFailure implements Failure {
  OrdersFailure(this.message);
  String? message;

  @override
  String toString() {
    return message ?? "Error OrdersFailure";
  }
}

class DisputeFailure implements Failure {
  DisputeFailure(this.message);
  String? message;

  @override
  String toString() {
    return message ?? "Error DisputeFailure";
  }
}

class StorageFailure implements Failure {
  StorageFailure(this.message);
  String? message;

  @override
  String toString() {
    return message ?? "Error StorageFailure";
  }
}

class AddressFailure implements Failure {
  AddressFailure(this.message);
  String? message;

  @override
  String toString() {
    return message ?? "Error AddressFailure";
  }
}

/// Exceptions

class AppException implements Exception {
  final String _message;
  final String _prefix;

  AppException(this._message, this._prefix);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException(String message)
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException(String message) : super(message, "Invalid Input: ");
}

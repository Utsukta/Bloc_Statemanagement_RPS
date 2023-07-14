// ignore_for_file: public_member_api_docs, sort_constructors_first
//already registerde and tried to register again
class BadRequestException implements Exception {
  String error;
  BadRequestException({
    required this.error,
  });
}

// class UnauthorizedException implements Exception {}

// class NotFoundException implements Exception {}

//mismatched
class UnprocessableEntity implements Exception {
  String error;
  UnprocessableEntity({
    required this.error,
  });
}

class Defaultexception implements Exception {
  String error;
  Defaultexception({
    required this.error,
  });
}

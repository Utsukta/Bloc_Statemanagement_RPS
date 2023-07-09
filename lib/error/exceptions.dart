class BadRequestException implements Exception {
  String errormessage = 'Bad request error';
}

class UnauthorizedException implements Exception {
  String errormessage = 'Unauthorized Error';
}

class NotFoundException implements Exception {
  String errormessage = 'User not found';
}

class ServerErrorException implements Exception {
  String errormessage = 'Server error';
}

class CredentialMismatchedException implements Exception {
  String errormessage = 'credential mismatched';
}

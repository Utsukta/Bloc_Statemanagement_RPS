// import 'package:rpsbloc/error/exceptions.dart';
// import 'package:rpsbloc/loginpage/repository/login_repository.dart';

// class ErrorHandler {
//   final LoginRepository loginRepository;
//   ErrorHandler(this.loginRepository);

//   Future<String> fetchData(String email, String password) async {
//     try {
//       return await loginRepository.loginapi(email, password);
//     } on BadRequestException {
//       return 'Bad Request Error';
//     } on UnauthorizedException {
//       return 'Unauthorized Error';
//     } on NotFoundException {
//       return 'Not Found Error';
//     } on ServerErrorException {
//       return 'Server Error';
//     } on CredentialMismatchedException {
//       return 'Credential Mismatched';
//     } catch (e) {
//       return 'Error: $e';
//     }
//   }
// }

// import 'package:rpsbloc/error/exceptions.dart';
// import 'package:rpsbloc/loginpage/repository/login_repository.dart';

// class ErrorHandler {
//   final LoginRepository loginRepository;

//   ErrorHandler(this.loginRepository);

//   Future<String> fetchData(String email, String password) async {
//     try {
//       return await loginRepository.loginapi(email, password);
//     } catch (e) {
//       if (e is BadRequestException) {
//         throw 'Bad Request Error';
//       } else if (e is UnauthorizedException) {
//         throw 'Unauthorized Error';
//       } else if (e is NotFoundException) {
//         throw 'Not Found Error';
//       } else if (e is ServerErrorException) {
//         throw 'Server Error';
//       } else if (e is CredentialMismatchedException) {
//         throw 'Credential Mismatched';
//       } else {
//         throw 'Error: $e';
//       }
//     }
//   }
// }

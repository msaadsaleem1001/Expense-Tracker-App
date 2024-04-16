class ExpenseExceptions implements Exception{

  final message;
  final prefix;

  ExpenseExceptions([this.message, this.prefix]);
  // AppException([this.message]);


  @override
  String toString(){
    return '$prefix $message';
  }
}

class FetchDataException extends ExpenseExceptions{

  FetchDataException([String? message]) : super(message, 'Error during communication');

}

class BadRequestException extends ExpenseExceptions{

  BadRequestException([String? message]) : super(message, 'Invalid request');

}

class UnauthorizedException extends ExpenseExceptions{

  UnauthorizedException([String? message]) : super(message, 'Unauthorized request');

}

class InvalidInputException extends ExpenseExceptions{

  InvalidInputException([String? message]) : super(message, 'Invalid input');

}

class DataNotFoundException extends ExpenseExceptions{

  DataNotFoundException([String? message]) : super(message, 'Data Not Found');

}

class InvalidScreenRequest extends ExpenseExceptions{

  InvalidScreenRequest([String? message]) : super(message, 'Invalid Screen Request that is not defined');

}
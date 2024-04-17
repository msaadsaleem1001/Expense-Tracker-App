
// Exceptions handling of Expense app.
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

// Fetch data Exception but not using it yet
class FetchDataException extends ExpenseExceptions{

  FetchDataException([String? message]) : super(message, 'Error during communication');

}

// Unauthorized Exception but not using it yet
class UnauthorizedException extends ExpenseExceptions{

  UnauthorizedException([String? message]) : super(message, 'Unauthorized request');

}

// Invalid Input Exception but not using it yet
class InvalidInputException extends ExpenseExceptions{

  InvalidInputException([String? message]) : super(message, 'Invalid input');

}

// Data Not Found Exception but not using it yet
class DataNotFoundException extends ExpenseExceptions{

  DataNotFoundException([String? message]) : super(message, 'Data Not Found');

}

// Invalid Screen Request Exception and we using it in Routing class.
class InvalidScreenRequest extends ExpenseExceptions{

  InvalidScreenRequest([String? message]) : super(message, 'Invalid Screen Request that is not defined');

}
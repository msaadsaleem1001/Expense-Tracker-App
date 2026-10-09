
enum AccountStatus { active, frozen, closed }

mixin Logger {
  final List<String> _logs = [];

  /// Records a message and prints it to the console.
  void log(String message) {
    final entry = '[${runtimeType}] $message';
    _logs.add(entry);
    print(entry);
  }

  /// Read-only view of everything logged so far.
  List<String> get logHistory => List.unmodifiable(_logs);
}

class BankException implements Exception {
  final String message;
  BankException(this.message);

  @override
  String toString() => 'BankException: $message';
}

class User {
  final String id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  @override
  String toString() => 'User($name, $email)';
}

abstract class Account {
  final String accountNumber;
  final User owner;
  AccountStatus status = AccountStatus.active;

  Account(this.accountNumber, this.owner);

  /// Subclasses must expose a balance and implement money movement.
  double get balance;
  void deposit(double amount);
  void withdraw(double amount);
}

class BankAccount extends Account with Logger {
  double _balance = 0; // private (library-private in Dart: underscore prefix)

  /// Default constructor: opens an account with a zero balance.
  BankAccount(super.accountNumber, super.owner);

  /// Named constructor: opens an account with an initial deposit.
  BankAccount.withInitialDeposit(
    super.accountNumber,
    super.owner,
    double initialDeposit,
  ) {
    deposit(initialDeposit);
  }

  /// Getter for the private balance.
  @override
  double get balance => _balance;

  @override
  void deposit(double amount) {
    _ensureActive();
    if (amount <= 0) {
      throw ArgumentError('Deposit amount must be greater than zero.');
    }
    _balance += amount;
    log('Deposited \$${amount.toStringAsFixed(2)}. '
        'Balance: \$${_balance.toStringAsFixed(2)}');
  }

  @override
  void withdraw(double amount) {
    _ensureActive();
    if (amount <= 0) {
      throw ArgumentError('Withdrawal amount must be greater than zero.');
    }
    if (amount > _balance) {
      throw BankException(
        'Insufficient funds: tried to withdraw '
        '\$${amount.toStringAsFixed(2)}, balance is '
        '\$${_balance.toStringAsFixed(2)}.',
      );
    }
    _balance -= amount;
    log('Withdrew \$${amount.toStringAsFixed(2)}. '
        'Balance: \$${_balance.toStringAsFixed(2)}');
  }

  void _ensureActive() {
    if (status != AccountStatus.active) {
      throw BankException('Account $accountNumber is ${status.name}.');
    }
  }

  @override
  String toString() => '$runtimeType($accountNumber, owner: ${owner.name}, '
      'status: ${status.name}, balance: \$${_balance.toStringAsFixed(2)})';
}

void main() {
  final alice = User(id: 'u1', name: 'Alice', email: 'alice@example.com');

  print('--- Regular BankAccount ---');
  final checking = BankAccount.withInitialDeposit('CHK-001', alice, 500);
  checking.deposit(250);
  checking.withdraw(100);
  print('Balance via getter: \$${checking.balance.toStringAsFixed(2)}');

  print('\n--- Error handling ---');
  try {
    checking.withdraw(10000);
  } on BankException catch (e) {
    print('Caught: $e');
  }

  print('\n--- Account status enum ---');
  checking.status = AccountStatus.frozen;
  try {
    checking.deposit(50);
  } on BankException catch (e) {
    print('Caught: $e');
  }
  checking.status = AccountStatus.active;

  print('\n--- Summary ---');
  print(checking);
}

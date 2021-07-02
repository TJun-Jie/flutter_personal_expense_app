import 'package:flutter/material.dart';
import '../widgets/new_transaction.dart';
import '../widgets/transaction_list.dart';
import '../models/transaction.dart';

class UserTransaction extends StatefulWidget {
  const UserTransaction({Key key}) : super(key: key);

  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  void _addNewTransaction(String title, double amount) {
    final newTx = Transaction(
        id: _userTransactions.length.toString(),
        title: title,
        amount: amount,
        date: DateTime.now());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  final List<Transaction> _userTransactions = [
    Transaction(
      id: '1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: '2',
      title: 'Weekly Groceries',
      amount: 32.55,
      date: DateTime.now(),
    ),
    Transaction(
      id: '3',
      title: 'New Phone',
      amount: 1050.99,
      date: DateTime.now(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(
          addNewTransaction: _addNewTransaction,
        ),
        TransactionList(
          userTransactions: _userTransactions,
        ),
      ],
    );
  }
}

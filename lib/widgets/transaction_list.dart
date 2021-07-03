import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  TransactionList({Key key, this.userTransactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
              child: Row(
            children: [
              Container(
                constraints: BoxConstraints(minWidth: 100, maxWidth: 160),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                )),
                child: Text(
                  '\$${userTransactions[index].amount.toStringAsFixed(2)}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).primaryColor),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userTransactions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  Text(
                    DateFormat('MMM d, y hh:mm aaa')
                        .format(userTransactions[index].date),
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ],
          ));
        },
        itemCount: userTransactions.length,
      ),
    );
  }
  //

}

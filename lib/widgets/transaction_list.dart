import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteTransactions;
  TransactionList({Key key, this.userTransactions, this.deleteTransactions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: userTransactions.isEmpty
          ? Column(
              children: [
                Text('No transactions added yet!',
                    style: Theme.of(context).textTheme.title),
                SizedBox(
                  height: 30,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text(
                              '\$${userTransactions[index].amount.toStringAsFixed(2)}',
                            ),
                          ),
                        )),
                    title: Text(userTransactions[index].title,
                        style: Theme.of(context).textTheme.title),
                    subtitle: Text(
                      DateFormat('MMM d, y ')
                          .format(userTransactions[index].date),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () =>
                          deleteTransactions(userTransactions[index].id),
                    ),
                  ),
                );

                // return Card(
                //     child: Row(
                //   children: [
                //     Container(
                //       constraints: BoxConstraints(minWidth: 100, maxWidth: 160),
                //       padding: EdgeInsets.all(10),
                //       margin:
                //           EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                //       decoration: BoxDecoration(
                //           border: Border.all(
                //         color: Theme.of(context).primaryColor,
                //         width: 2,
                //       )),
                //       child: Text(
                //         '\$${userTransactions[index].amount.toStringAsFixed(2)}',
                //         textAlign: TextAlign.center,
                //         style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 20,
                //             color: Theme.of(context).primaryColor),
                //       ),
                //     ),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           userTransactions[index].title,
                //           style: Theme.of(context).textTheme.title,
                //         ),
                //         Text(
                //           DateFormat('MMM d, y hh:mm aaa')
                //               .format(userTransactions[index].date),
                //           style: TextStyle(
                //             color: Colors.grey,
                //           ),
                //         )
                //       ],
                //     ),
                //   ],
                // ));
              },
              itemCount: userTransactions.length,
            ),
    );
  }
  //

}

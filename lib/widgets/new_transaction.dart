import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  NewTransaction({Key key, this.addNewTransaction}) : super(key: key);
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function addNewTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
            ),

            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () => {
                addNewTransaction(
                    titleController.text, double.parse(amountController.text))
              },
              child: Text('Add Transaction'),
              textColor: Colors.purple,
            )
          ],
        ),
      ),
    );
  }
  //
}

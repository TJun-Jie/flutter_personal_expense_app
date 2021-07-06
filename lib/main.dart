import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expenses_app/widgets/chart.dart';
import 'package:personal_expenses_app/widgets/new_transaction.dart';
import 'package:personal_expenses_app/widgets/transaction_list.dart';
import './models/transaction.dart';

void main() {
  // For landscape mode
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              button: TextStyle(color: Colors.white),
            ),
        fontFamily: 'QuickSand',
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ))),
      ),
      home: MyHomePage(title: 'Personal Expenses App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = true;

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
        id: _userTransactions.length.toString(),
        title: title,
        amount: amount,
        date: chosenDate);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: '1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: '2',
    //   title: 'Weekly Groceries',
    //   amount: 32.55,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: '3',
    //   title: 'New Phone',
    //   amount: 1050.99,
    //   date: DateTime.now(),
    // ),
  ];

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(addNewTransaction: _addNewTransaction);
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final appBar = AppBar(
      title: Text(widget.title),
      actions: [
        IconButton(
            onPressed: () => {_startAddNewTransaction(context)},
            icon: Icon(Icons.add)),
      ],
    );
    final appBarHeight = appBar.preferredSize.height;
    final statusBar = mediaQuery.padding.top;

    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final txListWidget = Container(
      height: (mediaQuery.size.height - appBarHeight - statusBar) * 0.7,
      child: TransactionList(
        userTransactions: _userTransactions,
        deleteTransactions: _deleteTransaction,
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show Chart'),
                  Switch(
                    value: _showChart,
                    onChanged: (value) {
                      setState(() {
                        _showChart = value;
                      });
                    },
                  )
                ],
              ),
            if (!isLandscape)
              Container(
                height:
                    (mediaQuery.size.height - appBarHeight - statusBar) * 0.25,
                child: Chart(
                  recentTransactions: _recentTransactions,
                ),
              ),
            if (!isLandscape) txListWidget,
            if (isLandscape)
              _showChart
                  ? Container(
                      height:
                          (mediaQuery.size.height - appBarHeight - statusBar) *
                              0.7,
                      child: Chart(
                        recentTransactions: _recentTransactions,
                      ),
                    )
                  : txListWidget
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {_startAddNewTransaction(context)},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

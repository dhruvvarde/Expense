import 'package:expenses/constants/colors.dart';
import 'package:flutter/material.dart';
import '../ui/bar_chart.dart';
import '../constants/font_family.dart';
import '../constants/strings.dart';
import '../local_database/database_helper.dart';
import '../local_database/models/expense.dart';
import '../utils/util.dart';

class ExpenseList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExpenseList();
  }
}

class _ExpenseList extends State<ExpenseList> {
  List<Expense> _expenseList = List();
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController selectedDate1 = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final dbHelper = DatabaseHelper.instance;
  DateTime today = DateTime.now();
  DateTime mon, tue, wed, thu, fri, sat, sun;
  double barMon = 0,
      barTue = 0,
      barwed = 0,
      barThu = 0,
      barFri = 0,
      barsat = 0,
      barSun = 0;
  var now = DateTime.now();

  @override
  void initState() {
    super.initState();
    weekDay();
    getDataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.strExpenses),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 30),
              color: AppColors.greyBackground,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  BarChart(barMon / 100, 'Mo.'),
                  BarChart(barTue / 100, 'Tue.'),
                  BarChart(barwed / 100, 'Wed.'),
                  BarChart(barThu / 100, 'Th.'),
                  BarChart(barFri / 100, 'Fr.'),
                  BarChart(barsat / 100, 'Sat.'),
                  BarChart(barSun / 100, 'Sun.'),
                ],
              ),
            ),
            expenseListView()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.blue,
        onPressed: addExpenseBottomSheet,
        child: Icon(
          Icons.add,
          color: AppColors.black,
        ),
      ),
    );
  }

  void addExpenseBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return Container(
            padding: EdgeInsets.all(20),
            child: Wrap(
              children: <Widget>[
                Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              Strings.strSelectDate,
                              style: FontFamily.greyTitle,
                            ),
                            InkWell(
                              child: Text(
                                // Utils.getFormatDate(selectedDate),
                                Strings.strSelectDateCaps,
                                style: FontFamily.blueTitleMedium,
                              ),
                              onTap: () {
                                openDatePicker(context);
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          style: FontFamily.greyTitle,
                          controller: nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: Strings.strExpenseTitle,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          style: FontFamily.greyTitle,
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: Strings.strAmount,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                            width: 190,
                            child: RaisedButton(
                              color: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                insert();
                              },
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      Strings.strAddExpense,
                                      textAlign: TextAlign.center,
                                      style: FontFamily.whiteTitleMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          );
        });
  }

  // insert date
  void insert() async {
    Expense newExpense = Expense(
        title: nameController.text,
        amount: double.parse(amountController.text),
        dateis: Utils.formatDate(selectedDate));
    var data = await dbHelper.insert(newExpense);
    // ignore: avoid_print
    print(data.title);
    setState(() => {_expenseList.add(data), filterData()});
  }

  // get data from Database
  void getDataList() async {
    _expenseList = (await dbHelper.getAllData()).cast<Expense>();
    filterData();
    setState(() {});
  }

  //open DatePicker
  // ignore: always_declare_return_types
  openDatePicker(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: mon, //Minimum Date
      lastDate: sun, //Maximum Date
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Widget expenseListView() {
    return Expanded(
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: _expenseList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          // ignore: missing_return
          return Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: <Widget>[
                            Text(
                              '\$',
                              textAlign: TextAlign.center,
                              style: FontFamily.greyTitleLarge,
                            ),
                            SizedBox(
                              width: 35,
                            ),
                            Text(
                              _expenseList[index].title,
                              textAlign: TextAlign.center,
                              style: FontFamily.greyTitle,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              _expenseList[index].dateis,
                              textAlign: TextAlign.center,
                              style: FontFamily.greyDate,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              '\$' + _expenseList[index].amount.toString(),
                              textAlign: TextAlign.center,
                              style: FontFamily.greyTitleMedium,
                            ),
                          ],
                        ),
                      ]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ignore: always_declare_return_types
  weekDay() {
    int today = now.weekday;
    var dayNr = (today + 6) % 7;
    mon = now.subtract(Duration(days: dayNr));
    tue = mon.add(Duration(days: 1));
    wed = mon.add(Duration(days: 2));
    thu = mon.add(Duration(days: 3));
    fri = mon.add(Duration(days: 4));
    sat = mon.add(Duration(days: 5));
    sun = mon.add(Duration(days: 6));
  }

  // ignore: always_declare_return_types
  filterData() {
    barMon = getWeeklyData(barMon, mon);
    barTue = getWeeklyData(barTue, tue);
    barwed = getWeeklyData(barwed, wed);
    barThu = getWeeklyData(barThu, thu);
    barFri = getWeeklyData(barFri, fri);
    barsat = getWeeklyData(barsat, sat);
    barSun = getWeeklyData(barSun, sun);
  }

  double getWeeklyData(double weekDay, DateTime date) {
    weekDay=0;
    var weekRecoard = _expenseList
        .where((element) => element.dateis == Utils.formatDate(date));
    weekRecoard.forEach((element) {
      weekDay = weekDay + element.amount;
    });
    return weekDay;
  }
}

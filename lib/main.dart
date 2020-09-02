import 'package:expenses/constants/colors.dart';
import 'package:expenses/ui/expense_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(primaryColor: AppColors.primaryColor),
      home: new ExpenseList(),
    );
  }
}


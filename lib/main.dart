import 'package:flutter/material.dart';
import './constants/colors.dart';
import './ui/expense_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: AppColors.primaryColor),
      home:  ExpenseList(),
    );
  }
}


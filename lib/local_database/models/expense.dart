import 'package:expenses/utils/Utils.dart';

class Expense {
   int id;
   String title;
   String  amount;
   String dateis;
  Expense({this.id, this.title, this.amount,this.dateis});
  Map<String, dynamic> toMap() {
    return {'title': title, 'amount': amount,'dateis':dateis};
  }

   factory Expense.fromMap(dynamic map) {
     return Expense(
       id: map['_id'] as int,
       title: map['title'] as String,
       amount: map['amount'] as String,
       dateis: map['dateis'] as String,
     );
   }

}

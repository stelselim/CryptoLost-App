import 'package:intl/intl.dart';

var formatMoney = (num money) => NumberFormat.currency(name: "").format(money);

import 'package:intl/intl.dart';

String formatMoney(num money) => NumberFormat.currency(name: "").format(money);

import 'package:intl/intl.dart';

String formatDate(DateTime dateTime) =>
    DateFormat("dd-MM-yyyy").format(dateTime);

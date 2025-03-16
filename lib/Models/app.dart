import 'dart:ui';

class App {
  final String appName;
  final String appIcon;
  final Color appColor;
  final double appMonthlyPrice;
  final double totalPrice;
  final String moneyType;
  final String paymentMethod;
  final String startDay;

  App({
    required this.appName,
    required this.appIcon,
    required this.appColor,
    required this.appMonthlyPrice,
    required this.totalPrice,
    required this.moneyType,
    required this.paymentMethod,
    required this.startDay,
  });
}

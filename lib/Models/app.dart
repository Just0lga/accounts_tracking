import 'dart:convert';
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

  // JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'appName': appName,
      'appIcon': appIcon,
      'appColor': appColor.value, // Color değerini integer olarak kaydet
      'appMonthlyPrice': appMonthlyPrice,
      'totalPrice': totalPrice,
      'moneyType': moneyType,
      'paymentMethod': paymentMethod,
      'startDay': startDay,
    };
  }

  // JSON'dan App nesnesine dönüştürme
  factory App.fromJson(Map<String, dynamic> json) {
    return App(
      appName: json['appName'],
      appIcon: json['appIcon'],
      appColor: Color(
        json['appColor'],
      ), // Kaydedilen integer değeri Color'a dönüştür
      appMonthlyPrice: json['appMonthlyPrice'].toDouble(),
      totalPrice: json['totalPrice'].toDouble(),
      moneyType: json['moneyType'],
      paymentMethod: json['paymentMethod'],
      startDay: json['startDay'],
    );
  }
}

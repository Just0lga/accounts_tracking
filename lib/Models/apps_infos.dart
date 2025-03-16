import 'package:accounts_tracking/Models/app.dart';
import 'package:flutter/material.dart';

class AppsInfos {
  static final List<App> apps = [
    App(
      appName: "Spotify",
      appIcon: "images/spotify.png",
      appColor: Color(0xFF1DB954),
      appMonthlyPrice: 0,
      totalPrice: 1000,
      moneyType: "\$",
      paymentMethod: "",
      startDay: "24 February 2021",
    ),
    App(
      appName: "Netflix",
      appIcon: "images/netflix.png",
      appColor: Colors.red,
      appMonthlyPrice: 0,
      totalPrice: 0,
      moneyType: "",
      paymentMethod: "",
      startDay: "24 February 2021",
    ),
    App(
      appName: "Canva",
      appIcon: "images/canva.webp",
      appColor: Colors.blue,
      appMonthlyPrice: 0,
      totalPrice: 0,
      moneyType: "",
      paymentMethod: "",
      startDay: "24 February 2021",
    ),
    App(
      appName: "Bein Connect",
      appIcon: "images/bein_connect.jpg",
      appColor: Color(0xFF5c2d91),
      appMonthlyPrice: 0,
      totalPrice: 0,
      moneyType: "",
      paymentMethod: "",
      startDay: "24 June 2021",
    ),
    App(
      appName: "Amazon Prime",
      appIcon: "images/amazon.webp",
      appColor: Color(0xFFf8981d),
      appMonthlyPrice: 0,
      totalPrice: 0,
      moneyType: "",
      paymentMethod: "",
      startDay: "24 September 2021",
    ),
  ];

  static void updateApp(App updatedApp) {
    for (int i = 0; i < apps.length; i++) {
      if (apps[i].appName == updatedApp.appName) {
        apps[i] = updatedApp;
        break;
      }
    }
  }
}

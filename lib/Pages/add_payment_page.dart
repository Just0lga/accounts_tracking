import 'dart:convert';

import 'package:accounts_tracking/Models/app.dart';
import 'package:accounts_tracking/Pages/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPaymentPage extends StatefulWidget {
  const AddPaymentPage({super.key, required this.app});
  final App app;

  @override
  State<AddPaymentPage> createState() => _AddPaymentPageState();
}

class _AddPaymentPageState extends State<AddPaymentPage> {
  final List<String> days = List.generate(
    31,
    (index) => (index + 1).toString(),
  );

  final List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  final List<String> years = List.generate(
    31,
    (index) => (2020 + index).toString(),
  );

  final List<String> moneyType = ["₺", "\$", "€", "£"];

  final List<int> money1 = List.generate(5000, (index) => index);

  final List<int> money2 = List.generate(100, (index) => index);

  final List<String> paymentMethod = [
    "Daily",
    "Weekly",
    "Monthly",
    "Yearly",
    "Once",
  ];

  int selectedDay = 14;
  int selectedMonth = 5;
  int selectedYear = 5;

  int selectedMoneyType = 1;
  int selectedMoney1 = 1;
  int selectedMoney2 = 1;
  int selectedPaymentMethod = 1;

  late FixedExtentScrollController dayController;
  late FixedExtentScrollController monthController;
  late FixedExtentScrollController yearController;

  late FixedExtentScrollController moneyTypeController;
  late FixedExtentScrollController money1Controller;
  late FixedExtentScrollController money2Controller;
  late FixedExtentScrollController paymentMethodController;

  // Selected apps
  List<App> selected_apps = [];
  App selected_app = App(
    appName: "appName",
    appIcon: "appIcon",
    appColor: Colors.white,
    appMonthlyPrice: 0,
    totalPrice: 0,
    moneyType: "moneyType",
    paymentMethod: "paymentMethod",
    startDay: "startDay",
  );

  Future<void> saveSelectedApp(App app) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Mevcut listeyi al, yoksa boş bir liste oluştur
    List<String> appList = prefs.getStringList("selected_apps") ?? [];

    // Yeni app'i JSON formatına çevir
    String appJson = jsonEncode(app.toJson());

    // Eğer zaten ekli değilse listeye ekle
    if (!appList.contains(appJson)) {
      appList.add(appJson);
      await prefs.setStringList("selected_apps", appList);
      print("Yeni uygulama eklendi: ${prefs.getStringList("selected_apps")}");
    } else {
      print("Bu uygulama zaten kayıtlı.");
    }
  }

  Future<void> loadSelectedApps() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Kaydedilmiş listeyi al
    List<String>? appList = prefs.getStringList("selected_apps");

    if (appList != null) {
      setState(() {
        selected_apps =
            appList
                .map((appJson) => App.fromJson(jsonDecode(appJson)))
                .toList();
      });
      print("Yüklenen uygulamalar: $selected_apps");
    } else {
      print("Henüz kayıtlı uygulama yok.");
    }
  }

  @override
  void initState() {
    super.initState();
    selected_app = widget.app;
    //Apps
    loadSelectedApps();
    //Date
    dayController = FixedExtentScrollController(initialItem: selectedDay);
    monthController = FixedExtentScrollController(initialItem: selectedMonth);
    yearController = FixedExtentScrollController(initialItem: selectedYear);
    //Money and type
    moneyTypeController = FixedExtentScrollController(
      initialItem: selectedMoneyType,
    );
    money1Controller = FixedExtentScrollController(initialItem: selectedMoney1);
    money2Controller = FixedExtentScrollController(initialItem: selectedMoney2);
    paymentMethodController = FixedExtentScrollController(
      initialItem: selectedPaymentMethod,
    );
  }

  @override
  void dispose() {
    dayController.dispose();
    monthController.dispose();
    yearController.dispose();
    moneyTypeController.dispose();
    money1Controller.dispose();
    money2Controller.dispose();
    paymentMethodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.01,
          ),
          child: ListView(
            padding: EdgeInsets.only(top: height * 0.05),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: height * 0.06,
                    width: height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(height * 0.03),
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 32,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: height * 0.03),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    width: width * 0.45,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(widget.app.appIcon, height: height * 0.08),
                        SizedBox(height: height * 0.01),
                        Text(
                          widget.app.appName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: widget.app.appColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              Text(
                "Select the payment method",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // PICKER 1
              Container(
                height: height * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withOpacity(0.7),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Money 1
                    SizedBox(
                      width: width * 0.2,
                      child: CupertinoPicker(
                        scrollController: money1Controller,
                        itemExtent: 40,
                        onSelectedItemChanged: (index) {
                          setState(() {
                            selectedMoney1 = index;
                          });
                        },
                        children:
                            money1
                                .map(
                                  (money1) => Center(
                                    child: Text(
                                      money1.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                    Text(
                      ",",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //Money 2
                    SizedBox(
                      width: width * 0.2,
                      child: CupertinoPicker(
                        scrollController: money2Controller,
                        itemExtent: 40,
                        onSelectedItemChanged: (index) {
                          setState(() {
                            selectedMoney2 = index;
                          });
                        },
                        children:
                            money2
                                .map(
                                  (money2) => Center(
                                    child: Text(
                                      money2.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                    // Money Type Picker
                    SizedBox(
                      width: width * 0.2, // Genişliği manuel ayarladım
                      child: CupertinoPicker(
                        scrollController: moneyTypeController,
                        itemExtent: 40,
                        onSelectedItemChanged: (index) {
                          setState(() {
                            selectedMoneyType = index;
                          });
                        },
                        children:
                            moneyType
                                .map(
                                  (moneyType) => Center(
                                    child: Text(
                                      moneyType,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                    // Payment Method
                    SizedBox(
                      width: width * 0.3,
                      child: CupertinoPicker(
                        scrollController: paymentMethodController,
                        itemExtent: 40,
                        onSelectedItemChanged: (index) {
                          setState(() {
                            selectedPaymentMethod = index;
                          });
                        },
                        children:
                            paymentMethod
                                .map(
                                  (paymentMethod) => Center(
                                    child: Text(
                                      paymentMethod.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.01),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Select the start date",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: height * 0.01),
              // PICKER 2
              Container(
                height: height * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withOpacity(0.7),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Day Picker
                    SizedBox(
                      width: width * 0.3, // Genişliği manuel ayarladım
                      child: CupertinoPicker(
                        scrollController: dayController,
                        itemExtent: 40,
                        onSelectedItemChanged: (index) {
                          setState(() {
                            selectedDay = index;
                          });
                        },
                        children:
                            days
                                .map(
                                  (day) => Center(
                                    child: Text(
                                      day,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),

                    // Month Picker
                    SizedBox(
                      width: width * 0.3,
                      child: CupertinoPicker(
                        scrollController: monthController,
                        itemExtent: 40,
                        onSelectedItemChanged: (index) {
                          setState(() {
                            selectedMonth = index;
                          });
                        },
                        children:
                            months
                                .map(
                                  (month) => Center(
                                    child: Text(
                                      month,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),

                    // Year Picker
                    SizedBox(
                      width: width * 0.3,
                      child: CupertinoPicker(
                        scrollController: yearController,
                        itemExtent: 40,
                        onSelectedItemChanged: (index) {
                          setState(() {
                            selectedYear = index;
                          });
                        },
                        children:
                            years
                                .map(
                                  (year) => Center(
                                    child: Text(
                                      year,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.02),
              GestureDetector(
                onTap: () {
                  setState(() {
                    App selected_app = App(
                      appName: widget.app.appName,
                      appIcon: widget.app.appIcon,
                      appColor: widget.app.appColor,
                      appMonthlyPrice: double.parse(
                        money1[selectedMoney1].toString() +
                            "." +
                            money2[selectedMoney2].toString(),
                      ),
                      totalPrice: double.parse(
                        money1[selectedMoney1].toString() +
                            "." +
                            money2[selectedMoney2].toString(),
                      ),
                      moneyType: moneyType[selectedMoneyType],
                      paymentMethod: paymentMethod[selectedPaymentMethod],
                      startDay:
                          days[selectedDay] +
                          " " +
                          months[selectedMonth] +
                          " " +
                          years[selectedYear],
                    );
                  });
                  saveSelectedApp(selected_app);
                  print("Saved${selected_app.toJson()}");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Homepage()),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: height * 0.06,
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}

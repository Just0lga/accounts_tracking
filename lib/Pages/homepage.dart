import 'dart:convert';

import 'package:accounts_tracking/Models/app.dart';
import 'package:accounts_tracking/Pages/apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<App> selected_apps = [];

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
    // TODO: implement initState
    super.initState();
    loadSelectedApps();
    print("savedApps: ${selected_apps.length}");
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.07),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Monthly payment",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      const Text(
                        "580.42 ₺",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Apps()),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                      height: height * 0.05,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Add new payment",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: selected_apps.length,
                  itemBuilder: (context, index) {
                    final app = selected_apps[index];
                    print("${app.appName}XXX");
                    return selected_apps.isEmpty
                        ? Center(child: Text("No app added yet."))
                        : Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: height * 0.005,
                          ),
                          child: Container(
                            height: height * 0.15,
                            width: width,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: app.appColor, width: 1),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: height * 0.3,
                                  width: width * 0.24,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "${app.appIcon}",
                                        height: height * 0.07,
                                      ),
                                      Text(
                                        textAlign: TextAlign.center,
                                        app.appName,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 10),
                                  alignment: Alignment.center,
                                  height: height * 0.3,
                                  width: width * 0.70,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Monthly payment",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                app.appMonthlyPrice.toString() +
                                                    " " +
                                                    app.moneyType,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: width * 0.06),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "This year payment",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                app.totalPrice.toString() +
                                                    " " +
                                                    app.moneyType,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: height * 0.01),
                                      const Text(
                                        "Payment Day",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        app.startDay,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

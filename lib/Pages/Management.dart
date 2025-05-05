import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:ui';

// App Modeli (JSON Dönüştürme İçin)
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

  // App'i JSON formatına çevir
  Map<String, dynamic> toJson() {
    return {
      'appName': appName,
      'appIcon': appIcon,
      'appColor': appColor.value, // Color'ı integer olarak sakla
      'appMonthlyPrice': appMonthlyPrice,
      'totalPrice': totalPrice,
      'moneyType': moneyType,
      'paymentMethod': paymentMethod,
      'startDay': startDay,
    };
  }

  // JSON'dan App nesnesine dönüştür
  factory App.fromJson(Map<String, dynamic> json) {
    return App(
      appName: json['appName'],
      appIcon: json['appIcon'],
      appColor: Color(json['appColor']),
      appMonthlyPrice: json['appMonthlyPrice'].toDouble(),
      totalPrice: json['totalPrice'].toDouble(),
      moneyType: json['moneyType'],
      paymentMethod: json['paymentMethod'],
      startDay: json['startDay'],
    );
  }
}

class AppManagerPage extends StatefulWidget {
  @override
  _AppManagerPageState createState() => _AppManagerPageState();
}

class _AppManagerPageState extends State<AppManagerPage> {
  List<App> selectedApps = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String selectedAppName = ""; // Seçilen uygulamanın adını tut

  @override
  void initState() {
    super.initState();
    _loadSelectedApps();
  }

  // Kayıtlı Uygulamaları Yükleme
  Future<void> _loadSelectedApps() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? appJsonList = prefs.getStringList('selected_apps');

    if (appJsonList != null) {
      setState(() {
        selectedApps =
            appJsonList
                .map((jsonString) => App.fromJson(jsonDecode(jsonString)))
                .toList();
      });
    }
  }

  // Uygulamaları Kaydetme
  Future<void> _saveSelectedApps() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> appJsonList =
        selectedApps.map((app) => jsonEncode(app.toJson())).toList();
    await prefs.setStringList('selected_apps', appJsonList);
  }

  // Uygulama Ekle veya Güncelle
  void _addOrUpdateApp() {
    String appName = nameController.text;
    double price = double.tryParse(priceController.text) ?? 0.0;

    if (appName.isEmpty) return;

    setState(() {
      int existingIndex = selectedApps.indexWhere(
        (app) => app.appName == appName,
      );
      if (existingIndex != -1) {
        // Güncelleme yap
        selectedApps[existingIndex] = App(
          appName: appName,
          appIcon: "images/default.png",
          appColor: Colors.blue,
          appMonthlyPrice: price,
          totalPrice: price * 12,
          moneyType: "\$",
          paymentMethod: "Credit Card",
          startDay: "Today",
        );
      } else {
        // Yeni ekleme
        selectedApps.add(
          App(
            appName: appName,
            appIcon: "images/default.png",
            appColor: Colors.blue,
            appMonthlyPrice: price,
            totalPrice: price * 12,
            moneyType: "\$",
            paymentMethod: "Credit Card",
            startDay: "Today",
          ),
        );
      }
      _saveSelectedApps();
    });

    // Formu temizle
    nameController.clear();
    priceController.clear();
    selectedAppName = "";
  }

  // Uygulama Seçildiğinde Formu Doldur
  void _editApp(App app) {
    setState(() {
      nameController.text = app.appName;
      priceController.text = app.appMonthlyPrice.toString();
      selectedAppName = app.appName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Uygulama Yönetimi")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 📌 Form Alanı
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Uygulama Adı"),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: "Aylık Ücret"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addOrUpdateApp,
              child: Text(selectedAppName.isEmpty ? "Kaydet" : "Güncelle"),
            ),
            SizedBox(height: 20),
            Divider(),
            Text(
              "Kaydedilen Uygulamalar",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child:
                  selectedApps.isEmpty
                      ? Center(child: Text("Henüz uygulama eklenmedi."))
                      : ListView.builder(
                        itemCount: selectedApps.length,
                        itemBuilder: (context, index) {
                          final app = selectedApps[index];
                          return Card(
                            child: ListTile(
                              leading: Image.asset(
                                app.appIcon,
                                width: 40,
                                height: 40,
                              ),
                              title: Text(app.appName),
                              subtitle: Text(
                                "Fiyat: ${app.moneyType}${app.appMonthlyPrice.toStringAsFixed(2)}",
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _editApp(app),
                              ),
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}

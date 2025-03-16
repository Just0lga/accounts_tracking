import 'package:accounts_tracking/Models/app.dart';
import 'package:accounts_tracking/Models/apps_infos.dart';
import 'package:accounts_tracking/Pages/add_payment_page.dart';
import 'package:flutter/material.dart';

class Apps extends StatefulWidget {
  const Apps({super.key});

  @override
  State<Apps> createState() => _AppsState();
}

class _AppsState extends State<Apps> {
  List<App> filteredApps = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredApps = List.from(
      AppsInfos.apps,
    ); // Başlangıçta tüm uygulamaları göster
  }

  void filterApps(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredApps = List.from(AppsInfos.apps);
      } else {
        filteredApps =
            AppsInfos.apps
                .where(
                  (app) =>
                      app.appName.toLowerCase().contains(query.toLowerCase()),
                )
                .toList();
      }
    });
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
          padding: EdgeInsets.symmetric(
            vertical: height * 0.06,
            horizontal: width * 0.02,
          ),
          child: Column(
            children: [
              // Geri Butonu
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
              SizedBox(height: height * 0.04),

              // Arama Çubuğu
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: filterApps,
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: const TextStyle(color: Colors.black),
                    border: InputBorder.none,
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),

              // Uygulama Listesi
              Expanded(
                child: ListView.builder(
                  itemCount: (filteredApps.length / 3).ceil(),
                  itemBuilder: (context, index) {
                    int startIndex = index * 3;
                    int endIndex =
                        (startIndex + 3 < filteredApps.length)
                            ? startIndex + 3
                            : filteredApps.length;
                    List<App> rowApps = filteredApps.sublist(
                      startIndex,
                      endIndex,
                    );

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:
                            rowApps.map((app) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => AddPaymentPage(app: app),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: width * 0.3,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: app.appColor),
                                    color: Colors.black.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        height: height * 0.09,
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          app.appIcon,
                                          height: height * 0.08,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height: height * 0.06,
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          app.appName,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
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

import 'package:accounts_tracking/Models/apps_infos.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSelectionPage extends StatefulWidget {
  const AppSelectionPage({super.key});

  @override
  State<AppSelectionPage> createState() => _AppSelectionPageState();
}

class _AppSelectionPageState extends State<AppSelectionPage> {
  List<String> selectedApps = []; // Seçilen uygulamalar listesi

  @override
  void initState() {
    super.initState();
    _loadSelectedApps(); // Uygulama açıldığında kayıtlı veriyi yükle
  }

  // 📌 Seçilen uygulamaları SharedPreferences'a kaydet
  Future<void> _saveSelectedApps() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('selected_apps', selectedApps);
  }

  // 📌 Kayıtlı uygulamaları yükle
  Future<void> _loadSelectedApps() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedApps = prefs.getStringList('selected_apps') ?? [];
    });
  }

  // 📌 Uygulama seçme/kaldırma
  void _toggleSelection(String appName) {
    setState(() {
      if (selectedApps.contains(appName)) {
        selectedApps.remove(appName);
      } else {
        selectedApps.add(appName);
      }
      _saveSelectedApps(); // Güncellenen listeyi kaydet
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Apps")),
      body: ListView.builder(
        itemCount: AppsInfos.apps.length,
        itemBuilder: (context, index) {
          final app = AppsInfos.apps[index];
          final isSelected = selectedApps.contains(app.appName);

          return ListTile(
            leading: Image.asset(app.appIcon, width: 40), // Uygulama ikonu
            title: Text(app.appName), // Uygulama adı
            trailing: Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? Colors.green : Colors.grey,
            ),
            onTap: () {
              _toggleSelection(app.appName);
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPaymentPage extends StatefulWidget {
  const AddPaymentPage({super.key});

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

  int selectedDay = 14;
  int selectedMonth = 5;
  int selectedYear = 5;

  late FixedExtentScrollController dayController;
  late FixedExtentScrollController monthController;
  late FixedExtentScrollController yearController;

  @override
  void initState() {
    super.initState();
    dayController = FixedExtentScrollController(initialItem: selectedDay);
    monthController = FixedExtentScrollController(initialItem: selectedMonth);
    yearController = FixedExtentScrollController(initialItem: selectedYear);
  }

  @override
  void dispose() {
    dayController.dispose();
    monthController.dispose();
    yearController.dispose();
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
                        const CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage("images/spotify.png"),
                        ),
                        Text(
                          "Spotify",
                          style: TextStyle(
                            color: Color(0xFF1ED760),
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Choose your payment method",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              for (int i = 0; i < 3; i++)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.01),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: height * 0.08,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Student Version",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "750.92 ₺",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              Text(
                "Select the start date",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.01),
              // Pickers
              Container(
                height: 200,
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
                onTap: () {},
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
              SizedBox(height: height * 0.01),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Text(
                      "If your payment method is not listed, ",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    Text(
                      " click here",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
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

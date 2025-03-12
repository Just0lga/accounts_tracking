import 'package:accounts_tracking/add_payment_page.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.info_outline, color: Colors.white, size: 32),
        ),
        title: const Text(
          'WELCOME',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.02,
            vertical: height * 0.01,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Monthly payment",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const Text(
                        "569.42 ₺",
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
                        MaterialPageRoute(
                          builder: (context) => AddPaymentPage(),
                        ),
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
                  itemCount: 5,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.01),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: height * 0.15,
                          width: width,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: height * 0.3,
                                width: width * 0.3,
                                child: const CircleAvatar(
                                  radius: 45,
                                  backgroundImage: NetworkImage(
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/Spotify_logo_without_text.svg/2048px-Spotify_logo_without_text.svg.png",
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: height * 0.3,
                                width: width * 0.66,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              "Monthly payment",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF1ED760),
                                              ),
                                            ),
                                            Text(
                                              "100000.42 ₺",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Color(0xFF1ED760),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: width * 0.06),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              "This year payment",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF1ED760),
                                              ),
                                            ),
                                            Text(
                                              "100000.42 ₺",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Color(0xFF1ED760),
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
                                        fontSize: 14,
                                        color: Color(0xFF1ED760),
                                      ),
                                    ),
                                    const Text(
                                      "24 March 2025 (23)",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xFF1ED760),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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

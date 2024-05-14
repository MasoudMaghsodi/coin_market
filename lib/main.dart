import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        // Locale('en'), // English
        Locale('fa'), // Spanish
      ],
      theme: ThemeData(
        fontFamily: "dana",
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontFamily: 'dana',
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'dana',
            fontSize: 13,
            fontWeight: FontWeight.w300,
          ),
          displayMedium: TextStyle(
            fontFamily: 'dana',
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: AppBar(
        backgroundColor: Colors.white70,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 37,
              width: 37,
              child: Image.asset("assets/images/risk.png"),
            ),
          ),
          Text(
            "قیمت به روز ارز",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 23,
                width: 23,
                child: Image.asset("assets/images/menu.png"),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset("assets/images/q.png"),
                  ),
                ),
                Text(
                  "نرخ ارز آزاد چیست؟",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                "نرخ ارزها در معاملات نقدی و رایج روزانه است معاملات نقدی معاملاتی هستند که خریدار و فروشنده به محض انجام معامله ارزو و ریال را با هم تبادل میکنند.",
                style: Theme.of(context).textTheme.bodyLarge,
                textDirection: TextDirection.rtl,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

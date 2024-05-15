import 'package:coin_market/Model/Currency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

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
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
          displaySmall: TextStyle(
            fontFamily: 'dana',
            fontSize: 14,
            color: Colors.red,
            fontWeight: FontWeight.w700,
          ),
          headlineMedium: TextStyle(
            fontFamily: 'dana',
            fontSize: 14,
            color: Colors.green,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}

// ignore: must_be_immutable
class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Currency> currency = [];

  Future getResponse(BuildContext context) async {
    var url =
        "https://sasansafari.com/flutter/api.php?access_key=flutter123456";

    var value = await http.get(Uri.parse(url));

    if (currency.isEmpty) {
      if (value.statusCode == 200) {
        // ignore: use_build_context_synchronously
        _showSnackBar(context, "بروز رسانی اطلاعات با موفقیت انجام شد");
        List jsonList = convert.jsonDecode(value.body);
        if (jsonList.isNotEmpty) {
          for (int i = 0; i < jsonList.length; i++) {
            setState(() {
              currency.add(
                Currency(
                  id: jsonList[i]['id'],
                  title: jsonList[i]['title'],
                  price: jsonList[i]['price'],
                  changes: jsonList[i]['changes'],
                  status: jsonList[i]['status'],
                ),
              );
            });
          }
        }
      }
    }
    return value;
  }

  @override
  void initState() {
    super.initState();
    getResponse(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Container(
                  width: double.infinity,
                  height: 35,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: Color.fromARGB(255, 130, 130, 130),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "نام آزاد ارز",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Text(
                        "قیمت",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Text(
                        "تغییر",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 350,
                child: listFutureBuilder(context),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 232, 232, 232),
                    borderRadius: BorderRadius.circular(1000),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 50,
                        child: TextButton.icon(
                          onPressed: () {
                            currency.clear();
                            listFutureBuilder(context);
                          },
                          icon: const Icon(
                            CupertinoIcons.refresh_bold,
                            color: Colors.black,
                          ),
                          label: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'به روز رسانی',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: const MaterialStatePropertyAll(
                              Color.fromARGB(255, 202, 193, 255),
                            ),
                            shape: MaterialStatePropertyAll<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1000),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text("آخرین بروزرسانی  ${_getTime()}"),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<dynamic> listFutureBuilder(BuildContext context) {
    return FutureBuilder(
      future: getResponse(context),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: currency.length,
                itemBuilder: (BuildContext context, int postion) {
                  return MyItem(postion, currency);
                },
                separatorBuilder: (BuildContext context, int index) {
                  if (index % 9 == 0) {
                    return const Add();
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  String _getTime() {
    return "20:45";
  }
}

// ignore: must_be_immutable
class MyItem extends StatelessWidget {
  int postion;
  List<Currency> currency;
  MyItem(
    this.postion,
    this.currency, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(1000),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              blurRadius: 1.0,
              color: Colors.grey,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              currency[postion].title!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              currency[postion].price!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              currency[postion].changes!,
              style: currency[postion].status == "n"
                  ? Theme.of(context).textTheme.displaySmall
                  : Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class Add extends StatelessWidget {
  const Add({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(1000),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              blurRadius: 1.0,
              color: Colors.grey,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "تبلیغات",
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ],
        ),
      ),
    );
  }
}

void _showSnackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg, style: Theme.of(context).textTheme.bodyLarge),
      backgroundColor: Colors.green,
    ),
  );
}

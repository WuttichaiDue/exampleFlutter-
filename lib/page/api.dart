import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nt_1207/models/covid.dart';

class APIPage extends StatefulWidget {
  const APIPage({Key? key}) : super(key: key);

  @override
  _APIPageState createState() => _APIPageState();
}

class _APIPageState extends State<APIPage> {
  //todo =========================================== Fields ========================================================
  // List<Covid> today = [];
  String txnDate = '';
  int newCase = 0;
  int totalCase = 0;
  int newCaseExcludeabroad = 0;
  int totalCaseExcludeabroad = 0;
  int newDeath = 0;
  int totalDeath = 0;
  int newRecovered = 0;
  int totalRecovered = 0;
  String updateDate = '';
  //todo =========================================== Method ========================================================
  //* ------ Method เรียกใช้งาน API -----
  Future<void> getCovidToday() async {
    String url = 'https://covid19.ddc.moph.go.th/api/Cases/today-cases-all';
    Dio dio = new Dio();
    print(url);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json", // or whatever
    };
    dio.options.headers = headers;
    //? ================================ Call Api แบบ Get ============================
    Response response = await dio.get(
      url,
    );
    //? ===========================vvvv Call Api แบบ Post vvvv=======================
    //  Response response = await dio.post(
    //   url,
    //   data: {"username": username, "password": password},
    // );
    //? ============================^^^^ Call Api แบบ Post ^^^^=======================
    //     options: Options(headers: headers));
    var result = response.data;
    print(result);
    //Devices.devices.clear();
    for (var item in result) {
      setState(() {
        Covid covidtoday = Covid.fromJson(item);
        txnDate = covidtoday.txnDate;
        newCase = covidtoday.newCase;
        totalCase = covidtoday.totalCase;
        newCaseExcludeabroad = covidtoday.newCaseExcludeabroad;
        totalCaseExcludeabroad = covidtoday.totalCaseExcludeabroad;
        newDeath = covidtoday.newDeath;
        totalDeath = covidtoday.totalDeath;
        newRecovered = covidtoday.newRecovered;
        totalRecovered = covidtoday.totalRecovered;
        updateDate = covidtoday.updateDate;
        print(covidtoday.newCase);
        //  today.add(covidtoday);
      });
    }
  }

  //* ------ Method สร้างข้อความ font kanit -----
  Widget kanitText(String data, double size, Color color) {
    return Text(
      data, //? ข้อความ
      textScaleFactor: 0.9, //? ฟิก(FIX) ขนาดตามขนาดฟอร์นที่ตั้งในโทรศัพท์
      style: TextStyle(
          fontFamily: 'Kanit', //? ชื่อฟอร์น
          color: color, //? สีฟอร์น
          fontSize: MediaQuery.of(context).size.width * size), //? ขนาดฟอร์น
      // style: GoogleFonts.(),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getCovidToday();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kanitText('วันที่ $txnDate', 0.05, Colors.black),
              kanitText('ผู้ป่วยใหม่ $newCase', 0.05, Colors.black),
              kanitText('ผู้ป่วยทั้งหมด $totalCase', 0.05, Colors.black),
              //  kanitText('$newCaseExcludeabroad', 0.1, Colors.black),
              //  kanitText('$totalCaseExcludeabroad', 0.1, Colors.black),
              kanitText('ผู้เสียชีวิตใหม่ $newDeath', 0.05, Colors.black),
              kanitText('ผู้เสียชีวิตทั้งหมด $totalDeath', 0.05, Colors.black),
              kanitText('ผู้ที่รักษาหายใหม่ $newRecovered', 0.05, Colors.black),
              kanitText(
                  'ผู้ที่รักษาหายทั้งหมด $totalRecovered', 0.05, Colors.black),
              kanitText('อัพเดตตอน $updateDate', 0.05, Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nt_1207/models/global.dart';
import 'package:nt_1207/page/api.dart';
import 'package:nt_1207/page/map.dart';
import 'package:nt_1207/page/webview.dart';
import 'package:nt_1207/styles/color_main.dart';

//! =========================================== หน้าหลัก ===========================================
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //todo =========================================== Fields ========================================================
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ]; //? List รูป

  final CarouselController _controller =
      CarouselController(); //? Controller รูป

  int _current = 0;
  //todo =========================================== Method ========================================================

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

  //* ------ Method สร้าง AppBar -----
  Widget appBar() {
    return Container(
      color: ColorsMain().color1, //? เรียกใช้ค่าสีจากอีก Class
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          //kanitText('เทศบาลเมืองมหาสารคาม', 0.04, ColorsMain().color4),
          Expanded(
            //? คำสั่งแบ่งขนาด widget
            child: imageIcon(),
            flex: 2, //? แบ่งขนาด เป็น 2/10 ของขนาดทั้งหมด
          ),
          Expanded(
              flex: 8, //? แบ่งขนาด เป็น 8/10 ของขนาดทั้งหมด
              child: Container(
                  margin: EdgeInsets.only(
                      left: 10), //? ใส่ margin ให้ข้อความอยู่ห่างจากรูป
                  child: kanitText(
                      '${Global.textString}', 0.04, ColorsMain().color4))),
        ],
      ),
    );
  }

  //* ------ Method สร้างรูป -----
  Widget imageIcon() {
    return Container(
      // height: 50,
      //width: 50,
      decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fitHeight, //? ฟิกขนาดรูปตามความสูงของ Container
            image:
                AssetImage('assets/images/neutral.png')), //? ใส่ตำแหน่งของรูป
        // borderRadius: BorderRadius.all(Radius.circular(50)), //? ทำให้มุมของ Container โค้ง
        //color: Colors.red
      ),
    );
  }

  //* ------ Method สร้าง หน้าต่างรูป -----
  Widget mainImage() {
    return Container(
      child: Stack(
        children: [
          Container(
              // height: MediaQuery.of(context).size.height * 0.3, //? https://pub.dev/packages/carousel_slider
              child: CarouselSlider(
            options: CarouselOptions(
                autoPlay: true,
                //  enlargeCenterPage: true,
                // aspectRatio: 2,
                viewportFraction: 1.0,
                //enlargeStrategy: CenterPageEnlargeStrategy.height,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
            carouselController: _controller,
            items: imgList
                .map((item) => Container(
                      child: Center(
                          child: Image.network(
                        item,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      )),
                    ))
                .toList(),
          )),
          Container(
            height: MediaQuery.of(context).size.height * 0.27,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  //* ------ Method สร้าง  Button -----
  Widget button1(String text, Function function) {
    return InkWell(
      //?  InkWWell ทำให้ Container หรือ Widget ต่างๆ เป็นปุ่มได้
      onTap: () {
        function();
      },
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Column(
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: ColorsMain().color5,
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  border: Border.all(
                    color: Colors.white,
                    width: 4.0,
                  ), //? ใส่ขนาด สี ของขอบ

                  // border: Border(
                  //   top: BorderSide(width: 1.0, color: Color(0xFFFFFFFF)),
                  //   left: BorderSide(width: 1.0, color: Color(0xFFFFFFFF)),
                  //   right: BorderSide(width: 1.0, color: Color(0xFF000000)),
                  //   bottom: BorderSide(width: 1.0, color: Color(0xFF000000)),
                  // ),//? ใส่ขนาด สี ของขอบ แต่ละด้าน
                ),
              ),
              kanitText(text, 0.04, ColorsMain().color1)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> noneActive() async {}
  //* ------ Method ไปหน้า API -----
  Future<void> covidApi() async {
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext buildContext) {
      return APIPage();
    });

    Navigator.of(context).push(materialPageRoute);
  }

  //* ------ Method ไปหน้า webview -----
  Future<void> webview() async {
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext buildContext) {
      return WebViewPage();
    });

    Navigator.of(context).push(materialPageRoute);
  }

  //* ------ Method ไปหน้า MAP -----
  Future<void> mapPage() async {
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext buildContext) {
      return MapPage();
    });

    Navigator.of(context).push(materialPageRoute);
  }

  //* ------ Method สร้าง List Button -----
  Widget listButton() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.62,

      //? --------------------------- วิธีที่ใช้ GridView ----------------------------------
      // child: GridView.builder(
      //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //       crossAxisCount: 3,
      //     ),
      //     itemCount: 9,
      //     itemBuilder: (BuildContext context, int index) {
      //       return Container(
      //         decoration: const BoxDecoration(
      //           image: DecorationImage(
      //               fit: BoxFit.fitHeight, //? ฟิกขนาดรูปตามความสูงของ Container
      //               image: AssetImage(
      //                   'assets/images/neutral.png')), //? ใส่ตำแหน่งของรูป
      //           // borderRadius: BorderRadius.all(Radius.circular(50)), //? ทำให้มุมของ Container โค้ง
      //           //color: Colors.red
      //         ),
      //       );
      //     }),
      //? --------------------------- วิธีที่ใช้ collumn  ----------------------------------
      child: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceAround, //? ทำให้ของใน Row แบ่งพื้นที่เท่าๆกัน
                children: [
                  button1('Covid รายวัน', covidApi),
                  button1('webview', webview),
                  button1('สายด่วน', noneActive),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceAround, //? ทำให้ของใน Row แบ่งพื้นที่เท่าๆกัน
                children: [
                  button1('ข่าวสาร', noneActive),
                  button1('บทความ', noneActive),
                  button1('CCTV', noneActive),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceAround, //? ทำให้ของใน Row แบ่งพื้นที่เท่าๆกัน
                children: [
                  button1('รางวัลที่เคยได้รับ', noneActive),
                  button1('Youtuber', noneActive),
                  button1('ช่วยเหลือ', noneActive),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceAround, //? ทำให้ของใน Row แบ่งพื้นที่เท่าๆกัน
                children: [
                  button1('ท่องเที่ยว', noneActive),
                  button1('สินค้า OTOP', noneActive),
                  button1('ทดสอบ MAP', mapPage),
                ],
              ),
            ),
          ),

          Expanded(child: Container()),
          // Expanded(child: Container())
        ],
      ),
    );
  }

  //todo =========================================== Body Page ========================================================
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          //?---------------------------- Background Image -------------------------
          decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, //? ฟิกขนาดรูปตามความสูงของ Container
                image: AssetImage('assets/images/bg.jpg')), //? ใส่ตำแหน่งของรูป
          ),

          height: MediaQuery.of(context)
              .size
              .height, //?ปรับความสูง MediaQuery.of(context).size.height คือความสูงตามขนาดจอ
          width: MediaQuery.of(context)
              .size
              .width, //?ปรับความกว้าง MediaQuery.of(context).size.width คือความกว้างตามขนาดจอ
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .start, //?ปรับให้ Widget ที่อยู่ใน Column ชิดข้างบน
            children: [
              appBar(),
              mainImage(),
              listButton(),
            ],
          ),
        ),
      ),
    );
  }
}

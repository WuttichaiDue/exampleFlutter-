import 'package:flutter/material.dart';
import 'package:nt_1207/models/global.dart';
import 'package:nt_1207/page/home.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //todo =========================================== Fields ========================================================
  String textString = ''; //? ข้อความที่จะเก็บ
  final formKey = GlobalKey<FormState>(); //? คีย์ที่ใช้ในการเซฟข้อความ
  var currentFocus;
  //todo =========================================== Method ========================================================
  //* ------ Method ยกเลิกคีย์บอร์ดเมื่อกดที่อื่น -----
  unfocus() {
    currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  //* ------ Method เซฟแคส -----
  Future<void> saveSharePreference() async {
    //  print(userModel.name);
    print("========================================================>SAVE");
    List<String> list = [];

    list.add('ชื่อจริง');
    list.add('นามสกุล');
    //list.add(password);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList('User', list);
    sharedPreferences.setBool('Remember', true);
    setState(() {
      print(list[0]);
      Global.textString = list[0]; //? เซ็ตข้อมูลไปเป็น global
      //? =================================== เปลี่ยนหน้า ===================================
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext buildContext) {
        return HomePage();
      });
      Navigator.of(context).pop();
      Navigator.of(context).push(materialPageRoute);
      //? =================================== เปลี่ยนหน้า ===================================
    });
  }

  //* ------ Method อ่านแคส -----
  Future<void> readSharedPreferrance() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      bool? remember = sharedPreferences.getBool('Remember');
      if (remember!) {
        List<String>? list = sharedPreferences.getStringList('User');
        String textStringRead = list![0];

        print(textStringRead);
        Global.textString = textStringRead; //? เซ็ตข้อมูลไปเป็น global
        Global.test ='test';
        //? =================================== เปลี่ยนหน้า ===================================
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext buildContext) {
          return HomePage();
        });
        Navigator.of(context).pop();
        Navigator.of(context).push(materialPageRoute);
        //? =================================== เปลี่ยนหน้า ===================================
      }
    } catch (e) {
      setState(() {});
    }
  }

  //* ------ Method สร้างกล่องข้อความ -----
  Widget userForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.08,
      child: TextFormField(
        style: TextStyle(
          fontFamily: "kanit",
          color: Colors.black,
          fontSize: MediaQuery.of(context).size.width * 0.03,
        ),
        // keyboardType: TextInputType.number, //? เซ็ตคีย์บอร์ดเป็นตัวเลข
        onSaved: (String? text) {
          textString = text!;
        },
        decoration: InputDecoration(
          fillColor: Colors.black,
          hoverColor: Colors.black,
          focusColor: Colors.black,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.green),
          ),
          hintStyle: TextStyle(
            fontFamily: "kanit",
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.width * 0.03,
          ),
          hintText: 'ข้อความ :',
        ),
      ),
    );
  }

//* ------ Method สร้างปุ่มบันทึกข้อความและเปลี่ยนหน้า -----
  Widget signInButton() {
    return InkWell(
      onTap: () {
        formKey.currentState!.save(); //? เซฟข้อมูล ใช้กับ onSave
        if (textString.isNotEmpty) {
          // print(textString);
          saveSharePreference();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          border: Border.all(color: Colors.white10, width: 2),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black87.withOpacity(0.4),
              blurRadius: 3.0,
              offset: Offset(
                0.2, // horizontal, move right 10
                0.2, // vertical, move down 10
              ),
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 3.0,
              offset: Offset(
                -0.2,
                -0.2,
              ),
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 3.0,
              offset: Offset(
                -0.2,
                0.2,
              ),
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 3.0,
              offset: Offset(
                0.2,
                -0.2,
              ),
            ),
          ],
        ),
        height: MediaQuery.of(context).size.width * 0.13,
        width: MediaQuery.of(context).size.width * 0.28,
        margin: EdgeInsets.all(2),
        child: Center(
          child: Stack(
            children: <Widget>[
              Center(
                child: Text(
                  "เข้าสู่ระบบ",
                  textScaleFactor: 0.8,
                  style: TextStyle(
                      fontFamily: "kanit",
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //* ============================================ Method สั่งทำงานก่อนสร้างหน้าจอ ====================================
  @override
  void initState() {
    // TODO: implement initState
    readSharedPreferrance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: unfocus,
      child: Scaffold(
        //backgroundColor: Colors.white70,
        body: Form(
          key: formKey, //? เซ็ต Key
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [userForm(), signInButton()],
            ),
          ),
        ),
      ),
    );
  }
}

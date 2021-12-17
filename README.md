# exampleFlutter

Project นี้มีการใช้งาน WebView ,บันทึก Cache, Google Map ,GPS ,Call API

## Getting Started

1. ไปที่ไฟล์ pubspec.yaml แล้วหา dependencies จะมีชื่อ Package ที่ใช้และ Url ที่มาของ Package นั้นๆ
2. ไปที่โฟลเดอร์ Lib ตามด้วย page จะมีหน้าต่างๆที่เรียกใช้ Package อยู่
3. login.dart จะใช้ package shared_preferences เป็นตัวที่ไว้บันทึก Cache ลงโทรศัพท์
4. home.dart จะใช้ package carousel_slider เป็นตัวที่ทำให้รูปสไลด์
5. api.dart จะใช้ package dio เป็นตัวเรียกใช้ api ในหน้านี้จะเรียกใช้งาน api covid
6. webview.dart จะใช้ package flutter_webview_plugin ตามชื่อ เรียกใช้ webview ไปที่หน้า google ที่หาข้อมูลจากที่เราเก็บ cache ไว้ **package นี้อาจจะใช้ได้ไม่นานต้องหา package ใหม่
7. map.dart จะใช้ package google_maps_flutter กับ location เรียกใช้ googlemap กับ gps ของเครื่องโทรศัพท์
8. ในโฟลเดอร์ models จะเก็บตัวแปรที่เป็น Global กับตัวแปร ที่เอามาสร้าง jsonBody 

import 'package:flutter/material.dart';
import 'package:uts_akb/db/db_mhs.dart';
import 'package:uts_akb/models/mahasiswa.dart';
import 'package:uts_akb/utils/constants.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Detailmhs extends StatelessWidget {
  final Mahasiswa mhs;
  Detailmhs({Key key, this.mhs}) : super(key: key);

  @override
  void dispose() {}

  var txtnim = TextEditingController();
  var txtnama = TextEditingController();
  var txtkelas = TextEditingController();
  var txtprodi = TextEditingController();

  void setText() {
    txtnim.text = mhs.nim;
    txtnama.text = mhs.namaLengkap;
    txtkelas.text = mhs.kelas;
    txtprodi.text = mhs.prodi;
  }

  @override
  Widget build(BuildContext context) {
    setText();
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: Container(
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Positioned(
              right: 0.0,
              top: 10.0,
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  "assets/images/washing_machine_illustration.png",
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: kToolbarHeight,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        FlutterIcons.keyboard_backspace_mdi,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Details Mahasiswa\n",
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                          TextSpan(
                            text: mhs.namaLengkap,
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Constants.scaffoldBackgroundColor,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 24.0,
                        horizontal: 16.0,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Detail",
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      color: Color.fromRGBO(74, 77, 84, 1),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w800,
                                    ),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          TextField(
                            controller: txtnim,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'NIM',
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            controller: txtnama,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Nama Lengkap',
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            controller: txtkelas,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Kelas',
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            controller: txtprodi,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Prodi',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.all(16.0),
                      height: ScreenUtil().setHeight(150.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Constants.primaryColor,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Ubah'),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          TextButton.icon(
                            icon: Icon(FlutterIcons.trash_2_fea),
                            label: Text("Hapus"),
                            style: TextButton.styleFrom(
                                primary: Colors.red,
                                textStyle:
                                    TextStyle(fontWeight: FontWeight.bold)),
                            onPressed: () async {
                              await MhsDatabase.instance.delete(mhs.id);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget getTotalRow(String title, String amount) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Color.fromRGBO(19, 22, 33, 1),
            fontSize: 17.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Spacer(),
        Text(
          amount,
          style: TextStyle(
            color: Constants.primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 17.0,
          ),
        )
      ],
    ),
  );
}

Widget getSubtotalRow(String title, String price) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Color.fromRGBO(74, 77, 84, 1),
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Spacer(),
        Text(
          price,
          style: TextStyle(
            color: Color.fromRGBO(74, 77, 84, 1),
            fontSize: 15.0,
          ),
        )
      ],
    ),
  );
}

Widget getItemRow(String count, String item, String price) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Text(
          count,
          style: TextStyle(
            color: Color.fromRGBO(74, 77, 84, 1),
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            " x $item",
            style: TextStyle(
              color: Color.fromRGBO(143, 148, 162, 1),
              fontSize: 15.0,
            ),
          ),
        ),
        Text(
          price,
          style: TextStyle(
            color: Color.fromRGBO(74, 77, 84, 1),
            fontSize: 15.0,
          ),
        )
      ],
    ),
  );
}

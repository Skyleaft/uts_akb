import 'package:flutter/material.dart';
import 'package:uts_akb/db/db_mhs.dart';
import 'package:uts_akb/models/mahasiswa.dart';
import 'package:uts_akb/utils/constants.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class Detailmhs extends StatelessWidget {
  final Mahasiswa mhs;
  Detailmhs({Key key, this.mhs}) : super(key: key);

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
    Future<void> _showMyDialog(String _tittle, String _msg) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(_tittle),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(_msg),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Tidak'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Ya'),
                onPressed: () async {
                  await MhsDatabase.instance.delete(mhs.id);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Fluttertoast.showToast(
                      msg: "Data Berhasil Dihapus",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      fontSize: 16.0);
                },
              ),
            ],
          );
        },
      );
    }

    Future updateMhs() async {
      final tempmhs = Mahasiswa(
        id: mhs.id,
        nim: txtnim.text,
        namaLengkap: txtnama.text,
        kelas: txtkelas.text,
        prodi: txtprodi.text,
      );
      await MhsDatabase.instance.update(tempmhs);
      Fluttertoast.showToast(
          msg: "Data Berhasil Diubah",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }

    void onClose() {
      Navigator.pop(context);
    }

    setText();
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: Container(
        child: Stack(
          clipBehavior: Clip.none,
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
                        onClose();
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
                              counterText: "",
                            ),
                            maxLength: 20,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            controller: txtnama,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Nama Lengkap',
                              counterText: "",
                            ),
                            maxLength: 40,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            controller: txtkelas,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Kelas',
                              counterText: "",
                            ),
                            maxLength: 20,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            controller: txtprodi,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Prodi',
                              counterText: "",
                            ),
                            maxLength: 25,
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
                              updateMhs();
                              onClose();
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
                              _showMyDialog(
                                  "Peringatan", "Yakin Data mau Dihapus?");
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

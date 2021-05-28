import 'package:flutter/material.dart';
import 'package:uts_akb/models/mahasiswa.dart';
import 'package:uts_akb/utils/constants.dart';
import 'dart:async';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:uts_akb/db/db_mhs.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';

var txtnim = TextEditingController();
var txtnama = TextEditingController();
var txtkelas = TextEditingController();
var txtprodi = TextEditingController();

void clearText() {
  txtnim.text = "";
  txtnama.text = "";
  txtkelas.text = "";
  txtprodi.text = "";
}

bool validate() {
  if (txtnim.text == "" ||
      txtnama.text == "" ||
      txtkelas.text == "" ||
      txtprodi.text == "") {
    Fluttertoast.showToast(
        msg: "Data Masih belum lengkap",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
    return false;
  } else {
    return true;
  }
}

var checkstats = false;
var _btnController2 = RoundedLoadingButtonController();
void _doSomething(RoundedLoadingButtonController controller) async {
  Timer(Duration(seconds: 1), () {
    if (validate()) {
      saveData();
      controller.success();
      Fluttertoast.showToast(
          msg: "Data Berhasil Disimpan",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      clearText();
    } else {
      controller.error();
    }
    Timer(Duration(seconds: 2), () {
      _btnController2.reset();
    });
  });
}

Future saveData() async {
  final mhs = Mahasiswa(
    nim: txtnim.text,
    namaLengkap: txtnama.text,
    kelas: txtkelas.text,
    prodi: txtprodi.text,
  );
  await MhsDatabase.instance.create(mhs);
}

class AddData extends StatelessWidget {
  const AddData({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
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
              "Tambah Data Mahasiswa",
              style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Color.fromRGBO(74, 77, 84, 1),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w800,
                  ),
            ),
            SizedBox(
              height: 15.0,
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
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
            SizedBox(
              height: 15.0,
            ),
            RoundedLoadingButton(
              width: MediaQuery.of(context).size.width,
              color: Constants.primaryColor,
              successColor: Colors.green[800],
              controller: _btnController2,
              onPressed: () => _doSomething(_btnController2),
              borderRadius: 6,
              child: Text('Simpan Data', style: TextStyle(color: Colors.white)),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                style: TextButton.styleFrom(
                    primary: Constants.primaryColor,
                    textStyle: TextStyle(fontSize: 16)),
                onPressed: () {
                  clearText();
                },
                child: const Text("Clear"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

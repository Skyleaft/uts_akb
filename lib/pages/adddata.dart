import 'package:flutter/material.dart';
import 'package:uts_akb/utils/constants.dart';
import 'dart:async';
import 'package:rounded_loading_button/rounded_loading_button.dart';

var txtnim = TextEditingController();
var txtnama = TextEditingController();
var txtkelas = TextEditingController();
var txtprodi = TextEditingController();

var _btnController2 = RoundedLoadingButtonController();
void _doSomething(RoundedLoadingButtonController controller) async {
  Timer(Duration(seconds: 2), () {});
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
            SizedBox(
              height: 10.0,
            ),
            RoundedLoadingButton(
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
                onPressed: () {},
                child: const Text("Clear"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

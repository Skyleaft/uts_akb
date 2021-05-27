import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uts_akb/models/mahasiswa.dart';
import 'package:uts_akb/pages/detailmhs.dart';
import 'package:uts_akb/utils/constants.dart';
import 'package:uts_akb/utils/helper.dart';

class CardMhs extends StatelessWidget {
  final Mahasiswa mhs;

  CardMhs({this.mhs});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(125.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey[300],
            spreadRadius: .8,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            //print(mhs.kelas);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Detailmhs(mhs: this.mhs),
              ),
            );
          },
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 25.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        mhs.namaLengkap,
                        style: TextStyle(
                          color: Constants.primaryColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      textRow("Nim", mhs.nim),
                      textRow("Prodi", mhs.prodi)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget textRow(String textOne, String textTwo) {
  return Wrap(
    children: [
      Text(
        "$textOne:",
        style: TextStyle(
          color: Color.fromRGBO(74, 77, 84, 0.7),
          fontSize: 14.0,
        ),
      ),
      SizedBox(
        width: 4.0,
      ),
      Text(
        textTwo,
        style: TextStyle(
          color: Color.fromRGBO(19, 22, 33, 1),
          fontSize: 14.0,
        ),
      ),
    ],
  );
}

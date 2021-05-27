import 'package:flutter/material.dart';
import 'package:uts_akb/models/mahasiswa.dart';
import 'package:uts_akb/utils/constants.dart';
import 'package:uts_akb/widget/cardmhs.dart';

final List<Mahasiswa> mahasiswa = [
  Mahasiswa(
    id: 507,
    nim: "10118220",
    namaLengkap: "Milzan Malik",
    kelas: "IF-5",
    prodi: "Teknik Informatika",
  ),
  Mahasiswa(
    id: 23,
    nim: "10118231",
    namaLengkap: "Ridho Subhan",
    kelas: "IF-3",
    prodi: "Teknik Informatika",
  ),
];

class ShowData extends StatelessWidget {
  const ShowData({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Data Mahasiswa",
                  style: TextStyle(
                    color: Color.fromRGBO(19, 22, 33, 1),
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 10.0,
            ),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              // Lets pass the order to a new widget and render it there
              return CardMhs(
                mhs: mahasiswa[index],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 15.0,
              );
            },
            itemCount: mahasiswa.length,
          )
          // Let's create an order model
        ],
      ),
    );
  }
}

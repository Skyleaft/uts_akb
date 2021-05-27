import 'package:flutter/material.dart';
import 'package:uts_akb/db/db_mhs.dart';
import 'package:uts_akb/models/mahasiswa.dart';
import 'package:uts_akb/pages/detailmhs.dart';
import 'package:uts_akb/widget/cardmhs.dart';
import 'dart:async';

class ShowData extends StatefulWidget {
  @override
  _ShowDataState createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  List<Mahasiswa> mahasiswa = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshMahasiswa();
  }

  Future refreshMahasiswa() async {
    setState(() => isLoading = true);

    this.mahasiswa = await MhsDatabase.instance.readAllMahasiswa();

    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    super.dispose();
  }

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
          isLoading
              ? CircularProgressIndicator()
              : mahasiswa.isEmpty
                  ? Center(
                      child: Text(
                      'Data Masih Kosong',
                      style: TextStyle(color: Colors.grey, fontSize: 24),
                    ))
                  : ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 10.0,
                      ),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        // Lets pass the order to a new widget and render it there
                        return Container(
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
                              borderRadius: BorderRadius.circular(8.0),
                              onTap: () {
                                //print(mhs.kelas);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Detailmhs(mhs: mahasiswa[index]),
                                  ),
                                ).then((value) => {refreshMahasiswa()});
                              },
                              child: CardMhs(
                                mhs: mahasiswa[index],
                              ),
                            ),
                          ),
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

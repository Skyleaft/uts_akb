import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:uts_akb/utils/constants.dart';

Future<CovidRegion> fetchCovidRegion() async {
  final response = await http
      .get(Uri.parse('https://api.kawalcorona.com/indonesia/provinsi'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var jsonresponse = jsonDecode(response.body);
    return CovidRegion.fromJson(jsonresponse[0]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}

Future<RegionList> fetchRegionList() async {
  final response = await http
      .get(Uri.parse('https://api.kawalcorona.com/indonesia/provinsi'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var jsonresponse = jsonDecode(response.body);
    return RegionList.fromJson(jsonresponse);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}

class Attributes {
  String name;
  int positif;
  int sembuh;
  int meninggal;

  Attributes({
    this.name,
    this.positif,
    this.sembuh,
    this.meninggal,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      name: json['Provinsi'],
      positif: json['Kasus_Posi'],
      sembuh: json['Kasus_Semb'],
      meninggal: json['Kasus_Meni'],
    );
  }
}

class CovidRegion {
  Attributes atribut;

  CovidRegion({
    this.atribut,
  });

  factory CovidRegion.fromJson(Map<String, dynamic> parsedJson) {
    return CovidRegion(
      atribut: Attributes.fromJson(parsedJson['attributes']),
    );
  }
}

class RegionList {
  final List<CovidRegion> covidRegion;

  RegionList({
    this.covidRegion,
  });

  factory RegionList.fromJson(List<dynamic> parsedJson) {
    List<CovidRegion> covidRegion = new List<CovidRegion>();
    covidRegion = parsedJson.map((i) => CovidRegion.fromJson(i)).toList();

    return new RegionList(
      covidRegion: covidRegion,
    );
  }
}

class HomeCovid extends StatefulWidget {
  @override
  _HomeCovidState createState() => _HomeCovidState();
}

class _HomeCovidState extends State<HomeCovid> {
  Future<CovidRegion> futureCovidRegion;
  Future<RegionList> futureRegionList;
  final formatter = new NumberFormat("#,###");

  @override
  void initState() {
    super.initState();
    futureCovidRegion = fetchCovidRegion();
    futureRegionList = fetchRegionList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var txtkd = TextEditingController();
  var _btnController2 = RoundedLoadingButtonController();
  void _doSomething(RoundedLoadingButtonController controller) async {
    Timer(Duration(seconds: 1), () {
      Timer(Duration(seconds: 1), () {
        dynamicIndex = int.tryParse(txtkd.text) ?? 1;
        _btnController2.reset();
        setState(() {});
      });
    });
  }

  var dynamicIndex = 1;

  Widget futureBuilder(int index) {
    return new FutureBuilder<RegionList>(
      future: futureRegionList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 200,
                    height: 100,
                    decoration: BoxDecoration(),
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: Color(0xFF26C6DA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Region :',
                              style: TextStyle(
                                color: Color.fromRGBO(19, 22, 33, 1),
                                fontSize: 14.0,
                              ),
                            ),
                            Text(
                              snapshot.data.covidRegion[index].atribut.name,
                              style: TextStyle(
                                color: Color.fromRGBO(19, 22, 33, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 100,
                    decoration: BoxDecoration(),
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: Color(0xFFF06292),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment(0.9, -0.85),
                            child: Container(
                              width: 39,
                              height: 39,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                'https://hirefortalent.ca/images/core/covid-19_tool/icon-tool-112x.png',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Positif',
                                  style: TextStyle(
                                    color: Color.fromRGBO(19, 22, 33, 1),
                                    fontSize: 14.0,
                                  ),
                                ),
                                Text(
                                  formatter.format(snapshot
                                      .data.covidRegion[index].atribut.positif),
                                  style: TextStyle(
                                    color: Color.fromRGBO(19, 22, 33, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 250,
                    height: 100,
                    decoration: BoxDecoration(),
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: Color(0xFF66BB6A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment(0.9, -0.85),
                            child: Container(
                              width: 39,
                              height: 39,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                'https://occovid19.ochealthinfo.com/sites/virus/files/2020-09/Heart_Icon.png',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sembuh',
                                  style: TextStyle(
                                    color: Color.fromRGBO(19, 22, 33, 1),
                                    fontSize: 14.0,
                                  ),
                                ),
                                Text(
                                  formatter.format(snapshot
                                      .data.covidRegion[index].atribut.sembuh),
                                  style: TextStyle(
                                    color: Color.fromRGBO(19, 22, 33, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 100,
                    decoration: BoxDecoration(),
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: Color(0xFF90A4AE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment(0.9, -0.85),
                            child: Container(
                              width: 39,
                              height: 39,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                'https://cdn1.iconfinder.com/data/icons/coronavirus-covid-19-4/57/Death-512.png',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Meninggal',
                                  style: TextStyle(
                                    color: Color.fromRGBO(19, 22, 33, 1),
                                    fontSize: 14.0,
                                  ),
                                ),
                                Text(
                                  formatter.format(snapshot.data
                                      .covidRegion[index].atribut.meninggal),
                                  style: TextStyle(
                                    color: Color.fromRGBO(19, 22, 33, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // spinner
        return Center(child: CircularProgressIndicator());
      },
    );
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
                  "Realtime Covid Case Indonesia",
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
          Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                children: [
                  TextField(
                    controller: txtkd,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Kode Provinsi',
                      counterText: "",
                    ),
                    maxLength: 20,
                    keyboardType: TextInputType.number,
                  ),
                  RoundedLoadingButton(
                    width: MediaQuery.of(context).size.width,
                    color: Constants.primaryColor,
                    successColor: Colors.green[800],
                    controller: _btnController2,
                    onPressed: () => _doSomething(_btnController2),
                    borderRadius: 6,
                    child:
                        Text('Cek Data', style: TextStyle(color: Colors.white)),
                  ),
                ],
              )),
          futureBuilder(dynamicIndex - 1)
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

Future<CovidRegion> fetchCovidRegion() async {
  final response =
      await http.get(Uri.parse('https://api.kawalcorona.com/indonesia/'));

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

class CovidRegion {
  String name;
  String positif;
  String sembuh;
  String meninggal;

  CovidRegion({
    this.name,
    this.positif,
    this.sembuh,
    this.meninggal,
  });

  factory CovidRegion.fromJson(Map<String, dynamic> json) {
    return CovidRegion(
      name: json['name'],
      positif: json['positif'],
      sembuh: json['sembuh'],
      meninggal: json['meninggal'],
    );
  }
}

class CovidCountry extends StatefulWidget {
  @override
  _CovidCountryState createState() => _CovidCountryState();
}

class _CovidCountryState extends State<CovidCountry> {
  Future<CovidRegion> futureCovidRegion;
  final formatter = new NumberFormat("#,###");

  @override
  void initState() {
    super.initState();
    futureCovidRegion = fetchCovidRegion();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var dynamicIndex = 1;

  Widget futureBuilder() {
    return new FutureBuilder<CovidRegion>(
      future: futureCovidRegion,
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
                              'Negara :',
                              style: TextStyle(
                                color: Color.fromRGBO(19, 22, 33, 1),
                                fontSize: 14.0,
                              ),
                            ),
                            Text(
                              snapshot.data.name,
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
                                  snapshot.data.positif,
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
                                  snapshot.data.sembuh,
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
                                  snapshot.data.meninggal,
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
          futureBuilder()
        ],
      ),
    );
  }
}

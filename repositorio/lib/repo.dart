import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:repositorio/CadastraTraballho.dart';
import 'package:repositorio/ajuda.dart';

import 'package:repositorio/estagios.dart';
import 'package:repositorio/grade.dart';
import 'package:repositorio/main.dart';
import 'package:repositorio/trabalhos.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'TelaLogin.dart';
//import 'models/api.dart';
//
//import 'package:http/http.dart' as http;

//import 'package:cloud_firestore/cloud_firestore.dart';

class RepoPage extends StatefulWidget {
  @override
  State<RepoPage> createState() => _RepoPageState();
}

class _RepoPageState extends State<RepoPage> {
  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("EM BREVE"),
          );
        });
  }

  String loginSaved;
  Future<void> teste() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loginSaved = prefs.getString('login');
    });
  }

  @override
  void initState() {
    teste();
    super.initState();
  }

  Future logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loginSaved = null;
      prefs.remove("login");
    });
  }

  @override
  Widget build(BuildContext context) {
    //
    //

    const color = Color(0xFFC75555);
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      appBar: AppBar(
        title: Text(
          "RepoTec",
          style: TextStyle(fontFamily: 'ChewyRegular', fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFC75555),
        actions: <Widget>[],
      ),
      drawer: new Drawer(
          child: ListView(
        children: <Widget>[
          loginSaved != null || loginSaved == ""
              ? UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Color(0xFFC75555)),
                  accountName: new Text("$loginSaved"),
                  accountEmail: Text(''),
                  onDetailsPressed: () {},
                )
              : UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Color(0xFFC75555)),
                  accountName: ElevatedButton(
                    child: Text(
                      'Entrar',
                      style: TextStyle(color: Color(0xFFC75555)),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => (TelaLogin()),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Colors.white; // Use the component's default.
                        },
                      ),
                    ),
                  ),
                  accountEmail: Text(''),
                ),
          loginSaved != null || loginSaved == ""
              ? ListTile(
                  leading: Icon(Icons.logout_outlined),
                  title: Text(
                    "Logout",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  onTap: () {
                    logout();
                  },
                )
              : ListTile(
                  //leading: Icon(Icons.logout_outlined),
                  title: Text(
                    "",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
          loginSaved != null || loginSaved == ""
              ? ListTile(
                  leading: Icon(Icons.upgrade),
                  title: Text(
                    "Cadastra Projeto",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => (CadProj())),
                    );
                  },
                )
              : ListTile(
                  //leading: Icon(Icons.logout_outlined),
                  title: Text(
                    "",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
        ],
      )),
      body: FutureBuilder(
        future: getRepo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: 400,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              cursorColor: color,
                              decoration: InputDecoration(
                                labelText: "Faça uma pesquisa",
                                labelStyle: TextStyle(color: color),
                                fillColor: color,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: color,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: color,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  // controller.searchPlaces(value);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Expanded(
                  //       child: Column(
                  //         children: [
                  //           IconButton(
                  //             //iconSize: 10,
                  //             icon: Icon(Icons.arrow_drop_down),
                  //             onPressed: () {
                  //               Text('OPA');
                  //             },
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: List.generate(
                        snapshot.data.length,
                        (index) {
                          String nome = snapshot.data[index]['nome'];
                          return Center(
                              child: Container(
                                  child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.black,
                                width: 0.09,
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                //log('[snapshot] ${snapshot.data[index]['curso']}');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        (TrabalhosPage(
                                      trabalhoID: index,
                                      curso: snapshot.data[index]['curso'],
                                    )),
                                  ),
                                );
                              },
                              child: Column(children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 60,
                                    right: 60,
                                    top: 30,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        snapshot.data[index]['titulo']
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Icon(
                                        Icons.picture_as_pdf_outlined,
                                        color: color,
                                        size: 70,
                                      ),
                                      Text(
                                        snapshot.data[index]['curso']
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          // fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10, left: 45),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Text(
                                            snapshot.data[index]['projeto']
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 20,
                                          ),
                                          child: Text(
                                            'Orientador \n' +
                                                snapshot.data[index]
                                                        ['orientador']
                                                    .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ]),
                            ),
                          )));
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: Text('Nenhum dado para mostrar'));
            }
          } else {
            return Center(
              child: Container(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFC75555)),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

/*
acessar lista de dados

*/

const baseUrl = 'https://rumanian-straighten.000webhostapp.com/repo/repo.php';
//"http://192.168.0.110:80/RepoFlutter/repo.php";

Future<dynamic> getRepo() async {
  var response = await Dio().get(baseUrl);
  print(response.data);
  return response.data;
}

class Repo extends StatefulWidget {
  @override
  RepoState createState() => RepoState();
}

class RepoState extends State<Repo> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

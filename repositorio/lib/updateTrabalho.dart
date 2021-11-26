//import 'dart:convert';
//import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
//import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:repositorio/repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class UpdateProj extends StatefulWidget {
  final String id;
  final String id2;

  const UpdateProj({Key key, this.id, this.id2}) : super(key: key);

  @override
  _UpdateProj createState() => _UpdateProj();
}

class _UpdateProj extends State<UpdateProj> {
  ///
  ////
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _fileName;
  List<PlatformFile> _paths;
  String _directoryPath;
  String _extension;
  bool _loadingPath = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;
  TextEditingController _controller = TextEditingController();
  String dropCurso;
  String dropCiclo;
  String dropProjeto;
  String loginSaved;
  var dev1;
  var dev2;
  var dev3;
//
  ///
//
  //
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController = TextEditingController();
  final PdfController = PdfViewerController();
  final myControllerT = TextEditingController();
  final myControllerO = TextEditingController();
  final myControllerR = TextEditingController();

  Response response;
  Response response2;
  String progress;
  Dio dio = new Dio();

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

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();

    myController1.dispose();

    myController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFffffff),
        appBar: AppBar(
          title: Text(
            "ATUALIZA PROJETO",
            style: TextStyle(fontFamily: 'ChewyRegular', fontSize: 25),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFFC75555),
          actions: <Widget>[],
        ),
        body: FutureBuilder(
          future: getCompanehiros(widget.id2),
          builder: (context, snapshot) {
            var data = snapshot.data;

            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                myController.text = data[0]['dev1'];
                myController1.text = data[0]['dev2'];
                myController2.text = data[0]['dev3'];
                dropCurso = data[0]['curso'].toString();
                dropCiclo = data[0]['ciclo'].toString();
                dropProjeto = data[0]['projeto'].toString();
                myControllerT.text = data[0]['titulo'];
                myControllerO.text = data[0]['orientador'];
                myControllerR.text = data[0]['descri'];

                log(dropCiclo);
                log(dropCurso);
                log(dropProjeto);
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        color: Color(0xFFC75555),
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  //height: 0.1,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [],
                                        ),
                                        Center(
                                          child: Text(
                                            "ATUALIZAR DADOS NO REPOSITÓRIO",
                                            style: TextStyle(
                                                fontFamily: 'ChewyRegular',
                                                fontSize: 18,
                                                color: Color(0xFFC75555)),
                                          ),
                                        ),
                                        // Center(
                                        //   child: Text(
                                        //     "$loginSaved",
                                        //     style: TextStyle(
                                        //         fontFamily: 'ChewyRegular',
                                        //         fontSize: 18,
                                        //         color: Color(0xFFC75555)),
                                        //   ),
                                        // ),
                                        Center(
                                          child: Column(
                                            children: [
                                              ..._getFriends(),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              child: SizedBox(
                                                width: 30,
                                              ),
                                            )
                                          ],
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Projeto:",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'ChewyRegular',
                                                        fontSize: 18,
                                                        color:
                                                            Color(0xFFC75555)),
                                                  ),
                                                  DropdownButton<String>(
                                                    value: dropProjeto,
                                                    icon: const Icon(
                                                        Icons.arrow_downward),
                                                    iconSize: 24,
                                                    elevation: 16,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFFC75555)),
                                                    underline: Container(
                                                      height: 2,
                                                      color: Color(0xFFC75555),
                                                    ),
                                                    onChanged:
                                                        (String newValue) {
                                                      setState(() {
                                                        dropProjeto = newValue;
                                                      });
                                                    },
                                                    items: <String>[
                                                      'MIT',
                                                      'TG'
                                                    ].map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ],

                                                ///
                                                ///
                                                ///
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Curso:",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'ChewyRegular',
                                                        fontSize: 18,
                                                        color:
                                                            Color(0xFFC75555)),
                                                  ),
                                                  DropdownButton<String>(
                                                    value: dropCurso,
                                                    icon: const Icon(
                                                        Icons.arrow_downward),
                                                    iconSize: 24,
                                                    elevation: 16,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFFC75555)),
                                                    underline: Container(
                                                      height: 2,
                                                      color: Color(0xFFC75555),
                                                    ),
                                                    onChanged:
                                                        (String newValue) {
                                                      setState(() {
                                                        dropCurso = newValue;
                                                      });
                                                    },
                                                    items: <String>[
                                                      'ADS',
                                                      'AGRO',
                                                      'COMEX',
                                                      'GPI'
                                                    ].map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Ciclo:  ",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'ChewyRegular',
                                                        fontSize: 18,
                                                        color:
                                                            Color(0xFFC75555)),
                                                  ),
                                                  DropdownButton<String>(
                                                    value: dropCiclo,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFFC75555)),
                                                    underline: Container(
                                                      height: 2,
                                                      color: Color(0xFFC75555),
                                                    ),
                                                    onChanged:
                                                        (String newValue) {
                                                      setState(() {
                                                        dropCiclo = newValue;
                                                      });
                                                    },
                                                    items: <String>[
                                                      '1',
                                                      '2',
                                                      '3',
                                                      '4',
                                                      '5',
                                                      '6'
                                                    ].map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: TextFormField(
                                                        controller:
                                                            myControllerT,
                                                        obscureText: false,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                        cursorColor:
                                                            Color(0xFFC75555),
                                                        decoration:
                                                            InputDecoration(
                                                                enabledBorder:
                                                                    UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Color(0xFFC75555)),
                                                                ),
                                                                focusedBorder: UnderlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xFFC75555))),
                                                                labelText:
                                                                    "Titulo: ",
                                                                fillColor: Color(
                                                                    0xFFC75555),
                                                                labelStyle: TextStyle(
                                                                    fontFamily:
                                                                        'ChewyRegular',
                                                                    fontSize:
                                                                        20.0,
                                                                    color: Color(
                                                                        0xFFC75555)),
                                                                hintText:
                                                                    "Insira o Titulo do Trabalho:"))),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: TextFormField(
                                                        controller:
                                                            myControllerO,
                                                        obscureText: false,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                        cursorColor:
                                                            Color(0xFFC75555),
                                                        decoration:
                                                            InputDecoration(
                                                                enabledBorder:
                                                                    UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Color(0xFFC75555)),
                                                                ),
                                                                focusedBorder: UnderlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xFFC75555))),
                                                                labelText:
                                                                    "Orientador: ",
                                                                fillColor: Color(
                                                                    0xFFC75555),
                                                                labelStyle: TextStyle(
                                                                    fontFamily:
                                                                        'ChewyRegular',
                                                                    fontSize:
                                                                        20.0,
                                                                    color: Color(
                                                                        0xFFC75555)),
                                                                hintText:
                                                                    "Insira o nome do Orientador"))),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: TextFormField(
                                                        controller:
                                                            myControllerR,
                                                        obscureText: false,
                                                        keyboardType:
                                                            TextInputType
                                                                .multiline,
                                                        maxLines: 6,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                        cursorColor:
                                                            Color(0xFFC75555),
                                                        decoration:
                                                            InputDecoration(
                                                                enabledBorder:
                                                                    UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Color(0xFFC75555)),
                                                                ),
                                                                focusedBorder:
                                                                    UnderlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                            color: Color(
                                                                                0xFFC75555))),
                                                                labelText:
                                                                    "Resumo: ",
                                                                fillColor: Color(
                                                                    0xFFC75555),
                                                                labelStyle: TextStyle(
                                                                    fontFamily:
                                                                        'ChewyRegular',
                                                                    fontSize:
                                                                        20.0,
                                                                    color: Color(
                                                                        0xFFC75555)),
                                                                hintText:
                                                                    "Insira um resumo de no máximo 200 palavras"))),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator
                                                          .pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    RepoPage()),
                                                        (Route<dynamic>
                                                                route) =>
                                                            false,
                                                      );
                                                    },
                                                    child: Text('Cancelar'),
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .resolveWith<
                                                                  Color>(
                                                        (Set<MaterialState>
                                                            states) {
                                                          return Color(
                                                              0xFFC75555); // Use the component's default.
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      final String Dev1 =
                                                          myController.text;
                                                      final String Dev2 =
                                                          myController1.text;
                                                      final String Dev3 =
                                                          myController2.text;
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            content: Text(
                                                                "Dados Atualizados com Sucesso"),
                                                          );
                                                        },
                                                      );
                                                      uploadDados();
                                                      Future.delayed(Duration(
                                                              seconds: 1))
                                                          .then((value) =>
                                                              Navigator
                                                                  .pushAndRemoveUntil(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            RepoPage()),
                                                                (Route<dynamic>
                                                                        route) =>
                                                                    false,
                                                              ));
                                                    },
                                                    child: Text('Atualizar'),
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .resolveWith<
                                                                  Color>(
                                                        (Set<MaterialState>
                                                            states) {
                                                          return Color(
                                                              0xFFC75555); // Use the component's default.
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(child: Text('Nenhum dado para mostrar!'));
              }
            } else {
              return Center(
                  child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFFC75555))));
            }
          },
        ));
  }

  uploadDados() async {
    String uploadurl =
        "https://rumanian-straighten.000webhostapp.com/repo/atualizaTrabalho.php";
    //     "http://192.168.0.101:80/repo/upardados.php";
    String dev1 = myController.text;
    String dev2 = myController1.text;
    String dev3 = myController2.text;
    String curso = dropCurso;
    String ciclo = dropCiclo;
    String titulo = myControllerT.text;
    String orientador = myControllerO.text;
    String resumo = myControllerR.text;

    String id = widget.id2;
    Map data = {
      "id": id,
      "desenvolvedor1": dev1,
      "desenvolvedor2": dev2,
      "desenvolvedor3": dev3,
      "curso": curso,
      "ciclo": ciclo,
      "titulo": titulo,
      "orientador": orientador,
      "resumo": resumo,
      "projeto": dropProjeto
    };
    var respBody = jsonEncode(data);
    print(respBody);

    var res = await http
        .post(Uri.parse(uploadurl),
            headers: {"Accept": "application/json"}, body: respBody)
        .catchError((e) {
      print('O erro e: $e');
    });

    if (res.statusCode == 200) {
      print('dados enviados');
      log(res.body);
      //print response from server
    } else {
      print("Erro Durante a Conexão com o Servidor.");
    }
  }

  static List<String> friendsList = [null];
  List<Widget> _getFriends() {
    List<Widget> friendsTextFieldsList = [];
    for (int i = 0; i < friendsList.length; i++) {
      if (i == 0) {
        friendsTextFieldsList.add(
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    obscureText: false,
                    controller: myController,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black),
                    cursorColor: Color(0xFFC75555),
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFC75555)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFC75555))),
                        labelText: "Desenvolvedor ${i + 1}:",
                        fillColor: Color(0xFFC75555),
                        labelStyle: TextStyle(
                            fontFamily: 'ChewyRegular',
                            fontSize: 20.0,
                            color: Color(0xFFC75555)),
                        hintText: ""),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                if (i < 2) _addRemoveButton(i == friendsList.length - 1, i),
              ],
            ),
          ),
        );
      }
      if (i == 1) {
        friendsTextFieldsList.add(
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    obscureText: false,
                    controller: myController1,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black),
                    cursorColor: Color(0xFFC75555),
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFC75555)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFC75555))),
                        labelText: "Desenvolvedor ${i + 1}:",
                        fillColor: Color(0xFFC75555),
                        labelStyle: TextStyle(
                            fontFamily: 'ChewyRegular',
                            fontSize: 20.0,
                            color: Color(0xFFC75555)),
                        hintText: ""),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                if (i < 2) _addRemoveButton(i == friendsList.length - 1, i),
              ],
            ),
          ),
        );
      }
      if (i == 2) {
        friendsTextFieldsList.add(
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    obscureText: false,
                    controller: myController2,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black),
                    cursorColor: Color(0xFFC75555),
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFC75555)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFC75555))),
                        labelText: "Desenvolvedor ${i + 1}:",
                        fillColor: Color(0xFFC75555),
                        labelStyle: TextStyle(
                            fontFamily: 'ChewyRegular',
                            fontSize: 20.0,
                            color: Color(0xFFC75555)),
                        hintText: ""),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                if (i < 2) _addRemoveButton(i == friendsList.length - 1, i),
              ],
            ),
          ),
        );
      }
    }
    return friendsTextFieldsList;
  }

  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all friends textfields
          friendsList.insert(0, null);
        } else
          friendsList.removeAt(index);
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Color(0xFFC75555) : Color(0xFFC75555),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}

Future<String> verificaLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  //Return String
  return prefs.getString('login');
}

Future<dynamic> getCompanehiros(var id) async {
  var response = await Dio().post(
    'https://rumanian-straighten.000webhostapp.com/repo/update.php',
    data: {'id': id},
    options: Options(contentType: 'application/json'),
  );
  print(response.data);
  return response.data;
}

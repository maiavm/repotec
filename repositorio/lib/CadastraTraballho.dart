//import 'dart:convert';
//import 'dart:io';
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

class CadProj extends StatefulWidget {
  @override
  _CadProjState createState() => _CadProjState();
}

class _CadProjState extends State<CadProj> {
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
  String dropCurso = 'ADS';
  String dropCiclo = '1';
  String dropProjeto = 'TG';
  String loginSaved;

  var itens = [];

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
          "CADASTRA PROJETO",
          style: TextStyle(fontFamily: 'ChewyRegular', fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFC75555),
        actions: <Widget>[],
      ),
      body: Column(
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
                                  "POSTAR NO REPOSITÓRIO",
                                  style: TextStyle(
                                      fontFamily: 'ChewyRegular',
                                      fontSize: 18,
                                      color: Color(0xFFC75555)),
                                ),
                              ),
                              Center(
                                child: Text(
                                  "$loginSaved",
                                  style: TextStyle(
                                      fontFamily: 'ChewyRegular',
                                      fontSize: 18,
                                      color: Color(0xFFC75555)),
                                ),
                              ),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Projeto:",
                                          style: TextStyle(
                                              fontFamily: 'ChewyRegular',
                                              fontSize: 18,
                                              color: Color(0xFFC75555)),
                                        ),
                                        DropdownButton<String>(
                                          value: dropProjeto,
                                          icon:
                                              const Icon(Icons.arrow_downward),
                                          iconSize: 24,
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Color(0xFFC75555)),
                                          underline: Container(
                                            height: 2,
                                            color: Color(0xFFC75555),
                                          ),
                                          onChanged: (String newValue) {
                                            setState(() {
                                              dropProjeto = newValue;
                                            });
                                          },
                                          items: <String>[
                                            'MIT',
                                            'TG',
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
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
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Curso:",
                                          style: TextStyle(
                                              fontFamily: 'ChewyRegular',
                                              fontSize: 18,
                                              color: Color(0xFFC75555)),
                                        ),
                                        DropdownButton<String>(
                                          menuMaxHeight: 1000,
                                          value: dropCurso,
                                          icon:
                                              const Icon(Icons.arrow_downward),
                                          iconSize: 24,
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Color(0xFFC75555)),
                                          underline: Container(
                                            height: 2,
                                            color: Color(0xFFC75555),
                                          ),
                                          onChanged: (String newValue) {
                                            setState(() {
                                              dropCurso = newValue;
                                            });
                                          },
                                          items: <String>[
                                            'ADS',
                                            'AGRO',
                                            'COMEX',
                                            'GPI'
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
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
                                              fontFamily: 'ChewyRegular',
                                              fontSize: 18,
                                              color: Color(0xFFC75555)),
                                        ),
                                        DropdownButton<String>(
                                          menuMaxHeight: 1000,
                                          value: dropCiclo,
                                          style: const TextStyle(
                                              color: Color(0xFFC75555)),
                                          underline: Container(
                                            height: 2,
                                            color: Color(0xFFC75555),
                                          ),
                                          onChanged: (String newValue) {
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
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
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
                                          controller: myControllerT,
                                          obscureText: false,
                                          keyboardType: TextInputType.text,
                                          style: TextStyle(color: Colors.black),
                                          cursorColor: Color(0xFFC75555),
                                          decoration: InputDecoration(
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFFC75555)),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color(
                                                              0xFFC75555))),
                                              labelText: "Titulo: ",
                                              fillColor: Color(0xFFC75555),
                                              labelStyle: TextStyle(
                                                  fontFamily: 'ChewyRegular',
                                                  fontSize: 20.0,
                                                  color: Color(0xFFC75555)),
                                              hintText:
                                                  "Insira o Titulo do Trabalho:"),
                                        ),
                                      ),
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
                                              controller: myControllerO,
                                              obscureText: false,
                                              keyboardType: TextInputType.text,
                                              style: TextStyle(
                                                  color: Colors.black),
                                              cursorColor: Color(0xFFC75555),
                                              decoration: InputDecoration(
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFC75555)),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xFFC75555))),
                                                  labelText: "Orientador: ",
                                                  fillColor: Color(0xFFC75555),
                                                  labelStyle: TextStyle(
                                                      fontFamily:
                                                          'ChewyRegular',
                                                      fontSize: 20.0,
                                                      color: Color(0xFFC75555)),
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
                                              controller: myControllerR,
                                              obscureText: false,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              maxLines: 6,
                                              style: TextStyle(
                                                  color: Colors.black),
                                              cursorColor: Color(0xFFC75555),
                                              decoration: InputDecoration(
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFC75555)),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xFFC75555))),
                                                  labelText: "Resumo: ",
                                                  fillColor: Color(0xFFC75555),
                                                  labelStyle: TextStyle(
                                                      fontFamily:
                                                          'ChewyRegular',
                                                      fontSize: 20.0,
                                                      color: Color(0xFFC75555)),
                                                  hintText:
                                                      "Insira um resumo de no máximo 200 palavras"))),
                                    ],
                                  ),
                                ),
                              ),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () => _openFileExplorer(),
                                  child: Text('Anexar PDF'),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        return Color(
                                            0xFFC75555); // Use the component's default.
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Builder(
                                        builder: (BuildContext context) =>
                                            _loadingPath
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 0),
                                                    child:
                                                        const CircularProgressIndicator(),
                                                  )
                                                : _directoryPath != null
                                                    ? ListTile(
                                                        title: const Text(
                                                            'Pasta do Arquivo'),
                                                        subtitle: Text(
                                                            _directoryPath),
                                                      )
                                                    : _paths != null
                                                        ? Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 0),
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.10,
                                                            child: Scrollbar(
                                                                child: ListView
                                                                    .separated(
                                                              itemCount: _paths !=
                                                                          null &&
                                                                      _paths
                                                                          .isNotEmpty
                                                                  ? _paths
                                                                      .length
                                                                  : 1,
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                final bool
                                                                    isMultiPath =
                                                                    _paths !=
                                                                            null &&
                                                                        _paths
                                                                            .isNotEmpty;
                                                                final String name = 'File $index: ' +
                                                                    (isMultiPath
                                                                        ? _paths.map((e) => e.name).toList()[
                                                                            index]
                                                                        : _fileName ??
                                                                            '...');
                                                                final path = _paths
                                                                    .map((e) =>
                                                                        e.path)
                                                                    .toList()[
                                                                        index]
                                                                    .toString();

                                                                return ListTile(
                                                                  title: Text(
                                                                    name,
                                                                  ),
                                                                  subtitle:
                                                                      Text(
                                                                          path),
                                                                );
                                                              },
                                                              separatorBuilder:
                                                                  (BuildContext
                                                                              context,
                                                                          int index) =>
                                                                      const Divider(),
                                                            )),
                                                          )
                                                        : const SizedBox(),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.close),
                                      color: Color(0xFFC75555),
                                      onPressed: () =>
                                          null // _limpaArquivosTemporarios(),
                                      ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RepoPage()),
                                              (Route<dynamic> route) => false,
                                            );
                                          },
                                          child: Text('Cancelar'),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .resolveWith<Color>(
                                              (Set<MaterialState> states) {
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
                                                  content: AlertDialog(
                                                    content: Text(
                                                        "Upload efetuado com Sucesso"),
                                                  ),
                                                );
                                              },
                                            );
                                            uploadDados();
                                            uploadFile();
                                          },
                                          child: Text('Publicar'),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .resolveWith<Color>(
                                              (Set<MaterialState> states) {
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
      ),
    );
  }

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);

    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        withData: true,
        allowMultiple: _multiPick,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '')?.split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Operação não Suportada" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      Uint8List _fileBytes = _paths.first.bytes;
      print(_paths.first.toString());
      print(_fileBytes);
      print(_paths.first);
      print(_paths.first.extension);

      _fileName = _paths != null ? _paths.map((e) => e.name).toString() : '...';
      print(_fileName);
    });
  }

  uploadDados() async {
    String uploadurl =
        "https://rumanian-straighten.000webhostapp.com/repo/upardados.php";
    //     "http://192.168.0.101:80/repo/upardados.php";
    String dev1 = myController.text;
    String dev2 = myController1.text;
    String dev3 = myController2.text;
    String curso = dropCurso;
    String ciclo = dropCiclo;
    String titulo = myControllerT.text;
    String orientador = myControllerO.text;
    String resumo = myControllerR.text;
    String pdf = _fileName;
    Map data = {
      "desenvolvedor1": dev1,
      "desenvolvedor2": dev2,
      "desenvolvedor3": dev3,
      "curso": curso,
      "ciclo": ciclo,
      "titulo": titulo,
      "orientador": orientador,
      "resumo": resumo,
      "pdf": pdf,
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

  uploadFile() async {
    String uploadurl =
        "https://rumanian-straighten.000webhostapp.com/repo/upar.php";

    FormData formdata = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        _paths.first.path,
        filename: basename(_fileName),
        //show only filename from path
      ),
    });

    response = await dio.post(
      uploadurl,
      data: formdata,
      options: Options(contentType: 'application/json;charset=UTF-8'),
      onSendProgress: (int sent, int total) {
        String percentage = (sent / total * 100).toStringAsFixed(2);
        setState(() {
          progress = "$sent" +
              " Bytes of " "$total Bytes - " +
              percentage +
              " % uploaded";
          //update the progress
        });
      },
    );

    if (response.statusCode == 200) {
      //print(response.toString());
      print('deu bao');
      //print response from server
    } else {
      print("Erro Durante a Conexão com o Servdor.");
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

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:repositorio/AbrirPDF.dart';
//import 'package:repositorio/TelaLogin.dart';
import 'package:repositorio/repo.dart';
import 'package:repositorio/updateTrabalho.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable   nao faz sentrido jsjsjsjsjsj
class TrabalhosPage extends StatefulWidget {
  final int trabalhoID;
  final String curso;

  final bool online = true;

  const TrabalhosPage({Key key, this.trabalhoID, this.curso}) : super(key: key);

  @override
  _TrabalhosPageState createState() => _TrabalhosPageState();
}

class _TrabalhosPageState extends State<TrabalhosPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      appBar: AppBar(
        title: Text(
          widget.curso,
          style: TextStyle(fontFamily: 'ChewyRegular', fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFC75555),

        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          tooltip: 'Voltar',
          onPressed: () {
            Navigator.pop(context);
            //createAlertDialog(context);
          },
        ), //IconButton
      ),
      body: FutureBuilder(
        future: getRepo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              String nome = snapshot.data[widget.trabalhoID]['titulo'];
              bool online = true;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Center(
                        child: Icon(
                          Icons.picture_as_pdf_outlined,
                          //color: color,
                          size: 200,
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          nome,
                          style: TextStyle(
                            fontFamily: 'ChewyRegular',
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    Container(
                        child: Padding(
                      padding: const EdgeInsets.only(bottom: 15, top: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      snapshot.data[widget.trabalhoID]
                                          ['orientador'],
                                      style: TextStyle(
                                          fontFamily: 'ChewyRegular',
                                          color: Colors.grey[900]),
                                    )),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      snapshot.data[widget.trabalhoID]['curso'],
                                      style: TextStyle(
                                          fontFamily: 'ChewyRegular',
                                          color: Colors.grey[900]),
                                    )),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      snapshot.data[widget.trabalhoID]['ciclo'],
                                      style: TextStyle(
                                          fontFamily: 'ChewyRegular',
                                          color: Colors.grey[900]),
                                    )),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      snapshot.data[widget.trabalhoID]
                                          ['projeto'],
                                      style: TextStyle(
                                          fontFamily: 'ChewyRegular',
                                          color: Colors.grey[900]),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: Text(
                                snapshot.data[widget.trabalhoID]['descri'],
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontFamily: 'ChewyRegular',
                                    color: Colors.grey[600]),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: FloatingActionButton.extended(
                          heroTag: 'abre',
                          label: const Text(
                            'Abrir PDF',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'ChewyRegular',
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => (ViewPdf(
                                    pdf: (snapshot.data[widget.trabalhoID]
                                        ['pdf']),
                                  )),
                                ));
                          },
                          icon: const Icon(Icons.launch),
                          backgroundColor: Color(0xFFC75555),
                        ),
                      ),
                    ),
                    Container(child: Builder(builder: (context) {
                      if (loginSaved != null) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: FloatingActionButton.extended(
                                        heroTag: 'atualiza',
                                        label: const Text(
                                          'Atualiza PDF',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'ChewyRegular',
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          UpdateProj(
                                                            id: widget
                                                                .trabalhoID
                                                                .toString(),
                                                            id2: snapshot.data[
                                                                    widget
                                                                        .trabalhoID]
                                                                ['id'],
                                                          )));
                                        },
                                        icon: const Icon(Icons.launch),
                                        backgroundColor: Color(0xFFC75555),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: FloatingActionButton.extended(
                                        heroTag: 'deleta',
                                        label: const Text(
                                          'Excluir PDF',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'ChewyRegular',
                                          ),
                                        ),
                                        onPressed: () {
                                          () => {
                                                //_PopUpExcluiTrabalho(context)
                                                _displayTextInputDialog(context)
                                              };
                                        },
                                        icon: const Icon(Icons.launch),
                                        backgroundColor: Color(0xFFC75555),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      } else
                        return Text('');
                    })),
                  ],
                ),
              );
            } else {
              return Center(child: Text('Nenhum dado para mostar'));
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

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Pesquisar'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  // valueText = value;
                });
              },
              controller: null, //_textFieldController,
              decoration: InputDecoration(hintText: "Insira sua busca aqui:"),
            ),
            actions: <Widget>[
              FlatButton(
                color: Color(0xFFC75555),
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Color(0xFFC75555),
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    //codeDialog = valueText;
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  // Future<void> _PopUpExcluiTrabalho(BuildContext context) async {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text('Pesquisar'),
  //           actions: <Widget>[
  //             FloatingActionButton.extended(
  //               backgroundColor: Color(0xFFC75555),
  //               onPressed: () {
  //                 setState(() {
  //                   Navigator.pop(context);
  //                 });
  //               },
  //               label: Text('CANCEL'),
  //             ),
  //             FloatingActionButton.extended(
  //               backgroundColor: Color(0xFFC75555),
  //               onPressed: () {
  //                 setState(() {
  //                   Navigator.pop(context);
  //                 });
  //               },
  //               label: Text('Cancelar'),
  //             ),
  //           ],
  //         );
  //       });
  // }
}

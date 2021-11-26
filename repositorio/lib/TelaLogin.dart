import 'dart:convert';
import 'dart:developer';
//import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:repositorio/CadastraTraballho.dart';
import 'package:repositorio/repo.dart';

import 'package:shared_preferences/shared_preferences.dart';

class TelaLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginC = TextEditingController();
    final senhaC = TextEditingController();
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    Future<String> _sessao;
    String retorno = "";

    //
    //
    //
    retornaErro() {
      setState(() {
        Text(
          'teste',
          style: TextStyle(color: Colors.white),
        );
      });
    }

    Future<void> _SalvaUser() async {
      final SharedPreferences prefs = await _prefs;
      final String sessaoL = prefs.getString('login');

      setState(() {
        _sessao = prefs.setString("login", sessaoL).then((bool success) {
          return sessaoL;
        });
      });
    }

    @override
    void initState() {
      _sessao = _prefs.then((SharedPreferences prefs) {
        return (prefs.getString('login') ?? 0);
      });
    }

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            color: Color(0xFFC75555),
            icon: const Icon(Icons.account_circle_outlined),
            tooltip: 'Perfil',
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => (CadProj()),
                  ));
            },
          ),
        ],
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "LOGIN",
            style: TextStyle(
              color: Color(0xFFC75555),
              fontFamily: 'ChewyRegular',
              fontSize: 36,
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Container(
          margin: EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFFC75555),
          ),
          child: Expanded(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "ADMINISTRAÇÃO",
                      style: TextStyle(
                          fontFamily: 'ChewyRegular',
                          fontSize: 18,
                          color: Colors.white),
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
                            controller: loginC,
                            obscureText: false,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              labelText: "Login: ",
                              fillColor: Colors.white,
                              labelStyle: TextStyle(
                                  fontFamily: 'ChewyRegular',
                                  fontSize: 20.0,
                                  color: Colors.white),
                              hintText: "Insira o seu Login",
                              hintStyle: TextStyle(color: Colors.white),
                            ),
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
                            controller: senhaC,
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              labelText: "Senha: ",
                              fillColor: Colors.white,
                              labelStyle: TextStyle(
                                  fontFamily: 'ChewyRegular',
                                  fontSize: 20.0,
                                  color: Colors.white),
                              hintText: "Insira a sua Senha",
                              hintStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                      padding: EdgeInsets.only(top: 3, bottom: 3),
                      child: retornaErro()),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () => {
                      logar(loginC.text, senhaC.text, context, _sessao, retorno)
                    },
                    child: Text(
                      'Entrar',
                      style: TextStyle(color: Color(0xFFC75555)),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Colors.white; // Use the component's default.
                        },
                      ),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: TextButton(
                              child: Text(
                                "Cancelar",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          (RepoPage())),
                                );
                              },
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
                            child: TextButton(
                              child: Text(
                                "Esqueci a senha",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setState(Null Function() param0) {}
}

logar(
  String loginC,
  String senhaC,
  context,
  sessao,
  retornaErro,
) async {
  String uploadurl =
      "https://rumanian-straighten.000webhostapp.com/repo/login.php";
  //     "http://192.168.0.101:80/repo/upardados.php";
  String login = loginC;
  String senha = senhaC;
  String retornaErroText = "";

  Map data = {"login": login, "senha": senha};
  var respBody = jsonEncode(data);
  print(respBody);

  var res = await http
      .post(Uri.parse(uploadurl),
          headers: {"Accept": "application/json"}, body: respBody)
      .catchError((e) {
    print('O erro e: $e');
  });

  if (res.statusCode == 200) {
    // print('dados enviados');

    //log(res.body.toString());

    String logado = jsonDecode(res.body);
    Map<String, dynamic> session = jsonDecode(respBody);
    log(session.toString());
    if (logado == "1") {
      log('logado com sucesso');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('login', data['login'].toString());

      //Return String
      String stringValue = prefs.getString('login');
      print("O login salvo na session é: " + stringValue);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) => (RepoPage())),
      );
      return;
    } else {
      return retornaErroText = 'usuário ou senha incorretos';
    }
  } else {
    print("Erro Durante a Conexão com o Servidor.");
  }
}

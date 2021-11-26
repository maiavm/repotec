import 'package:flutter/material.dart';
import 'package:repositorio/ajuda.dart';
import 'package:repositorio/calendario.dart';
import 'package:repositorio/grade.dart';
import 'package:repositorio/main.dart';
import 'package:repositorio/monitoria.dart';
import 'package:repositorio/repo.dart';

class Estagios extends StatelessWidget {
  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("EM BREVE"),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      body: Center(
        child: Container(
          color: Colors.green[100],
          child: Text(
            "OLA MAE",
            style: TextStyle(color: Color(0xff0000CD)),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          "CENTRAL DE ESTÁGIOS",
          style: TextStyle(fontFamily: 'ChewyRegular', fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFC75555),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            tooltip: 'Perfil',
            onPressed: () {
              createAlertDialog(context);
            },
          ),
        ],
      ),
      drawer: new Drawer(
          child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Color(0xFFC75555)),
            currentAccountPicture: new CircleAvatar(
              backgroundImage: new NetworkImage(
                  "https://icon-library.com/images/user-icon-image/user-icon-image-24.jpg"),
            ),
            accountName: new Text("Nome"),
            accountEmail: new Text("Email"),
          ),
          ListTile(
            leading: Icon(
              Icons.message_outlined,
            ),
            title: Text(
              "Mural",
              style: TextStyle(color: Colors.grey[600]),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (BuildContext context) => (Home())),
              );
              //createAlertDialog(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.archive_outlined,
            ),
            title: Text(
              "Repositório",
              style: TextStyle(color: Colors.grey[600]),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => (RepoPage())),
              );
              //createAlertDialog(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today_outlined),
            title: Text(
              "Calendário",
              style: TextStyle(color: Colors.grey[600]),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => (Calendario())),
              );
              //createAlertDialog(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.grid_on_outlined),
            title: Text(
              "Grade do Curso",
              style: TextStyle(color: Colors.grey[600]),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (BuildContext context) => (Grade())),
              );
              //createAlertDialog(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.group_outlined),
            title: Text(
              "Monitoria",
              style: TextStyle(color: Colors.grey[600]),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => (Monitoria())),
              );
              //createAlertDialog(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.work_outline),
            title: Text(
              "Central de Estágios",
              style: TextStyle(color: Colors.grey[600]),
            ),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text(
              "Informações e Ajuda",
              style: TextStyle(color: Colors.grey[600]),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (BuildContext context) => (Ajuda())),
              );
              //createAlertDialog(context);
            },
          ),
        ],
      )),
    );
  }
}

// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

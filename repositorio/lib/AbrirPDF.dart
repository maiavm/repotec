//import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';

class ViewPdf extends StatefulWidget {
  final String pdf;

  const ViewPdf({Key key, this.pdf}) : super(key: key);
  @override
  _ViewPdfState createState() => _ViewPdfState();
}

class _ViewPdfState extends State<ViewPdf> {
  PdfViewerController _pdfViewerController;

  telasegura() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
    telasegura();
  }

  PdfTextSearchResult _searchResult;
  TextEditingController _textFieldController = TextEditingController();
  bool tocado = false;

  @override
  Widget build(BuildContext context) {
    var pdf = widget.pdf;
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: SizedBox(
            width: 600,
            child: TextField(
              controller: _textFieldController,
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
                // labelText: "Pesquise uma palavra: ",
                fillColor: Colors.white,
                labelStyle: TextStyle(
                    fontFamily: 'ChewyRegular',
                    fontSize: 20.0,
                    color: Colors.white),
                hintText: "Pesquise uma palavra:",
                hintStyle: TextStyle(color: Colors.white),
              ),
              onChanged: (value) async {
                _searchResult = await _pdfViewerController?.searchText(
                  _textFieldController.text,
                  // searchOption: null
                );
                setState(() {});
              },
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          tooltip: 'Voltar',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFFC75555),
        actions: <Widget>[
          SizedBox(
            width: 100,
            child: Row(
              children: [
                Visibility(
                  visible: _searchResult?.hasResult ?? false,
                  child: IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_up,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _searchResult?.previousInstance();
                    },
                  ),
                ),
                Visibility(
                  visible: _searchResult?.hasResult ?? false,
                  child: IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _searchResult?.nextInstance();
                    },
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: _searchResult?.hasResult ?? false,
            child: IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _searchResult.clear();
                });
              },
            ),
          ),
        ],
      ),
      body: SfPdfViewer.network(
          'https://rumanian-straighten.000webhostapp.com/repo/PDFs/$pdf',
          controller: _pdfViewerController,
          searchTextHighlightColor: Color(0xFFC75555)),
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
                  valueText = value;
                });
              },
              controller: _textFieldController,
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
                    codeDialog = valueText;
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  String codeDialog;
  String valueText;
}

/*  @override
  Widget build(BuildContext context) {
    int id = widget.id;
    print('/////////// $id');
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'trabalho',
            style: TextStyle(fontFamily: 'ChewyRegular', fontSize: 30),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFFC75555),
        ),
        body: PDF().cachedFromUrl(
          'https://rumanian-straighten.000webhostapp.com/repo/PDFs/$id.pdf',
          placeholder: (progress) => Center(child: Text('$progress %')),
          errorWidget: (error) => Center(
            child: Text(
              error.toString(),
            ),
          ),
        ));
  }

} */

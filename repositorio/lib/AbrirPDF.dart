//import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  PdfTextSearchResult _searchResult;
  TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var pdf = widget.pdf;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          tooltip: 'Voltar',
          onPressed: () {
            Navigator.pop(context);
            //createAlertDialog(context);
          },
        ), //IconB
        title: Text(
          'trabalho',
          style: TextStyle(fontFamily: 'ChewyRegular', fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFC75555),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.keyboard_arrow_up,
              color: Colors.white,
            ),
            onPressed: () {
              _pdfViewerController.previousPage();
            },
          ),
          IconButton(
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
            onPressed: () {
              _pdfViewerController.nextPage();
            },
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () => {
              _displayTextInputDialog(context),
            },
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
      body: SfPdfViewer.network(
          'https://rumanian-straighten.000webhostapp.com/repo/PDFs/$pdf',
          controller: _pdfViewerController,
          searchTextHighlightColor: Colors.yellow),
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

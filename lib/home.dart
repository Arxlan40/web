import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HomePage extends StatefulWidget {
  @override
  _WebViewWebPageState createState() => _WebViewWebPageState();
}

class _WebViewWebPageState extends State<HomePage> {

  bool sidebar = false;

  Future<bool> _onBack() async {
    bool goBack;
    var value = await webView.canGoBack();
    if (value) {
      webView.goBack();
      return false;
    } else {
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title:
              new Text('Confirmation ', style: TextStyle(color: Colors.orangeAccent)),
          // Are you sure?
          content: new Text('Do you want exit app ? '),
          // Do you want to go back?
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                setState(() {
                  goBack = false;
                });
              },
              child: new Text('No'),
            ),
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  goBack = true;
                });
              },
              child: new Text('Yes'), // Yes
            ),
          ],
        ),
      );
      if (goBack) Navigator.pop(context); // If user press Yes pop the page
      return goBack;
    }
  }

  Future<void>  _refresh() async{
       webView.reload();


  }
  var URL = "https://rnbloveradio.com/";
  double progress = 0;
  InAppWebViewController webView;

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onBack,
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //     child: Icon(Icons.refresh),
        //     onPressed: (){
        //   _refresh();
        // }),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Center(child: Text("rnbloveradio")),
        ),
        body: Container(
child: Column(
                children: <Widget>[
          (progress != 1.0)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey[200],
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.redAccent)),
                     // Container(
                     //        height: _height / 1.1365,
                     //        width: _width,
                     //        child:
                     //            Center(child: Image.asset('assets/splash.png')))
                  ],
                )
              : null, //
          // Should be removed while showing
          Expanded(
            child: Container(
              child: InAppWebView(
                initialUrl: URL,
                initialHeaders: {},
                onWebViewCreated: (InAppWebViewController controller) {
                  webView = controller;
                },
                onLoadStart: (InAppWebViewController controller, String url) {},
                onLoadStop:
                    (InAppWebViewController controller, String url) async {
                  setState(() {
                    sidebar = true;
                  });
                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
              ),
            ),
          )
        ].where((Object o) => o != null).toList())),
      ),
    ); //Remove null widgets
  }
}

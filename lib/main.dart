import 'package:flutter/material.dart';
import 'package:hyper_sdk_flutter/hyper_sdk_flutter.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  initiateCheckout(requestId) async{
    final juspay = Juspay(
        onShowLoader: () {
          // show the loader
        },
        onHideLoader: () {
          // stop the processing loader
        },
        onInitiateResult: () {
          // handle initiate response -- log it
          // do what you want here
        },
        onProcessResult: (){
          // handle process response -- log it
          // do what you want here
        });

    var initiatePayload = {
      "requestId": requestId,
      "service": "in.juspay.hyperpay",
      "payload": {
        "action": "initiate",
        "merchantId": "<Merchant Id>",
        "clientId": "<Client Id>",
        "environment": "sandbox"
      }
    };

    await juspay.initiate(initiatePayload);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: Text(
          'You have to push to open juspay',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var uuid = const Uuid();
          var requestUuid = uuid.v4();
          initiateCheckout(requestUuid);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

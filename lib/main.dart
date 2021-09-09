import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/services.dart';

void main() {
  AwesomeNotifications().initialize('resource://drawable/res_app_icon', [
    NotificationChannel(
      channelKey: 'base_notification',
      channelName: 'Base Notification',
      channelDescription: 'Base Notification',
      defaultColor: Color(0xff9d50dd),
      ledColor: Colors.white,
      playSound: false,
    )
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('app.channel.shared.data');
  String dataShared = 'No data yet';

  @override
  void initState() {
    super.initState();
    getSharedText();
  }

  void getSharedText() async {
    var sharedData = await platform.invokeMethod('getSharedText');
    print('shared_data: $sharedData');
    if (sharedData != null) {
      _createNotification(sharedData);
      setState(() {
        dataShared = sharedData;
      });
    }
  }

  void _createNotification([String messageBody = 'Simple body']) {
    AwesomeNotifications().createNotification(content: NotificationContent(
      id: 10,
      channelKey: 'base_notification',
      title: 'TODO',
      body: messageBody,
      locked: true,
      showWhen: true,
    ));
  }

  void _incrementCounter() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(dataShared),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNotification,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

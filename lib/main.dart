import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() {
  AwesomeNotifications().initialize('resource://drawable/res_app_icon', [
    NotificationChannel(
      channelKey: 'base_notification',
      channelName: 'Base Notification',
      channelDescription: 'Base Notification',
      defaultColor: Color(0xff9d50dd),
      ledColor: Colors.white,
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
  int _counter = 1;

  void _createNotification() {
    AwesomeNotifications().createNotification(content: NotificationContent(
      id: 10,
      channelKey: 'base_notification',
      title: 'Simple Notification',
      body: 'Simple body',
    ));
  }

  void _incrementCounter() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    // setState(() {
    //   _counter++;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNotification,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
